import 'package:flutter/material.dart';


Widget settingsAppBar() {
  return AppBar(
    leading: Container(),
    actions: <Widget>[],
    elevation: 0.0,
    title: Text(
      "Settings",
      style: TextStyle(
          fontWeight: FontWeight.bold
      ),
    ),
  );
}