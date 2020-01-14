import 'package:echoes/pages/calls.dart';
import 'package:echoes/store/actions/navigation.dart';
import 'package:echoes/store/reducers/navigation.dart';
import 'package:echoes/store/store.dart';
import 'package:echoes/widgets/bottom_navigator.dart';
import 'package:echoes/widgets/calls/calls_appbar.dart';
import 'package:echoes/widgets/calls/calls_list.dart';
import 'package:echoes/widgets/chats/chat_list.dart';
import 'package:echoes/widgets/chats/chats_appbar.dart';
import 'package:echoes/widgets/contacts/contact_list.dart';
import 'package:echoes/widgets/contacts/contacts_appbar.dart';
import 'package:echoes/widgets/settings/settings_appbar.dart';
import 'package:echoes/widgets/settings/settings_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class HomePage extends StatefulWidget {

  HomePage({Key key, this.store}): super(key: key);

  static const String routeName = "/home";

  final Store<AppState> store;

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  Widget _appBar(String option) {
    switch (option) {
      case "/contacts":
        return contactsAppBar();

      case "/chats":
        return chatsAppBar();

      case "/settings":
        return settingsAppBar();

      case "/calls":
        return callsAppBar();

      default:
        return null;
    }
  }

  Widget _body(String option) {
    switch (option) {
      case "/contacts":
        return ContactList();

      case "/chats":
        return ChatList();

      case "/settings":
        return SettingsList();

      case "/calls":
        return CallsList();

      default:
        return null;
    }
  }

  void goTo(int option) {
    switch (option) {
      case 0:
        store.dispatch(new SetPath(path: "/calls"));
        break;

      case 1:
        store.dispatch(new SetPath(path: "/contacts"));
        break;

      case 2:
        store.dispatch(new SetPath(path: "/chats"));
        break;

      case 3:
        store.dispatch(new SetPath(path: "/settings"));
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, NavState>(
      converter: (store) => store.state.nav,
      builder: (context, state) => Scaffold(
        appBar: _appBar(state.path),
        body: Container(
          color: Colors.white,
          child: _body(state.path),
        ),
        bottomNavigationBar: BottomNavigator(
          goTo: goTo
        ),
      ),
    );
  }

}
