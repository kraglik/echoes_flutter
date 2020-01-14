import 'package:echoes/navigator.dart';
import 'package:echoes/pages/auth/login.dart';
import 'package:echoes/pages/auth/register.dart';
import 'package:echoes/pages/chats.dart';
import 'package:echoes/pages/contacts.dart';
import 'package:echoes/pages/create_dialog.dart';
import 'package:echoes/pages/dialog/dialog.dart';
import 'package:echoes/pages/home.dart';
import 'package:echoes/pages/settings.dart';
import 'package:echoes/sockets/sockets.dart';
import 'package:echoes/store/actions/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:redux/redux.dart';

import 'store/store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = new FlutterSecureStorage();

  final String token = await storage.read(key: "token");
  final String idString = await storage.read(key: "id");

  final int id = idString == null ? null : int.tryParse(idString);

  final bool authorized = token != null && id != null;

  if (authorized) {
    store.dispatch(new LoginSuccessful(token: token, id: id));  // LoggedIn
    await connectSocket(
        token,
        id
    );
  }
  
  runApp(MyApp(authorized: authorized, store: store));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({Key key, this.authorized, this.store}): super(key: key);

  final bool authorized;
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.black,
          cursorColor: Colors.black,
          backgroundColor: Colors.white,
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            colorScheme: ColorScheme.light(primary: Colors.black),
            focusColor: Colors.black
          ),
          inputDecorationTheme: InputDecorationTheme(
            focusColor: Colors.black,
            hintStyle: TextStyle(
              color: Colors.grey,
              backgroundColor: Colors.black
            ),
            labelStyle: TextStyle(
              color: Colors.grey
            ),
            border: UnderlineInputBorder(),
            focusedBorder: UnderlineInputBorder(),
          )
        ),
        home: LoginPage(),
        initialRoute: authorized ? "/home" : "/login",
        routes: {
          LoginPage.routeName: (_) => LoginPage(),
          RegisterPage.routeName: (_) => RegisterPage(),
          HomePage.routeName: (_) => HomePage(),
          CreateDialogPage.routeName: (_) => CreateDialogPage(),
          ChatWindow.routeName: (_) => ChatWindow()
        },
      ),
    );
  }
}
