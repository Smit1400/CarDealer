import 'dart:math';
import 'dart:ui';

import 'package:car_dealer/screens/admin_page.dart';
import 'package:car_dealer/screens/admin_analysis.dart';

import 'package:car_dealer/screens/price_predict.dart';
import 'package:car_dealer/screens/sell_car_page.dart';

import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/screens/my_sell_cars.dart';
import 'package:car_dealer/screens/add_admin.dart';
import 'package:car_dealer/screens/index_page.dart';

import 'package:car_dealer/screens/faq.dart';
import 'package:car_dealer/widgets/dialog_box.dart';

import 'package:flutter/material.dart';
import 'package:car_dealer/widgets/custom_alert_dialog.dart';

import 'package:google_fonts/google_fonts.dart';

class AdminHomeScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  AdminHomeScreen({this.user});
  @override
  _NewHomescreenstate createState() => _NewHomescreenstate();
}

class _NewHomescreenstate extends State<AdminHomeScreen> {
  PageController _tabsPageController;
  int index = 0;
  double value = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  checkUserCars() async {
    List userCars =
        widget.user['car_list'].isEmpty ? [] : widget.user['car_list'];
    int count = 0;
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;
    for (int i = 0; i < userCars.length; i++) {
      int month = DateTime.parse(userCars[i].substring(5)).month;
      int year = DateTime.parse(userCars[i].substring(5)).year;
      if ((month == currentMonth) && (year == currentYear)) {
        setState(() {
          count += 1;
        });
      }
    }
    print("Count = $count");
    if (count >= 3) {
      return false;
    }
    return true;
  }

  errorDialogBox(description, context) async {
    await showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            title: "Warning",
            buttonText1: 'OK',
            button1Func: () {
              Navigator.of(context).pop();
            },
            icon: Icons.clear,
            description: '$description',
            iconColor: Colors.red,
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                          "${widget.user['username']}",
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
                                builder: (context) => IndexPage(),
                              ),
                            );
                          },
                          leading:
                              Icon(Icons.home, size: 35, color: Colors.white),
                          title: Text(
                            "Cars",
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Constants.secColor, fontSize: 22),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () async{
                            if (await checkUserCars()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SellCar(
                                    email: widget.user['email'],
                                    username: widget.user['username'],
                                    carList: widget.user['car_list'],
                                  ),
                                ),
                              );
                            } else {
                              await errorDialogBox(
                                  "Your Limit is over for this month.",
                                  context);
                            }
                          },
                          leading: Image.asset("assets/images/sell_car2.png",
                              width: 35, height: 35, color: Colors.white),
                          title: Text(
                            "Sell Car",
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Constants.secColor, fontSize: 22),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Image.asset("assets/images/rupee3.png",
                              width: 35, height: 35, color: Colors.white),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PricePredict(),
                              ),
                            );
                          },
                          title: Text(
                            "Predict Price",
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Constants.secColor, fontSize: 22),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MySellCars(),
                              ),
                            );
                          },
                          leading:
                              Icon(Icons.list, size: 35, color: Colors.white),
                          title: Text(
                            "My cars",
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Constants.secColor, fontSize: 22),
                            ),
                          ),
                        ),
                        //  ListTile(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => AdminAnalysis(),
                        //       ),
                        //     );
                        //   },
                        //   leading:
                        //       Icon(Icons.analytics_outlined,size: 35, color: Colors.white),
                        //   title: Text(
                        //     "Admin Analysis",
                        //     style: GoogleFonts.oswald(
                        //       textStyle: TextStyle(
                        //           color: Constants.secColor, fontSize: 22),
                        //     ),
                        //   ),
                        // ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminPage(),
                              ),
                            );
                          },
                          leading:
                              Icon(Icons.check, size: 35, color: Colors.white),
                          title: Text(
                            "Car approval",
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Constants.secColor, fontSize: 22),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => faq(),
                              ),
                            );
                          },
                          leading: Icon(Icons.question_answer_rounded,
                              size: 35, color: Colors.white),
                          title: Text(
                            "Frequently asked Questions",
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Constants.secColor, fontSize: 22),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => CustomAlertDialog());
                          },
                          leading:
                              Icon(Icons.logout, size: 35, color: Colors.white),
                          title: Text(
                            "Logout",
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  color: Constants.secColor, fontSize: 22),
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
                      child: AdminAnalysis()
                      // Scaffold(
                      //   appBar: MyAppBar(),
                      //   body: Column(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Expanded(
                      //         child: PageView(
                      //           physics: NeverScrollableScrollPhysics(),
                      //           controller: _tabsPageController,
                      //           onPageChanged: (num) {
                      //             setState(() {
                      //               index = num;
                      //             });
                      //           },
                      //           children: [
                      //             HomeTab(),
                      //             SearchTab(),
                      //             SavedTab(),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   bottomNavigationBar: ConvexAppBar(
                      //     backgroundColor: Color(0xFF041E42),
                      //     style: TabStyle.reactCircle,
                      //     items: [
                      //       TabItem(icon: Icons.home_outlined),
                      //       TabItem(icon: Icons.search_outlined),
                      //       TabItem(icon: Icons.save_alt_outlined),
                      //     ],
                      //     initialActiveIndex: index,
                      //     onTap: (num) {
                      //       _tabsPageController.animateToPage(num,
                      //           duration: Duration(milliseconds: 300),
                      //           curve: Curves.easeOutCubic);
                      //     },
                      //   ),
                      // ),
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
