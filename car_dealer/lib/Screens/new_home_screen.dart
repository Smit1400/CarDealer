import 'dart:math';
import 'dart:ui';

import 'package:car_dealer/Screens/admin_page.dart';
import 'package:car_dealer/Screens/price_predict.dart';
import 'package:car_dealer/Screens/sell_car_page.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/services/firebase_auth.dart';
import 'package:car_dealer/tabs/home_tab.dart';
import 'package:car_dealer/tabs/saved_tab.dart';
import 'package:car_dealer/tabs/search_tab.dart';
import 'package:car_dealer/widgets/appbar.dart';
import 'package:car_dealer/widgets/bottom_tabs.dart';
import 'package:car_dealer/widgets/loading_page.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewHomeScreen extends StatefulWidget {
  @override
  _NewHomeScreenState createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseServices _firebaseServices = FirebaseServices();
  Map<String, dynamic> user;
  bool loading;
  PageController _tabsPageController;
  int index = 0;
  double value = 0;

  @override
  void initState() {
    // print("User ID:${_firebaseServices.getUserId()}");
    getUserData();
    _tabsPageController = PageController();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      loading = true;
    });
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
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return loading
        ? LoadingPage()
        : Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFAFEADC),
                  ),
                ),
                SafeArea(
                  child: Container(
                    width: width * 0.8,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawerHeader(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 50,
                                ),
                                backgroundColor: Colors.grey[400],
                              ),
                              SizedBox(height: 15),
                              Text(
                                "${user['username']}",
                                style: GoogleFonts.oswald(
                                  textStyle: TextStyle(
                                    color: Constants.secColor,
                                    fontSize: 24,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SellCar(
                                        email: user['email'],
                                        username: user['username'],
                                      ),
                                    ),
                                  );
                                },
                                leading: Image.asset("assets/images/rupee3.png",
                                    width: 35, height: 35, color: Colors.white),
                                title: Text(
                                  "Sell Car",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        color: Constants.secColor,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PricePredict(),
                                    ),
                                  );
                                },
                                leading: Image.asset(
                                    "assets/images/sell_car2.png",
                                    width: 35,
                                    height: 35,
                                    color: Colors.white),
                                title: Text(
                                  "Predict Price",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        color: Constants.secColor,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              user['admin'] == true
                                  ? ListTile(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AdminPage(),
                                          ),
                                        );
                                      },
                                      leading: Icon(Icons.check,
                                          size: 35, color: Colors.white),
                                      title: Text(
                                        "Car approval",
                                        style: GoogleFonts.oswald(
                                          textStyle: TextStyle(
                                              color: Constants.secColor,
                                              fontSize: 22),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              ListTile(
                                leading: Icon(Icons.logout,
                                    size: 35, color: Colors.white),
                                title: Text(
                                  "Logout",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        color: Constants.secColor,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.person,
                                    size: 35, color: Colors.white),
                                title: Text(
                                  "Profile Page",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        color: Constants.secColor,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                TweenAnimationBuilder(
                    tween: Tween<double>(
                      begin: 0,
                      end: value,
                    ),
                    duration: Duration(milliseconds: 500),
                    builder: (_, double val, __) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..setEntry(0, 3, 200 * val)
                          ..rotateY((pi / 5) * val),
                        child: ClipRRect(
                          borderRadius: value == 1
                              ? BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))
                              : BorderRadius.zero,
                          child: Scaffold(
                            appBar: MyAppBar(),
                            body: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: PageView(
                                    physics: NeverScrollableScrollPhysics(),
                                    controller: _tabsPageController,
                                    onPageChanged: (num) {
                                      setState(() {
                                        index = num;
                                      });
                                    },
                                    children: [
                                      HomeTab(),
                                      SearchTab(),
                                      SavedTab(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            bottomNavigationBar: ConvexAppBar(
                              backgroundColor: Color(0xFF041E42),
                              style: TabStyle.reactCircle,
                              items: [
                                TabItem(icon: Icons.home_outlined),
                                TabItem(icon: Icons.search_outlined),
                                TabItem(icon: Icons.save_alt_outlined),
                              ],
                              initialActiveIndex: index,
                              onTap: (num) {
                                _tabsPageController.animateToPage(num,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeOutCubic);
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                GestureDetector(
                  onHorizontalDragUpdate: (val) {
                    if (val.delta.dx > 0) {
                      setState(() {
                        value = 1;
                      });
                    } else {
                      setState(() {
                        value = 0;
                      });
                    }
                  },
                ),
              ],
            ),
          );
  }
}
