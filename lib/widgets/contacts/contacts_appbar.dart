import 'package:flutter/material.dart';


Widget contactsAppBar() {
  return AppBar(
    elevation: 0.0,
    leading: Icon(
      Icons.dehaze
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: Icon(
          Icons.add,
          size: 32.0,
        ),
      )
    ],
    title: Text(
      "Contacts",
      style: TextStyle(
        fontWeight: FontWeight.bold
      ),
    ),
  );
}