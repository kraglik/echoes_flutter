import 'package:echoes/store/reducers/auth.dart';
import 'package:echoes/store/store.dart';
import 'package:echoes/widgets/bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class ContactsPage extends StatefulWidget {

  ContactsPage({Key key, this.store}): super(key: key);

  static const String routeName = "/contacts";

  final Store<AppState> store;

  @override
  _ContactsPageState createState() => _ContactsPageState();

}


class _ContactsPageState extends State<ContactsPage> {

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
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: TextField(
                      maxLines: 8,
                      minLines: 1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                        suffixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
          bottomNavigationBar: BottomNavigator()
      ),
    );
  }

}
