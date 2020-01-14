import 'package:echoes/store/actions/auth.dart';
import 'package:echoes/store/reducers/auth.dart';
import 'package:echoes/store/store.dart';
import 'package:echoes/store/thunks/login.dart';
import 'package:echoes/widgets/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.store}): super(key: key);

  static const String routeName = "/login";

  final Store<AppState> store;

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {

  void goToRegister() {
    if (!store.state.login.loading)
      Navigator.of(context).pushNamed("/register");
  }

  void logIn() {
    store.dispatch(
      new LoginAction(
        username: _username,
        password: _password
      )
    );
    store.dispatch(loginThunk);
  }

  String _username = "";
  String _password = "";

  void updateUsername(String u) {
    this.setState(() { _username = u; });
  }

  void updatePassword(String p) {
    this.setState(() { _password = p; });
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthState>(
      converter: (store) => store.state.auth,
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leading: new Container(),
          elevation: 0.0,
          title: Text("Authorization"),
        ),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              LoginForm(
                error: store.state.login.error,
                loading: store.state.login.loading,
                login: logIn,
                register: goToRegister,
                updateUsername: updateUsername,
                updatePassword: updatePassword,
              )
            ],
          ),
        ),
      ),
    );

  }

}
