import 'package:car_dealer/screens/first_page.dart';
import 'package:car_dealer/screens/new_home_screen.dart';
import 'package:car_dealer/screens/admin_new_home_screen.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:car_dealer/services/firebase_auth.dart';

class LandingPage extends StatelessWidget {
  Map<String, dynamic> user;
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
                  return FirstScreen();
                } else {
                  return Wrapper();
                  //   if (userx['admin'])
                  //     return NewHomeScreen();
                  //   else
                  //     return AdminHomeScreen();
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

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  FirebaseServices _firebaseServices = FirebaseServices();
  Map<String, dynamic> user;
  bool showAdmin = false;
  bool loading = true;
  fetchData() async {
    await _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .get()
        .then((doc) {
      setState(() {
        user = doc.data();
        loading = false;
      });
    }).catchError((error) {
      print("[ERROR] ${error.toString()}");
      loading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
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
    } else {
      print(user);
      // u.User currentUser = u.User.fromMap(user);
      if (user['admin']) {
        return AdminHomeScreen(user: user);
      } else {
        return NewHomeScreen(user: user);
      }
    }
  }
}
