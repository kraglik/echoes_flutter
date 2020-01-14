import 'package:echoes/store/reducers/auth.dart';
import 'package:echoes/store/store.dart';
import 'package:echoes/widgets/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class ChatsPage extends StatefulWidget {

  ChatsPage({Key key, this.store}): super(key: key);

  static const String routeName = "/chats";

  final Store<AppState> store;

  @override
  _ChatsPageState createState() => _ChatsPageState();

}


class _ChatsPageState extends State<ChatsPage> {

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
          ),
          body: Container(
            color: Colors.white,
            child: Center(
              child: Center(
                child: Text("chats"),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigator()
        );
      }
    );
  }

}
