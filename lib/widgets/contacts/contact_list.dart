import 'package:echoes/store/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class ContactList extends StatefulWidget {

  ContactList({Key key, this.store}): super(key: key);

  final Store<AppState> store;

  _ContactListState createState() => _ContactListState();

}


class _ContactListState extends State<ContactList> {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState> (
      converter: (store) => store.state,
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    "Oksana",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            )
          )
        ],
      )


      // ListView(
//        children: <Widget>[
//          ListTile(
//            title: Text(
//              "Igor",
//              style: TextStyle(
//                fontWeight: FontWeight.bold
//              )
//            ),
    );
  }

}
