import 'package:echoes/models/chat.dart';
import 'package:echoes/navigator.dart';
import 'package:echoes/store/store.dart';
import 'package:echoes/widgets/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'package:echoes/sockets/sockets.dart' as sockets;


class ChatWindow extends StatefulWidget {
  ChatWindow({Key key, this.store}) : super(key: key);

  static const routeName = "/chat";

  final Store<AppState> store;

  @override
  _ChatWindowState createState() => _ChatWindowState();
}


class _ChatWindowState extends State<ChatWindow> {

  final _messageScrollController = new ScrollController();
  final _messageInputController = new TextEditingController();

  double lastPosition = 1000.0;

  void _goBack() {
    navigatorKey.currentState.pop();
  }

  void _sendMessage() {
    var text = _messageInputController.text;

    text = text.replaceFirst(new RegExp(r"^\s+"), "");
    text = text.replaceFirst(new RegExp(r"^\n+"), "");

    text = text.replaceFirst(new RegExp(r"\s+$"), "");
    text = text.replaceFirst(new RegExp(r"\n+$"), "");

    if (text == "") {
      _messageInputController.text = "";
      return;
    }

    sockets.chatChannels[store.state.chats.chatId].push(
        event: "message",
        payload: {
          'id': null,
          'content': {
            'text': text
          }
        }
    );
    _messageInputController.text = "";
    _messageScrollController.animateTo(0.0, duration: new Duration(milliseconds: 250), curve: Curves.ease);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _messageScrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _messageScrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    final position = _messageScrollController.position.extentAfter;

    if (position == 0.0 && lastPosition > 0) {

      final chat = store.state.chats.chats[store.state.chats.chatId];
      final chunk = chat.messagesChunks[chat.currentChunk];
      sockets.chatChannels[chat.id].push(
        event: "load_messages_before",
        payload: {
          "message_id": chunk[0]
        }
      );
      setState(() {
        lastPosition = position;
      });
    }
    if (position > 20) {
      setState(() {
        lastPosition = position;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        final chat = state.chats.chats[state.chats.chatId];
        final chunk = chat.messagesChunks[chat.currentChunk];
        final msgs = List.from(chunk.map((id) => state.messages.messages[id]));
        final messages = List.from(msgs.reversed);

        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(chat.name(store.state)),
            leading: ButtonBar(
              children: <Widget>[FlatButton(
                  child: const Icon(Icons.arrow_back_ios),
                  onPressed: _goBack,
                  shape: CircleBorder()
              )
              ],
            ),
            actions: <Widget>[
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Icon(Icons.dehaze),
                    shape: CircleBorder(),
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    controller: _messageScrollController,
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return MessageWidget(
                        data: messages[index],
                        userId: state.auth.id,
                      );
                    }
                  ),
                ),
                _buildBottomChat(chat),
              ],
            ),
          )
        );
      },
    );
  }

  _buildBottomChat(Chat chat) {
    var suffixIcon = _messageInputController.text == "" ? IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.insert_emoticon,
        size: 25.0,
        color: Colors.lightBlue,
      ),
    ) : null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
//        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.attach_file,
                size: 25.0,
                color: Colors.lightBlue,
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: Container(
              child: TextField(
                maxLines: 8,
                minLines: 1,
                controller: _messageInputController,
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
                  hintText: 'Aa',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                  suffixIcon: suffixIcon,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              onPressed: _sendMessage,
              icon: Icon(
                Icons.send,
                size: 25.0,
                color: Colors.lightBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

}

