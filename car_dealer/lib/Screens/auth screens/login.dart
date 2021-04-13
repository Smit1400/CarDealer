import 'package:flutter/material.dart';
import 'package:car_dealer/widgets/alert.dart';
import 'package:car_dealer/services/database.dart';
import 'package:car_dealer/services/phone_auth.dart';
import 'package:car_dealer/widgets/dialog_box.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const mainColor = Color(0xFFAFEADC);
  static const secColor = Color(0xFF041E42);

  TextEditingController _phoneController = TextEditingController();
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return DialogBox(
            title: "Error",
            buttonText1: "Close Dialog",
            button1Func: () {
              Navigator.of(context).pop();
            },
            description: error,
            iconColor: Colors.red,
            icon: Icons.clear,
          );
        });
  }

  bool phoneError = false;
  bool clickedOnSignIn = false;
  bool validation() {
    if (_phoneController.text.length < 10 || _phoneController.text == null) {
      phoneError = true;
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Welcome to",
          style: TextStyle(
            fontSize: 16,
            color: secColor,
            height: 2,
          ),
        ),
        Text(
          "CarBuddy",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: secColor,
            letterSpacing: 2,
            height: 1,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Please login to continue",
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF1C1C1C),
            height: 1,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          maxLength: 10,
          textInputAction: TextInputAction.next,
          controller: _phoneController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Phone Number',
            errorText: phoneError ? "Enter a valid phone number" : null,
            hintStyle: TextStyle(
              fontSize: 16,
              color: secColor,
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
            fillColor: Colors.black12,
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
              color: Color(0xFF041E42), //Color(0xFF1C1C1C),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF041E42).withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: mainColor,
                ),
              ),
            ),
          ),
          onTap: () async {
            if (!validation()) {
              setState(() {});
            } else {
              // first check in cloud firestore whether user is registered
              bool userExist =
                  await Database().userExists("+91" + _phoneController.text);
              if (userExist == true) {
                // if user exists then we perform OTP verification
                setState(() {
                  clickedOnSignIn = true;
                });
                await PhoneAuth().phoneNumberVerificationLogin(
                    "+91" + _phoneController.text, context);
              } else {
                _alertDialogBuilder(
                    "Error! You are not a registered user! You can register on the Sign Up page");
                // AlertMessage().showAlertDialog(context,
                //     "Error! You are not a registered user! You can register on the Sign Up page");
              }
            }
          },
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
