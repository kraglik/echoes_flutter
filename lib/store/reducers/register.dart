import 'package:echoes/store/actions/auth.dart';

class RegisterState {

  final String username;
  final String password;
  final String name;
  final String email;

  final bool loading;
  final bool error;

  const RegisterState({
    this.username,
    this.password,
    this.name,
    this.email,
    this.loading,
    this.error
  });

}


RegisterState
loginActionReducer(RegisterState state, RegisterAction action) {
  return new RegisterState(
      username: action.username,
      password: action.password,
      name: action.name,
      email: action.email,
      loading: true,
      error: false
  );
}


RegisterState
loginSuccessfulReducer(RegisterState state, LoginSuccessful action) {
  return new RegisterState(
      username: null,
      password: null,
      name: null,
      email: null,
      loading: false,
      error: false
  );
}


RegisterState
loginFailedReducer(RegisterState state, RegisterFailed action) {
  return new RegisterState(
      username: state.username,
      password: state.password,
      name: state.name,
      email: state.email,
      loading: false,
      error: true
  );
}


RegisterState registerReducer(RegisterState state, dynamic action) {

  if (action is LogOut)
    return initialRegisterState;

  if (action is RegisterAction)
    return loginActionReducer(state, action);

  if (action is LoginSuccessful)
    return loginSuccessfulReducer(state, action);

  if (action is RegisterFailed)
    return loginFailedReducer(state, action);

  return state;
}

final RegisterState initialRegisterState = new RegisterState(
    username: null,
    password: null,
    name: null,
    email: null,
    loading: false,
    error: false
);

