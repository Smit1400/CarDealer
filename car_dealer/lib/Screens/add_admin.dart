import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:car_dealer/services/firebase_auth.dart';
import 'package:car_dealer/widgets/custom_button.dart';
import 'package:car_dealer/widgets/custom_input.dart';
import 'package:car_dealer/widgets/background.dart';
// import 'package:car_dealer/components/constants.dart';
const Color mainColor=Color(0xFF436eee);

class AdminRegisterPage extends StatefulWidget {
  @override
  _AdminRegisterPageState createState() => _AdminRegisterPageState();
}

class _AdminRegisterPageState extends State<AdminRegisterPage> {
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
              // ignore: deprecated_member_use
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
          'phonenum':"+91"+_registerPhone,
          'admin':true
          // 42
        })
        .then((value) => Navigator.pushNamed(context, '/admin'))
        .catchError((error) => print("Failed to add admin user : $error"));
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
  String _registerPhone = "";

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height:size.height * 0.09),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "\nCreate  new account",
                   style: TextStyle(
                    fontFamily: "Alegreya",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      fontSize: 37),
                    textAlign: TextAlign.left,
                  ),
                ),
                Column(
                  // resizeToAvoidBottomPadding: false,
                  children: [
                    CustomInput(
                      hintText: "Name...",
                      onChanged: (value) {
                        _registerName = value;
                      },
                      onSubmitted: (value) {
                        _emailFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: "Email...",
                      onChanged: (value) {
                        _registerEmail = value;
                      },
                      focusNode: _emailFocusNode,
                      onSubmitted: (value) {
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                     CustomInput(
                      hintText: "Phone number....",
                      onChanged: (value) {
                        _registerPhone = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: false,
                      onSubmitted: (value) {
                        _submitForm();
                      },
                    ),
                    CustomInput(
                      hintText: "Password...",
                      onChanged: (value) {
                        _registerPassword = value;
                      },
                      focusNode: _passwordFocusNode,
                      isPasswordField: true,
                      onSubmitted: (value) {
                        _submitForm();
                      },
                    ),
                    SubmitBtn(
                      text: "Create account",
                      onPressed: () {
                        _submitForm();
                      },
                      sizeW: size.width,
                      isLoading: _registerFormLoading,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 26.0,
                  ),
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: GestureDetector(
                      onTap: () => {Navigator.pushNamed(context, '/login')},
                      child: Text(
                        "Back To Login",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2661FA)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
