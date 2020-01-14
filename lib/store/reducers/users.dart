import 'package:echoes/models/user.dart';
import 'package:echoes/store/actions/auth.dart';
import 'package:echoes/store/actions/users.dart';
import 'package:echoes/store/actions/chats.dart';

class UsersState {

  final Map<int, User> byId;

  const UsersState({
    this.byId
  });

}


UsersState
userUpdatedReducer(UsersState state, UserUpdated action) {
  return new UsersState(
    byId: {
      ...state.byId,
      action.user.id: action.user
    }
  );
}

UsersState
usersLoaded(UsersState state, UsersLoaded action) {
  return new UsersState(
    byId: {
      ...state.byId,
      ...action.users
    }
  );
}

UsersState
createUserIfNotExistReducer(UsersState state, UpdateUserIfNotExist action) {
  if (state.byId.containsKey(action.user.id))
    return state;

  return new UsersState(
    byId: {
      ...state.byId,
      action.user.id: action.user
    }
  );
}

UsersState
membersLoaded(UsersState state, ChatMembersLoaded action) {
  return new UsersState(
    byId: {...action.users, ...state.byId}
  );
}


UsersState usersReducer(UsersState state, dynamic action) {
  if (action is LogOut)
    return initialUsersState;

  if (action is UserUpdated)
    return userUpdatedReducer(state, action);

  if (action is ChatMembersLoaded)
    return membersLoaded(state, action);

  if (action is UpdateUserIfNotExist)
    return createUserIfNotExistReducer(state, action);

  if (action is UsersLoaded)
    return usersLoaded(state, action);

  return state;
}


final initialUsersState = new UsersState(byId: {});
