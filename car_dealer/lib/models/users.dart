class User {
  final String uid;
  final String name;
  final String email;
  final bool admin;
  final String token;

  User({this.uid, this.name, this.email, this.admin: false, this.token});

  factory User.fromMap(Map<dynamic, dynamic> value) {
    return User(
      uid: value["uid"],
      name: value['name'],
      email: value["email"],
      admin: value['admin'],
      token: value['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': this.uid,
      'name': this.name,
      'email': this.email,
      'admin': this.admin,
      'token': this.token,
    };
  }
}
