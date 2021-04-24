import 'dart:math';
import 'package:car_dealer/Screens/login_page.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  // static const TextStyle goldcoinGreyStyle = TextStyle(
  //     color: Colors.grey,
  //     fontSize: 20.0,
  //     fontWeight: FontWeight.bold,
  //     fontFamily: "Product Sans");

  // static const TextStyle goldCoinWhiteStyle = TextStyle(
  //     color: Colors.white,
  //     fontSize: 20.0,
  //     fontWeight: FontWeight.bold,
  //     fontFamily: "Product Sans");

  // static const TextStyle greyStyle =
  //     TextStyle(fontSize: 40.0, color: Colors.grey, fontFamily: "Product Sans");
  // static const TextStyle whiteStyle = TextStyle(
  //     fontSize: 40.0, color: Colors.white, fontFamily: "Product Sans");

  // static const TextStyle boldStyle = TextStyle(
  //   fontSize: 50.0,
  //   color: Colors.black,
  //   fontFamily: "Product Sans",
  //   fontWeight: FontWeight.bold,
  // );

  // static const TextStyle descriptionGreyStyle = TextStyle(
  //   color: Colors.grey,
  //   fontSize: 20.0,
  //   fontFamily: "Product Sans",
  // );

  // static const TextStyle descriptionWhiteStyle = TextStyle(
  //   color: Colors.white,
  //   fontSize: 20.0,
  //   fontFamily: "Product Sans",
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: [
    Container(
      color:  Color(0xFF041E42),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "CarBuddy",
                 style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,),
                ),
                ),
                GestureDetector(
                  child: Text(
                    "Skip",
                    style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,),
                ),
                ),
                  onTap: () {
                    Navigator.pushNamed(context, '/auth');
                  },
                ),
              ],
            ),
          ),
          Image.asset("assets/images/circle-cropped (2).png"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "CarBuddy",
                     style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color:Colors.white, fontSize: 40 , fontWeight: FontWeight.bold,),),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  " -Great Prices. Great Vehicles. Great Service.\n",
                   style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color:Colors.white, fontSize: 20 ),),
                ),
              ],
            ),
          )
        ],
      ),
    ),
      
    Container(
      color:Color(0xFFAFEADC),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "CarBuddy",style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color:Color(0xFF041E42), fontSize: 20 , fontWeight: FontWeight.bold,),),),
                GestureDetector(
                  child: Text(
                    "Skip",
                    style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color:Color(0xFF041E42), fontSize: 20 , fontWeight: FontWeight.bold,),),),
                  onTap: () {
                    Navigator.pushNamed(context, '/auth');
                  },
                ),
              ],
            ),
          ),
          Image.asset("assets/images/circle-cropped.png"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "CarBuddy",
                  style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color:Color(0xFF041E42), fontSize: 40 , fontWeight: FontWeight.bold,),),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  " -The effort-free way to buy a car.\n",
                  style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color:Color(0xFF041E42), fontSize: 20 ),),
                ),
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: Color(0xFF041E42),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "CarBuddy",
                 style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,),
                ),
                ),
                 GestureDetector(
                  child: Text(
                    "Skip",
                   style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,),
                ),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/auth');
                  },
                ),
              ],
            ),
          ),
          Image.asset("assets/images/circle-cropped (1).png"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Text(
                  "CarBuddy",
                     style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color:Colors.white, fontSize: 40 , fontWeight: FontWeight.bold,),),
                     ),
                     // whiteStyle,
              
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  " -Explore the corners by driving the best cars.\n",
                 style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color:Colors.white, fontSize: 20, ),),
                ),
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color:Color(0xFFAFEADC),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "CarBuddy",style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color:Color(0xFF041E42), fontSize: 20 , fontWeight: FontWeight.bold,),),),
                GestureDetector(
                  child: Text(
                    "Skip",
                   style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color:Color(0xFF041E42), fontSize: 20 , fontWeight: FontWeight.bold,),),),
                  onTap: () {
                    Navigator.pushNamed(context, '/auth');
                  },
                ),
              ],
            ),
          ),
          Image.asset("assets/images/circle-cropped (3).png"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "CarBuddy",
                  style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color:Color(0xFF041E42), fontSize: 40 , fontWeight: FontWeight.bold,),),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  " -We stand behind every car we sell.\n",
                  style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color:Color(0xFF041E42), fontSize: 20 ),),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  ],
        enableLoop: true,
        fullTransitionValue: 300,
        positionSlideIcon: 0.8,
        slideIconWidget: Icon(Icons.arrow_back_ios),
        waveType: WaveType.liquidReveal,
      ),
    );
  }
}


    // style: GoogleFonts.oswald(
    //                           textStyle: TextStyle(
    //                               color: Constants.secColor, fontSize: 22),