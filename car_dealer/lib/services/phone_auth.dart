import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:car_dealer/models/users.dart';
import 'package:car_dealer/services/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/widgets/dialog_box.dart';
import 'package:path/path.dart';


class PhoneAuth {

  Future<void> phoneNumberVerificationLogin(
      String phoneNumber, BuildContext context) async {
    final TextEditingController _codeController = TextEditingController();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: null,
        verificationFailed: (FirebaseAuthException authException) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Verification Falied'))
              );
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Enter Code"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);
                        UserCredential userCredential =
                            await _auth.signInWithCredential(credential);
                        var user = userCredential.user;
                        QuerySnapshot qs = await FirebaseFirestore.instance
                            .collection('Users')
                            .where('phonenum',
                                isEqualTo: FirebaseAuth
                                    .instance.currentUser.phoneNumber)
                            .get();
                        if (qs.docs.isNotEmpty) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => true);
                        }
                        // else{

                        // }
                      },
                      child: Text(
                        "Confirm",
                        style: GoogleFonts.sourceSansPro(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>( Constants.secColor),
                      ),
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  Future<void> phoneNumberVerificationRegister(String phoneNumber, String username,
      String email, bool admin, BuildContext context) async {
    final TextEditingController _codeController = TextEditingController();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: null,
        verificationFailed: (FirebaseAuthException authException) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Verification Falied')));
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Enter Code"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        keyboardType:TextInputType.number,
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);
                        UserCredential userCredential =
                            await _auth.signInWithCredential(credential);
                        var user = userCredential.user;
                        await Database()
                            .storeUserDetails(
                                user, username, phoneNumber, admin, email)
                            .then((value) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (route) => true);
                        });
                      },
                      child: Text(
                        "Confirm",
                        style: GoogleFonts.sourceSansPro(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Constants.secColor),
                      ),
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  Future<User> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
