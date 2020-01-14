enum MessageType {
  MESSAGE,
  PHOTO,
  STICKER,
  ENTERED
}


class Message {

  final int id;
  final int authorId;
  final Map content;
  final String type;
  final DateTime sent;
  final int chatId;
  final int reads;

  const Message({
    this.id,
    this.reads,
    this.authorId,
    this.type,
    this.content,
    this.chatId,
    this.sent
  });

  String get text {
    switch (type) {
      case "message":
        return content['text'];
      case "info":
        return this.info;
      default:
        return "";
    }

  }

  String get info {
    var event = content['event'];

    switch (event) {
      case "created":
        return "Chat created";

      default:
        return "unknown event";
    }
  }

  String get stickerUrl {
    return content['sticker'];
  }

  int get stickerPackId {
    return content['stickerpack'];
  }

  static Message from(msg) {
    final authorId = (msg['author'] is int) ?
        msg['author']:
        msg['author']['id'];

    return new Message(
      type: msg['type'],
      reads: msg['reads'],
      authorId: authorId,
      chatId: msg['chat'],
      content: msg['content'],
      id: msg['id'],
      sent: msg['inserted_at']
    );
  }
}


class MessageReads {
  final int messageId;
  final int reads;

  const MessageReads({this.messageId, this.reads});
}
