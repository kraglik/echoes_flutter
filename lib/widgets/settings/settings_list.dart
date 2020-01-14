import 'package:echoes/navigator.dart';
import 'package:echoes/sockets/sockets.dart';
import 'package:echoes/store/actions/auth.dart';
import 'package:echoes/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';


class SettingsList extends StatefulWidget {

  SettingsList({Key key, this.store}): super(key: key);

  final Store<AppState> store;

  _SettingsListState createState() => _SettingsListState();

}


class _SettingsListState extends State<SettingsList> {

  void exit() async {
    final storage = new FlutterSecureStorage();

    await storage.deleteAll();

    navigatorKey.currentState.pushNamedAndRemoveUntil("/login", (_) => false);

    store.dispatch(new LogOut());

    await socket.disconnect();
    chatChannels.clear();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, AppState> (
      converter: (store) => store.state,
      builder: (context, state) => ListView(
        children: <Widget>[
          _button(exit, "Logout from account", Colors.red)
        ],
      ),
    );
  }

  Widget _button(Function onTap, String text, Color color) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 60
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 5.0, 50.0, 5.0),
            child: FlatButton(
              onPressed: onTap,
              child: new Text(
                text,
                style: new TextStyle(
                  fontSize: 20.0,
                  color: color
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(color: color)
              ),
            ),
          ),
        ),
        ],
      ),
    );
  }

}
