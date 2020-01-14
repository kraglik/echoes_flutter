import 'package:echoes/widgets/auth/button.dart';
import 'package:echoes/widgets/auth/input.dart';
import 'package:flutter/material.dart';


class LoginForm extends StatelessWidget {

  LoginForm({

    Key key,

    this.updateUsername,
    this.updatePassword,
    this.login,
    this.register,
    this.loading,
    this.error

  }): super(key: key);

  final Function updateUsername;
  final Function updatePassword;

  final Function login;
  final Function register;

  final bool loading;
  final bool error;

  @override
  Widget build(BuildContext context) {
    var loadWidget = loading ?
        CircularProgressIndicator() :
        Container();

    var errorWidget = error ?
        Text(
          "Login failed",
          style: TextStyle(color: Colors.red),
        ):
        Container();

    return Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: loadWidget,
                )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: errorWidget
              ),
            ),
            AuthInputField(
              fieldKey: 'username',
              label: 'Nickname',
              obscure: false,
              onChanged: updateUsername,
              autocorrect: false,
            ),
            AuthInputField(
              fieldKey: 'password',
              label: 'Password',
              obscure: true,
              autocorrect: false,
              onChanged: updatePassword
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: <Widget>[
                  AuthButton(
                    text: 'Log in',
                    onTap: login,
                    loading: loading,
                    error: error
                  ),
                  AuthButton(
                      text: 'Register',
                      onTap: register,
                      loading: loading,
                      error: error
                  ),
                ],
              ),
            )
          ],
        )
    );
  }

}
