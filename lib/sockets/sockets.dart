import 'package:echoes/models/chat.dart';
import 'package:echoes/models/message.dart';
import 'package:echoes/models/user.dart';
import 'package:echoes/navigator.dart';
import 'package:echoes/store/actions/chats.dart';
import 'package:echoes/store/actions/dialog_creation.dart';
import 'package:echoes/store/actions/messages.dart';
import 'package:echoes/store/actions/users.dart';
import 'package:echoes/utils/constants.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:echoes/store/store.dart';


PhoenixSocket socket = null;
PhoenixChannel userChannel = null;
Map<int, PhoenixChannel> chatChannels = {};


Future connectSocket(String token, int userId) async {

  socket = PhoenixSocket(
      socketRoute,
      socketOptions: new PhoenixSocketOptions(params: {'token': token})
  );
  await socket.connect();

  userChannel = socket.channel('user:$userId');
  registerUserCallbacks(userChannel);

  userChannel.join();

  userChannel.push(event: "load_self");
  userChannel.push(event: "load_chats", payload: {"offset": 0});

}


void registerUserCallbacks(PhoenixChannel userChannel) {
  userChannel.on("chats_loaded", onChatsLoaded);
  userChannel.on("self_loaded", onSelfLoaded);
  userChannel.on("dialog_created", onDialogCreated);
  userChannel.on("users_like", onUsersLike);
}

void registerChatCallbacks(PhoenixChannel chatChannel) {
  chatChannel.on("messages_loaded", onMessagesLoaded);
  chatChannel.on("message", onMessageReceived);
  chatChannel.on("memebers_loaded", onMembersLoaded);
}



void onSelfLoaded(Map response, String _ref, String _joinRef) {
  var userData = response['body']['user'];
  User self = new User(
    username: userData['username'],
    id: userData['id'],
    avatar: userData['avatar'],
    name: userData['name']
  );

  store.dispatch(new UserUpdated(user: self));
}

void onChatsLoaded(Map response, String _ref, String _joinRef) {
  var chatsData = response['body']['chats'];

  Map<int, int> reads = Map.fromIterable(
    chatsData,
    key: (c) => (c['last_message']['id']),
    value: (c) => c['last_message']['reads']
  );

  Map<int, Message> messages = Map.fromIterable(
    chatsData,
    key: (c) => (c['last_message']['id']),
    value: (c) => Message.from(c['last_message'])
  );

  store.dispatch(new MessagesLoaded(messages: messages, reads: reads));

  List<Chat> chats = List.from(
    chatsData.map(
      (chatData) => Chat.from(chatData)
    )
  );

  store.dispatch(new ChatsLoaded(chats: chats));
  chatsData.forEach((data) {
    store.dispatch(
      new ChatMembersLoaded(
        users: Map.fromIterable(
          data['members'],
          key: (userData) => userData['id'],
          value: (userData) => User.from(userData)
        ),
        chatId: data['id']
      )
    );
  });


  chatsData.forEach((data) {
    if (!chatChannels.containsKey(data['id'])) {
      PhoenixChannel chatChannel = socket.channel("chat:${data['id']}");
      registerChatCallbacks(chatChannel);
      chatChannel.join();

      chatChannel.push(
        event: "load_messages_before",
        payload: {
          "message_id": data['last_message']['id']
        }
      );
      chatChannels[data['id']] = chatChannel;
    }
  });
}

void onDialogCreated(Map response, String _ref, String _joinRef) {
  List membersData = response['body']['dialog']['members'];
  Iterable<User> membersIterable = membersData.map((m) => User.from(m));
  List<User> members =
      List.from(membersIterable);
  Message lastMessage = Message.from(response['body']['dialog']['last_message']);

  Chat dialog = Chat.from(response['body']['dialog']);

  store.dispatch(
    new UsersLoaded(
      users: Map.fromIterable(
        members,
        key: (u) => u.id,
        value: (u) => u
      )
    )
  );
  store.dispatch(new ChatCreated(chat: dialog));
  store.dispatch(
    new MessagesLoaded(
      messages: {lastMessage.id: lastMessage},
      reads: {}
    )
  );

  if (store.state.dialogCreation.loading) {

    store.dispatch(new DialogCreated());
    navigatorKey.currentState.pop();

    store.dispatch(new SelectChat(chatId: dialog.id));
    navigatorKey.currentState.pushNamed("/chat");

  }

  PhoenixChannel chatChannel = socket.channel("chat:${dialog.id}");
  registerChatCallbacks(chatChannel);
  chatChannel.join();
  chatChannel.push(
      event: "load_messages_before",
      payload: {
        "message_id": lastMessage.id
      }
  );
  chatChannels[dialog.id] = chatChannel;
}

void onUsersLike(Map response, String _ref, String _joinRef) {
  Map<int, User> users = Map.fromIterable(
    response['body'].map((d) => User.from(d)),
    key: (u) => u.id,
    value: (u) => u
  );
  store.dispatch(
    new UsersLoaded(users: users)
  );

  store.dispatch(
    new SimilarLoaded(
      ids: List.from(response['body'].map((d) => d['id']))
    )
  );
}


void onMessagesLoaded(Map response, String _ref, String _joinRef) {
  var messages = response['body']['messages'];

  if (messages.length > 0) {
    Map<int, Message> messagesMap =
      Map.fromIterable(
        messages,
        key: (m) => m['id'],
        value: (m) => Message.from(m)
      );

    store.dispatch(
      new MessagesLoaded(
        reads: {},
        messages: messagesMap
      )
    );

    store.dispatch(
      new ChatMessagesLoaded(
        chatId: messages[0]['chat'],
        order: List.from(
          List.from(messages.map((d) => d['id'])).reversed
        )
      )
    );
  }
}

void onMembersLoaded(Map response, String _ref, String _joinRef) {

}

void onMessageReceived(Map response, String _ref, String _joinRef) {
  var user = User.from(response['body']['author']);
  response['body']['author'] = user.id;

  store.dispatch(new UserUpdated(user: user));
  store.dispatch(new MessageReceived(message: Message.from(response['body'])));
}

