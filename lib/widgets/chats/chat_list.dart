import 'package:echoes/models/chat.dart';
import 'package:echoes/models/message.dart';
import 'package:echoes/navigator.dart';
import 'package:echoes/store/actions/chats.dart';
import 'package:echoes/store/store.dart';
import 'package:echoes/widgets/fallback_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class ChatList extends StatefulWidget {

  ChatList({Key key, this.store}): super(key: key);

  final Store<AppState> store;

  _ChatListState createState() => _ChatListState();

}


final String imgRef = "https://sun9-54.userapi.com/c847124/v847124564/1c78e1/LPv1UmEjekE.jpg";


class _ChatListState extends State<ChatList> {

  void goToChat(int chatId) {
    store.dispatch(new SelectChat(chatId: chatId));
    navigatorKey.currentState.pushNamed("/chat");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, AppState> (
      converter: (store) => store.state,
      builder: (context, state) =>
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(15, 2, 15, 10),
                child: Container(
                  child: TextField(
                    maxLines: 1,
                    minLines: 1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: Colors.white)
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      hintStyle: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                      suffixIcon: Icon(Icons.search, color: Colors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.chats.order.length,
                  itemBuilder: (context, index) {

                    Chat chat = state.chats.chats[state.chats.order[index]];

                    Message lastMessage = state.messages.messages[chat.messagesChunks[chat.mainChunk].last];

                    return ListTile(
                      onTap: () { goToChat(chat.id); },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(imgRef),
                        radius: 26,
                      ),
                      title: Text(
                        chat.name(state),
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                      subtitle: Text(
                        lastMessage.text
                      ),
                    );
                  }
                ),
              )
            ],
          )
    );
  }

}
