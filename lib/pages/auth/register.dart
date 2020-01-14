import 'package:echoes/store/store.dart';
import 'package:echoes/widgets/login/login_form.dart';
import 'package:echoes/widgets/register/register_form.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.store}): super(key: key);

  static const String routeName = "/register";

  final Store<AppState> store;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPage> {

  void goToLogin() {
    if (!store.state.login.loading)
      Navigator.of(context).pushNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Registration"),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            RegisterForm(
              error: false,
              loading: false,
              login: goToLogin,
              register: () {},
              updateName: (String v) {},
              updateUsername: (String v) {},
              updateEmail: (String v) {},
              updatePassword: (String v) {},
            )
          ],
        ),
      ),
    );
  }

}
