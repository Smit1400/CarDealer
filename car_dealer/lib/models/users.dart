class User {
  final String uid;
  final String name;
  final String email;
  final bool admin;

  User({this.uid, this.name, this.email, this.admin: false});

  factory User.fromMap(Map<dynamic, dynamic> value) {
    return User(
      uid: value["uid"],
      name: value['name'],
      email: value["email"],
      admin: value['admin'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': this.uid,
      'name': this.name,
      'email': this.email,
      'admin': this.admin,
    };
  }
}
