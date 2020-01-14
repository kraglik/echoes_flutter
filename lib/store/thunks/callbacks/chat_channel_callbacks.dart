import 'package:echoes/models/message.dart';
import 'package:echoes/models/user.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:echoes/sockets/sockets.dart' as sockets;
import 'package:echoes/store/actions/messages.dart';
import 'package:echoes/store/actions/users.dart';
import 'package:echoes/store/store.dart'
  show store;


void registerChatCallbacks(PhoenixChannel chatChannel) {

  chatChannel.on("message", (payload, _ref, _joinRef) {
    var msg = payload['body']['message'];
    var author = payload['body']['author'];

    store.dispatch(
      new UpdateUserIfNotExist(
        user: User.from(author)
      )
    );
    store.dispatch(
      new MessageReceived(
        message: Message.from(msg)
      )
    );
  });

}
