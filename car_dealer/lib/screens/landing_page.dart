import 'package:car_dealer/screens/auth.dart';
// import 'package:car_dealer/screens/auth2.dart';
import 'package:car_dealer/Screens/new_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/screens/index_page.dart';
import 'package:car_dealer/screens/auth2.dart';
// import 'package:car_dealer/screens/auth.dart';
import 'package:lottie/lottie.dart';


class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // If Firebase App init, snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Lottie.asset(
                "assets/images/44656-error.json",
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Lottie.asset(
                      "assets/images/44656-error.json",
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }

              if (streamSnapshot.connectionState == ConnectionState.active) {
                User _user = streamSnapshot.data;
                if (_user == null) {
                  return AuthScreen();
                } else {
                  return NewHomeScreen();
                }
              }

              // Checking the auth state - Loading
              return Scaffold(
                body: Center(
                  child: Lottie.asset(
                    "assets/images/old-car-moving-animation.json",
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }

        // Connecting to Firebase - Loading
        return Scaffold(
          body: Center(
            child: Lottie.asset(
              "assets/images/old-car-moving-animation.json",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
