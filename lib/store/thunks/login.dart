import 'dart:convert';

import 'package:echoes/models/user.dart';
import 'package:echoes/navigator.dart';
import 'package:echoes/store/actions/auth.dart';
import 'package:echoes/store/actions/users.dart';
import 'package:echoes/store/store.dart';
import 'package:echoes/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

import 'callbacks/chat_channel_callbacks.dart';
import 'package:echoes/sockets/sockets.dart';


void loginThunk(Store<AppState> store) async {

  try {
    final response = await http.post(
        apiRoute + "/api/login",
        body: {
          "username": store.state.login.username,
          "password": store.state.login.password
        }
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final token = body['token'];
      final user = User.from(body['user']);
      final storage = new FlutterSecureStorage();

      await storage.write(key: "token", value: token);
      await storage.write(key: "id", value: user.id.toString());

      store.dispatch(
          new UserUpdated(user: user)
      );
      store.dispatch(
          new LoginSuccessful(token: token, id: user.id)
      );

      await connectSocket(
          store.state.auth.token,
          store.state.auth.id
      );

      navigatorKey.currentState.pushNamedAndRemoveUntil("/home", (_) => false);
    }
    else {
      store.dispatch(
          new LoginFailed()
      );
    }
  }
  catch (e) {
    store.dispatch(
        new LoginFailed()
    );
  }
}
