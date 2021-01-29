import 'package:flutter/material.dart';
import 'package:car_dealer/screens/constants.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Home Page",
          style: Constants.regularHeading,
        ),
      ),
    );
  }
}