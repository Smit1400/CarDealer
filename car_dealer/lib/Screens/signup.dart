import 'package:car_dealer/screens/database.dart';
import 'package:car_dealer/screens/phone_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_dealer/widgets/alert.dart';
import 'package:car_dealer/services/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static const mainColor = Color(0xFFAFEADC);
  static const secColor = Color(0xFF041E42);
  static const backgroundColor = Color(0xFFAFEADC);

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool admin = false;
  bool nameError = false;
  bool emailError = false;
  bool phoneError = false;
  bool clickedOnSignUp = false;

  bool validation() {
    bool retVal = true;
    if (_nameController.text == "" || _nameController.text == null) {
      nameError = true;
      retVal = false;
    }
    if (_emailController.text == "" || _emailController.text == null) {
      emailError = true;
      retVal = false;
    }
    if (_phoneController.text.length < 10 || _phoneController.text == null) {
      phoneError = true;
      retVal = false;
    }
    return retVal;
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
          controller: _nameController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter name',
            errorText: nameError ? "Please enter first name" : null,
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
         
          controller: _emailController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter Email ',
            errorText: emailError ? "Please enter your Email" : null,
            hintStyle: TextStyle(
              fontSize: 16,
              color: Color(0xFF3F3C31),
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
          maxLength: 10,
          controller: _phoneController,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Phone Number',
            errorText: phoneError ? "Enter a valid phone number" : null,
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
        clickedOnSignUp ? Text('wait for verification code..') : Container(),
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
          onTap: () async {
            // first check in cloud firestore whether user is registered
            if (!validation()) {
              setState(() {});
            } else {
              bool userExist =
                  await Database().userExists("+91" + _phoneController.text);
              if (userExist == false) {
                // we perform OTP verification only if it is a new user
                setState(() {
                  clickedOnSignUp = true;
                });
                await PhoneAuth().phoneNumberVerificationRegister(
                    "+91" + _phoneController.text,
                    _nameController.text,
                    _emailController.text,
                    admin,
                    context);
              } else {
                AlertMessage().showAlertDialog(context, "Error , an user with this phone number already exists!");
              }
            }
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
