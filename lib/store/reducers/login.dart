import 'package:echoes/store/actions/auth.dart';

class LoginState {

  final String username;
  final String password;

  final bool loading;
  final bool error;

  const LoginState({
    this.username,
    this.password,
    this.loading,
    this.error
  });

}


LoginState
loginActionReducer(LoginState state, LoginAction action) {
  return new LoginState(
    username: action.username,
    password: action.password,
    loading: true,
    error: false
  );
}


LoginState
loginSuccessfulReducer(LoginState state, LoginSuccessful action) {
  return new LoginState(
    username: null,
    password: null,
    loading: false,
    error: false
  );
}


LoginState
loginFailedReducer(LoginState state, LoginFailed action) {
  return new LoginState(
    username: state.username,
    password: state.password,
    loading: false,
    error: true
  );
}


LoginState loginReducer(LoginState state, dynamic action) {

  if (action is LogOut)
    return initialLoginState;

  if (action is LoginAction)
    return loginActionReducer(state, action);

  if (action is LoginSuccessful)
    return loginSuccessfulReducer(state, action);

  if (action is LoginFailed)
    return loginFailedReducer(state, action);

  return state;
}

final LoginState initialLoginState = new LoginState(
  username: null,
  password: null,
  loading: false,
  error: false
);

