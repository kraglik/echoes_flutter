class User {

  final String username;
  final String name;
  final int id;
  final String avatar;

  const User({this.username, this.name, this.id, this.avatar});

  static User from(usr) {
    return new User(
      username: usr['username'],
      name: usr['name'],
      id: usr['id'],
      avatar: usr['avatar']
    );
  }

}