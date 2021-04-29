class User {
  final String phonenum;
  final String username;
  final String email;
  final bool admin;
  final String password;
  final String date;
  final List car_list;

  User(
      {this.phonenum, this.username, this.email, this.admin: false, this.password ,this.date, this.car_list});

  factory User.fromMap(Map<dynamic, dynamic> value) {
    // print("value =  $value");
    return User(
      phonenum: value["phonenum"],
      username: value['username'],
      email: value["email"],
      admin: value['admin'],
      date: value['date'],
      password: value['password'],
      car_list: value['car_list'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phonenum': this.phonenum,
      'username': this.username,
      'email': this.email,
      'admin': this.admin,
      'password':this.password,
      'date': this.date,
      'car_list': this.car_list,
    };
  }
}
