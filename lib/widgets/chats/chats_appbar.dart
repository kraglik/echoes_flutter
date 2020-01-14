import 'package:echoes/navigator.dart';
import 'package:flutter/material.dart';


Widget chatsAppBar() {
  return AppBar(
    elevation: 0.0,
    leading: Icon(
      Icons.dehaze
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: IconButton(
          icon: Icon(
            Icons.create
          ),
          onPressed: () {
            navigatorKey.currentState.pushNamed("/create-dialog");
          },
        ),
      )
    ],
    title: Text(
      "Chats",
      style: TextStyle(
        fontWeight: FontWeight.bold
      ),
    ),
  );
}