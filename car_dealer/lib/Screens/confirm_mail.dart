import 'package:flutter/material.dart';
// static String id = 'confirm-email';

class ConfirmEmail extends StatelessWidget {
  const ConfirmEmail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Text(
        'An email has just been sent to you, Click the link provided to complete registration',
        style: TextStyle(color: Colors.white, fontSize: 16),
      )),
    );
  }
}