import 'package:echoes/store/actions/auth.dart';

class AuthState {

  final int id;
  final String token;

  const AuthState({this.id, this.token});

}


AuthState
loginSuccessfulReducer(AuthState state, LoginSuccessful action) {
  return new AuthState(
    id: action.id,
    token: action.token
  );
}


AuthState authReducer(AuthState state, dynamic action) {

  if (action is LogOut)
    return initialAuthState;

  if (action is LoginSuccessful)
    return loginSuccessfulReducer(state, action);

  return state;
}


final AuthState initialAuthState = new AuthState(id: null, token: null);
