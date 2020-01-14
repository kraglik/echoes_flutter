import 'package:echoes/models/message.dart';
import 'package:echoes/models/chat.dart';
import 'package:echoes/store/actions/auth.dart';
import 'package:echoes/store/actions/messages.dart';
import 'package:echoes/store/actions/chats.dart';

class ChatsState {

  final Map<int, Chat> chats;
  final Map<int, String> drafts;
  final List<int> order;
  final int chatId;

  const ChatsState({
    this.chats,
    this.drafts,
    this.order,
    this.chatId
  });

}


ChatsState
messageReceived(ChatsState state, MessageReceived action) {
  var oldChat = state.chats[action.message.chatId];

  var oldMessageChunk = oldChat.messagesChunks[oldChat.mainChunk];

  var chat = new Chat(
    id: oldChat.id,
    data: oldChat.data,
    members: oldChat.members,
    type: oldChat.type,
    pending: oldChat.pending,
    currentChunk: oldChat.currentChunk,
    mainChunk: oldChat.mainChunk,
    messagesChunks: {
      ...oldChat.messagesChunks,
      oldChat.mainChunk: [
        ...oldMessageChunk,
        action.message.id
      ]
    }
  );

  return new ChatsState(
    chats: {...state.chats, chat.id: chat},
    drafts: state.drafts,
    order: [chat.id, ...state.order..removeWhere((id) => id == chat.id)],
    chatId: state.chatId
  );
}


ChatsState
membersLoaded(ChatsState state, ChatMembersLoaded action) {
  var oldChat = state.chats[action.chatId];
  var chat = new Chat(
    type: oldChat.type,
    messagesChunks: oldChat.messagesChunks,
    pending: oldChat.pending,
    data: oldChat.data,
    currentChunk: oldChat.currentChunk,
    mainChunk: oldChat.mainChunk,
    members: Set.from(
        List.from(oldChat.members)
          ..addAll(action.users.values.map((u) => u.id))
    )
  );

  return new ChatsState(
    chats: {...state.chats, chat.id: chat},
    drafts: state.drafts,
    order: state.order,
    chatId: state.chatId
  );
}


ChatsState
chatsLoaded(ChatsState state, ChatsLoaded action) {
  return new ChatsState(
    chats: {
      ...Map.fromIterable(action.chats, key: (c) => c.id, value: (c) => c),
      ...state.chats
    },
    drafts: {},
    order: [...state.order, ...List.from(action.chats.map((c) => c.id))],
    chatId: state.chatId
  );
}


ChatsState
selectChat(ChatsState state, SelectChat action) {
  return new ChatsState(
    chats: state.chats,
    drafts: state.drafts,
    order: state.order,
    chatId: action.chatId
  );
}

ChatsState
chatCreated(ChatsState state, ChatCreated action) {
  return new ChatsState(
    chats: {...state.chats, action.chat.id: action.chat},
    drafts: state.drafts,
    order: [action.chat.id, ...state.order],
    chatId: state.chatId
  );
}

ChatsState
chatMessagesLoaded(ChatsState state, ChatMessagesLoaded action) {
  var oldChat = state.chats[action.chatId];
  var oldChunk = oldChat.messagesChunks[oldChat.currentChunk];

  var newChunk = [...action.order, ...oldChunk];

  return new ChatsState(
    chats: {
      ...state.chats,
      action.chatId: new Chat(
        pending: oldChat.pending,
        messagesChunks: {
          ...oldChat.messagesChunks,
          oldChat.currentChunk: newChunk
        },
        data: oldChat.data,
        members: oldChat.members,
        type: oldChat.type,
        id: oldChat.id,
        currentChunk: oldChat.currentChunk,
        mainChunk: oldChat.mainChunk
      )
    },
    drafts: state.drafts,
    order: state.order,
    chatId: action.chatId
  );
}


ChatsState chatsReducer(ChatsState state, dynamic action) {

  if (action is LogOut)
    return initialChatsState;

  if (action is MessageReceived)
    return messageReceived(state, action);

  if (action is ChatMembersLoaded)
    return membersLoaded(state, action);

  if (action is ChatsLoaded)
    return chatsLoaded(state, action);

  if (action is ChatCreated)
    return chatCreated(state, action);

  if (action is SelectChat)
    return selectChat(state, action);

  if (action is ChatMessagesLoaded)
    return chatMessagesLoaded(state, action);

  return state;
}

final ChatsState initialChatsState = new ChatsState(
  chats: {},
  drafts: {},
  order: [],
  chatId: null
);
