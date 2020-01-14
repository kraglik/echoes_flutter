import 'package:echoes/models/chat.dart';
import 'package:echoes/models/message.dart';
import 'package:echoes/store/store.dart';
import 'package:flutter/material.dart';


class MessageWidget extends StatelessWidget {

  final Message data;
  final int userId;

  MessageWidget({this.data, this.userId});

  @override
  Widget build(BuildContext context) {

    if (data.type == 'info') {
      return Container(
        child: Center(
          child: Text(
            "Chat created",
            style: TextStyle(
              color: Colors.grey[700]
            ),
          ),
        ),
      );
    }

    var width = MediaQuery.of(context).size.width * 0.8;
    var direction = data.authorId == userId ?
        TextDirection.rtl :
        TextDirection.ltr;

    var color = data.authorId == userId ?
        Colors.blue[100]:
        Colors.green[100];


    return Container(
      child: Column(
        children: <Widget>[
          Row(
            textDirection: direction,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(maxWidth: width),
                child: Text(data.text),
                padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(16.0)
                ),
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
              ),
            ],
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 10.0),
    );
  }

}