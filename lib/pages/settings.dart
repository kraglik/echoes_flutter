import 'package:echoes/store/reducers/auth.dart';
import 'package:echoes/store/store.dart';
import 'package:echoes/widgets/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class SettingsPage extends StatefulWidget {

  SettingsPage({Key key, this.store}): super(key: key);

  static const String routeName = "/settings";

  final Store<AppState> store;

  @override
  _SettingsPageState createState() => _SettingsPageState();

}


class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (context, state) => Scaffold(
          appBar: AppBar(
            elevation: 0.0,
          ),
          body: Container(
            color: Colors.white,
            child: Center(
              child: Center(
                child: Text("settings"),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigator()
      ),
    );
  }

}
