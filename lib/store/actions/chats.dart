import 'package:echoes/models/chat.dart';
import 'package:echoes/models/user.dart';

class ChatCreated {

  final Chat chat;

  const ChatCreated({
    this.chat,
  });
}

class ChatsLoaded {
  final List<Chat> chats;

  const ChatsLoaded({this.chats});
}

class ChatBannedUser {

  final int chatId;
  final User user;
  final User bannedUser;

  const ChatBannedUser({
    this.chatId,
    this.user,
    this.bannedUser
  });

}

class SelectChat {
  final int chatId;

  const SelectChat({
    this.chatId
  });
}

class ChatMembersLoaded {

  final Map<int, User> users;
  final int chatId;

  const ChatMembersLoaded({
    this.users,
    this.chatId
  });

}
