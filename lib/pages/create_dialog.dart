import 'package:echoes/sockets/sockets.dart';
import 'package:echoes/store/actions/dialog_creation.dart';
import 'package:echoes/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class CreateDialogPage extends StatefulWidget {

  CreateDialogPage({Key key, this.store}): super(key: key);

  static const String routeName = "/create-dialog";

  final Store<AppState> store;

  @override
  _CreateDialogPageState createState() => _CreateDialogPageState();

}


class _CreateDialogPageState extends State<CreateDialogPage> {

  final String imgRef = "https://sun9-54.userapi.com/c847124/v847124564/1c78e1/LPv1UmEjekE.jpg";

  Widget _userItem(AppState state, context, index) {
    var user = state.users.byId[state.dialogCreation.usersLike[index]];

    if (user == null)
      return null;

    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(imgRef)),
      title: Text(user.name.split(' ')[0]),
      subtitle: Text(user.username),
      onTap: () {
        store.dispatch(new CreateDialog(nickname: user.username));
        userChannel.push(
          event: "create_dialog",
          payload: {
            "username": user.username
          }
        );
      },
    );
  }

  void _updateSearch(String pattern) {
    store.dispatch(FindSimilar(nickname: pattern));
    userChannel.push(
      event: "users_like",
      payload: {
        "username": pattern,
        "offset": 0
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: TextField(
            onChanged: _updateSearch,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(8.0),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0)
              ),
              fillColor: Colors.grey[200],
              labelText: 'Поиск пользователей для диалога',
            )
        ),
      ),
      body: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return Container(
                color: Colors.white,
                child: ListView.builder(
                    itemCount: state.dialogCreation.usersLike.length,
                    itemBuilder: (bContext, index) =>
                        _userItem(state, bContext, index)
                )
            );
          }
      ),
    );
  }

}
