import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:car_dealer/services/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static const mainColor = Color(0xFFAFEADC);
  static const secColor = Color(0xFF041E42);
  static const backgroundColor = Color(0xFFAFEADC);

  FirebaseServices _firebaseServices = FirebaseServices();
  var _user;

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<String> _signUp() async {
    try {
      var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);

      _user = result.user;
      return null;
      // assert(_user != null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      print("User Added");

      // return user;
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> createUser() async {
    String str = await _signUp();
    print(_user.uid);

    // Call the user's CollectionReference to add a new user
    await _firebaseServices.usersRef
        .doc(_user.uid)
        .set({
          'username': _registerName,
          'email': _registerEmail,

          // 42
        })
        .then((value) => Navigator.pushNamed(context, '/admin'))
        .catchError((error) => print("Failed to add user: $error"));
    return str;
  }

  void _submitForm() async {
    setState(() {
      _registerFormLoading = true;
    });

    String _createAccountFeedback = await createUser();

    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);

      setState(() {
        _registerFormLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  bool _registerFormLoading = false;
  String _registerEmail = "";
  String _registerName = "";
  String _registerPassword = "";
  FocusNode _passwordFocusNode, _emailFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Sign up with",
          style: TextStyle(
            fontSize: 16,
            color: mainColor,
            height: 2,
          ),
        ),
        Text(
          "CarBuddy",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: mainColor,
            letterSpacing: 2,
            height: 1,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          onChanged: (value) {
            _registerName = value;
          },
          onSubmitted: (value) {
            _emailFocusNode.requestFocus();
          },
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.white
                ),
          decoration: InputDecoration(
            hintText: 'Enter name',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Color(0xFF3F3C31),
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.black38,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          onChanged: (value) {
            _registerEmail = value;
          },
          focusNode: _emailFocusNode,
          onSubmitted: (value) {
            _passwordFocusNode.requestFocus();
          },
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.white
                ),
          decoration: InputDecoration(
            hintText: 'Enter Email ',
            hintStyle: TextStyle(
              fontSize: 16,
              color:  Color(0xFF3F3C31),
              //decorationColor: Colors.white10,//Font color change
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.black38,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          obscureText: true,
          onChanged: (value) {
            _registerPassword = value;
          },
          focusNode: _passwordFocusNode,
          // isPasswordField: true,
          onSubmitted: (value) {
            _submitForm();
          },
          keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Colors.white
                ),
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: TextStyle(
              fontSize: 16,
              color: Color(0xFF3F3C31),
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: Colors.black38,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        InkWell(
          child: Container(
            
            height: 40,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: mainColor,
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "SIGN UP",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: secColor,
                ),
              ),
            ),
          ),
          onTap: () {
            _submitForm();
          },
          //isLoading: _registerFormLoading,
        ),
        SizedBox(
          height: 24,
        ),

        /* Text(
          "Or Signup with",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFFF3D657),
            height: 1,
          ),
        ),

        SizedBox(
          height: 16,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Icon(
              Entypo.facebook_with_circle,
              size: 32,
              color: Color(0xFFF3D657),
            ),

            SizedBox(
              width: 24,
            ),

            Icon(
              Entypo.google__with_circle,
              size: 32,
              color: Color(0xFFF3D657),
            ),

          ],
        )
*/
      ],
    );
  }
}
