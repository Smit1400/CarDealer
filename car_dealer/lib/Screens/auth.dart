import 'package:car_dealer/main.dart';
import 'package:flutter/material.dart';
import 'package:car_dealer/widgets/background2.dart';
import 'package:car_dealer/screens/auth2.dart';

// const Color mainColor=Color(0xFF5a5aff);
 

class AuthScreen extends StatelessWidget {
   static const mainColor=Color(0xFFAFEADC);
  static const secColor=Color(0xFF041E42);
  static const backgroundColor=Color(0xFFAFEADC);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: size.height * 0.05 ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Car Buddy",
              style: TextStyle(
                  fontFamily: "Alegreya",
                  fontWeight: FontWeight.bold,
                  color: secColor,
                  fontSize: 45),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Container(
            alignment: Alignment.center,
            child: new Image.asset('assets/images/img4.jpg'),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/auth');
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              textColor: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: size.width * 0.5,
                /*decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: new LinearGradient(colors: [
                      Color.fromARGB(255, 255, 136, 34),
                      Color.fromARGB(255, 255, 177, 41)
                    ])),*/
                    color: secColor,
                padding: const EdgeInsets.all(0),
                child: Text(
                  "Get Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white),
                ),
              ),
            ),
          ),
          /*Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "REGISTER",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),*/
        ],
      ),
    );
  }
}
