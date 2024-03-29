import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:car_dealer/screens/auth screens/login.dart';
import 'package:car_dealer/screens/auth screens/login_option.dart';
import 'package:car_dealer/screens/auth screens/signup.dart';
import 'package:car_dealer/screens/auth screens/signup_option.dart';
 
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
 
  bool login = true;
  static const mainColor=Color(0xFFAFEADC);
static const secColor=Color(0xFF041E42);
static const backgroundColor=Color(0xFFAFEADC);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secColor,//Color(0xFF1C1C1C),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
 
            GestureDetector(
              onTap: () {
                setState(() {
                  login = true;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login ? MediaQuery.of(context).size.height * 0.6 : MediaQuery.of(context).size.height * 0.4,
                child: CustomPaint(
                  painter: CurvePainter(login),
                  child: Container(
                    padding: EdgeInsets.only(bottom: login ? 0 : 55),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          child: login 
                          ? Login()
                          : LoginOption(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
 
            GestureDetector(
              onTap: () {
                setState(() {
                  login = false;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login ? MediaQuery.of(context).size.height * 0.4 : MediaQuery.of(context).size.height * 0.6,
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(top: login ? 55 : 0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child: !login 
                        ? SignUp()
                        : SignUpOption(),
                      ),
                    ),
                  )
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
 
class CurvePainter extends CustomPainter {
static const mainColor=Color(0xFFAFEADC);
static const secColor=Color(0xFF041E42);
static const backgroundColor=Color(0xFFAFEADC);
  bool outterCurve;
 
  CurvePainter(this.outterCurve);
 
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = mainColor;
    paint.style = PaintingStyle.fill;
 
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.5, outterCurve ? size.height + 110 : size.height - 110, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
 
    canvas.drawPath(path, paint);
  }
 
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
