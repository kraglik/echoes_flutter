import 'package:echoes/store/reducers/auth.dart'
  show AuthState,
       authReducer,
       initialAuthState;
import 'package:echoes/store/reducers/chats.dart'
    show ChatsState,
         chatsReducer,
         initialChatsState;
import 'package:echoes/store/reducers/login.dart'
  show LoginState,
       loginReducer,
       initialLoginState;
import 'package:echoes/store/reducers/messages.dart'
  show MessagesState,
       messagesReducer,
       initialMessagesState;
import 'package:echoes/store/reducers/navigation.dart'
  show NavState,
       navReducer,
       initialNavState;

import 'package:echoes/store/reducers/users.dart'
    show UsersState,
         usersReducer,
         initialUsersState;

import 'package:echoes/store/reducers/register.dart'
    show RegisterState,
         registerReducer,
         initialRegisterState;

import 'package:echoes/store/reducers/dialog_creation.dart'
    show DialogCreationState,
         dialogCreationReducer,
         initialDialogCreationState;

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';



class AppState {

  final MessagesState messages;
  final LoginState login;
  final RegisterState register;
  final AuthState auth;
  final NavState nav;
  final ChatsState chats;
  final UsersState users;
  final DialogCreationState dialogCreation;

  const AppState({
    this.messages,
    this.login,
    this.register,
    this.auth,
    this.nav,
    this.chats,
    this.users,
    this.dialogCreation
  });

}


AppState rootReducer(AppState state, dynamic action) {
  return new AppState(
    messages: messagesReducer(state.messages, action),
    login: loginReducer(state.login, action),
    auth: authReducer(state.auth, action),
    nav: navReducer(state.nav, action),
    chats: chatsReducer(state.chats, action),
    users: usersReducer(state.users, action),
    register: registerReducer(state.register, action),
    dialogCreation: dialogCreationReducer(state.dialogCreation, action)
  );
}

final Store<AppState> store = new Store<AppState>(
  rootReducer,
  initialState: new AppState(
    messages: initialMessagesState,
    login: initialLoginState,
    auth: initialAuthState,
    nav: initialNavState,
    chats: initialChatsState,
    users: initialUsersState,
    register: initialRegisterState,
    dialogCreation: initialDialogCreationState
  ),
  middleware: [thunkMiddleware]
);

