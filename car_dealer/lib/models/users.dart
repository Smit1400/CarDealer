class User {
  final String uid;
  final String username;
  final String email;
  final bool admin;

  User({this.uid, this.username, this.email, this.admin: false});

  factory User.fromMap(Map<dynamic, dynamic> value) {
    return User(
      uid: value["uid"],
      username: value['name'],
      email: value["email"],
      admin: value['admin'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': this.uid,
      'username': this.username,
      'email': this.email,
      'admin': this.admin,
    };
  }
}
