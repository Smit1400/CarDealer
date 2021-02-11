import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



import 'package:car_dealer/widgets/custom_button.dart';
import 'package:car_dealer/widgets/custom_input.dart';
import 'package:car_dealer/widgets/background.dart';
import 'package:car_dealer/components/constants.dart';



class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
        }
    );
  }

  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    setState(() {
      _registerFormLoading = true;
    });

    String _createAccountFeedback = await _createAccount();

    if(_createAccountFeedback != null) {
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
  String _registerPassword = "";
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Background(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                 alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  "\nSign Up",
                  style: Constants.mainHead,
                textAlign: TextAlign.left,
                ),
              ),
              Column(
                // resizeToAvoidBottomPadding: false,
                children: [
                  CustomInput(
                    hintText: "Email...",
                    onChanged: (value) {
                      _registerEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  //  CustomInput(
                  //   hintText: "Name..",
                  //   onChanged: (value) {
                  //     _registerEmail = value;
                  //   },
                  //   onSubmitted: (value) {
                  //     _passwordFocusNode.requestFocus();
                  //   },
                  //   textInputAction: TextInputAction.next,
                  // ),
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
                text:"Create account",
                onPressed: (){
                  _submitForm();
                },
                sizeW:size.width,
                    isLoading: _registerFormLoading,
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(
                  bottom: 26.0,
                ),
                child: 
                Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                     Navigator.pushNamed(context, '/login')
                },
                child: Text(
                  "Back To Login",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA)
                  ),
                ),
              ),
            ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
