class User {
  final String phonenum;
  final String username;
  final String email;
  final bool admin;
  final String date;

  User({this.phonenum, this.username, this.email, this.admin: false, this.date});

  factory User.fromMap(Map<dynamic, dynamic> value) {
    // print("value =  $value");
    return User(
      phonenum: value["phonenum"],
      username: value['name'],
      email: value["email"],
      admin: value['admin'],
      date: value['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phonenum': this.phonenum,
      'username': this.username,
      'email': this.email,
      'admin': this.admin,
      'date': this.date,
    };
  }
}
