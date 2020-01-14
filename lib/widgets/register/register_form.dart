import 'package:echoes/widgets/auth/button.dart';
import 'package:echoes/widgets/auth/input.dart';
import 'package:flutter/material.dart';


class RegisterForm extends StatelessWidget {

  RegisterForm({

    Key key,

    this.updateUsername,
    this.updatePassword,
    this.updateName,
    this.updateEmail,
    this.login,
    this.register,
    this.loading,
    this.error

  }): super(key: key);

  final Function updateUsername;
  final Function updatePassword;
  final Function updateName;
  final Function updateEmail;

  final Function login;
  final Function register;

  final bool loading;
  final bool error;

  @override
  Widget build(BuildContext context) {
    var loadWidget = loading ?
        CircularProgressIndicator() :
        Container();

    return Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AuthInputField(
                fieldKey: 'username',
                label: 'Nickname',
                obscure: false,
                autocorrect: false,
                onChanged: updateUsername
            ),
            AuthInputField(
                fieldKey: 'email',
                label: 'Email',
                obscure: false,
                autocorrect: false,
                onChanged: updateEmail
            ),
            AuthInputField(
              fieldKey: 'name',
              label: 'Name',
              obscure: false,
              autocorrect: false,
              onChanged: updateName
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
                      text: 'Register',
                      onTap: register,
                      loading: loading,
                      error: error
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: loadWidget,
                )
            )
          ],
        )
    );
  }

}
