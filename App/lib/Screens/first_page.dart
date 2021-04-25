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
  int page = 0;
  LiquidController liquidController;
  UpdateType updateType;
  bool slideIcon = true;
  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((page ?? 0) - index).abs(),
      ),
    );
    double zoom = 1.0 + (2.0 - 1.0) * selectedness;
    return Container(
      width: 25.0,
      child: Center(
        child: Material(
          color: Colors.white,
          type: MaterialType.circle,
          child: Container(
            width: 8.0 * zoom,
            height: 8.0 * zoom,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    pageChangeCallback(int lpage) {
      setState(() {
        print(lpage);
        if (lpage == 3) {
          slideIcon = false;
        } else {
          slideIcon = true;
        }
        page = lpage;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            LiquidSwipe(
              pages: [
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
                            Text(""),
                            GestureDetector(
                              child: Text(
                                "Skip",
                                style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              " -Great Prices. Great Vehicles. Great Service.\n",
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Color(0xFFAFEADC),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(""),
                            GestureDetector(
                              child: Text(
                                "Skip",
                                style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                    color: Color(0xFF041E42),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
                                  color: Color(0xFF041E42),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              " -The effort-free way to buy a car.\n",
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                    color: Color(0xFF041E42), fontSize: 20),
                              ),
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
                            Text(""),
                            GestureDetector(
                              child: Text(
                                "Skip",
                                style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // whiteStyle,

                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              " -Explore the corners by driving the best cars.\n",
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Color(0xFFAFEADC),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(""),
                            GestureDetector(
                              child: Text(
                                "Sign In",
                                style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                    color: Color(0xFF041E42),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
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
                                  color: Color(0xFF041E42),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              " -We stand behind every car we sell.\n",
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                    color: Color(0xFF041E42), fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
              enableLoop: false,
              fullTransitionValue: 300,
              // enableSideReveal: slideIcon,
              positionSlideIcon: 0.8,
              onPageChangeCallback: pageChangeCallback,
              slideIconWidget: slideIcon?Icon(Icons.arrow_back_ios, color: Colors.white):null,
              waveType: WaveType.liquidReveal,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List<Widget>.generate(4, _buildDot),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
