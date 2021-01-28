import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:car_dealer/screens/landing_page.dart';
// import 'package:car_dealer/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: LandingPage(),
    );
  }
}
