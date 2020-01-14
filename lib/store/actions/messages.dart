import 'package:echoes/models/message.dart';

class SendMessage {
  final int chatId;

  const SendMessage({this.chatId});
}

class MessageReceived {
  final Message message;

  const MessageReceived({this.message});
}

class MessagesLoaded {

  final Map<int, Message> messages;
  final Map<int, int> reads;

  const MessagesLoaded({
    this.messages,
    this.reads
  });

}

class ChatMessagesLoaded {

  final List<int> order;
  final int chatId;

  const ChatMessagesLoaded({
    this.order,
    this.chatId
  });

}

class MessageUpdated {
  final Message message;
  final int reads;

  const MessageUpdated({this.message, this.reads});
}

class MessageDeleted {
  final int messageId;

  const MessageDeleted({this.messageId});
}

class MessagesRead {
  final List<int> readMessages;

  const MessagesRead({this.readMessages});
}

class MessagesReadsUpdate {
  final Map<int, int> reads;

  const MessagesReadsUpdate({this.reads});
}
