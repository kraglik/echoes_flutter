import 'package:echoes/navigator.dart';
import 'package:echoes/pages/chats.dart';
import 'package:echoes/pages/contacts.dart';
import 'package:echoes/pages/settings.dart';
import 'package:echoes/store/actions/navigation.dart';
import 'package:echoes/store/reducers/navigation.dart';
import 'package:echoes/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'no_animation.dart';


class BottomNavigator extends StatelessWidget {

  BottomNavigator({Key key, this.goTo}): super(key: key);

  final Function goTo;

  final Map<String, int> currentOption = {
    "/calls": 0,
    "/contacts": 1,
    "/chats": 2,
    "/settings": 3
  };

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, NavState>(
      converter: (store) => store.state.nav,
      builder: (context, state) {
        var option = currentOption[state.path];

        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.black,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.grey[100],
          elevation: 0.0,
          onTap: goTo,
          currentIndex: option,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.call,
                size: 40,
              ),
              activeIcon: Icon(
                  Icons.call,
                  size: 40
              ),
              title: Text(
                "Calls",
                style: TextStyle(
                    fontSize: 12
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 40,
              ),
              activeIcon: Icon(
                Icons.account_circle,
                size: 40
              ),
              title: Text(
                "Contacts",
                style: TextStyle(
                  fontSize: 12
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.forum,
                size: 40
              ),
              activeIcon: Icon(
                Icons.forum,
                size: 40
              ),
              title: Text(
                "Chats",
                style: TextStyle(
                  fontSize: 12
                ),
              )
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.tune,
                size: 40
              ),
              activeIcon: Icon(
                Icons.tune,
                size: 40
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 12
                ),
              )
            )
          ]
        );
      }
    );
  }

}
