class LoginAction {

  final String username;
  final String password;

  const LoginAction({
    this.username,
    this.password
  });

}


class RegisterAction {

  final String username;
  final String password;
  final String name;
  final String email;

  const RegisterAction({
    this.username,
    this.password,
    this.name,
    this.email
  });

}

class LoginSuccessful {

  final int id;
  final String token;

  const LoginSuccessful({
    this.id,
    this.token
  });

}

class LoginFailed {

}

class RegisterFailed {

}

class LogOut {}
