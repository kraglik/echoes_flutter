import 'package:echoes/models/user.dart';

class UserUpdated {

  final User user;

  const UserUpdated({
    this.user
  });

}

class UsersLoaded {

  final Map<int, User> users;

  const UsersLoaded({this.users});

}


class UpdateUserIfNotExist {
  final User user;

  const UpdateUserIfNotExist({
    this.user
  });
}
