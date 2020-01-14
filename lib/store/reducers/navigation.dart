import 'package:echoes/store/actions/auth.dart';
import 'package:echoes/store/actions/navigation.dart';


class NavState {

  final String path;

  const NavState({this.path});

}

NavState
setPathReducer(NavState state, SetPath action) {
  return new NavState(
    path: action.path
  );
}

NavState navReducer(NavState state, dynamic action) {
  if (action is LogOut)
    return initialNavState;

  if (action is SetPath)
    return setPathReducer(state, action);

  return state;
}

final initialNavState = new NavState(path: "/chats");
