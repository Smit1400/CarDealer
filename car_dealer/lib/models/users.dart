class User {
  final String uid;
  final String name;
  final String email;

  User({this.uid,this.name,this.email});

  factory User.fromMap(Map<dynamic, dynamic> value) {
    return User(uid: value["uid"],name:value['name'], email: value["email"]);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'uid': uid,name:name, 'email': email};
  }
}
