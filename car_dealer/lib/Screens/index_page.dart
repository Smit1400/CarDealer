import 'package:car_dealer/Screens/admin_page.dart';
// import 'package:car_dealer/screens/price_predict.dart';
import 'package:car_dealer/screens/sell_car_page.dart';
import 'package:car_dealer/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:car_dealer/tabs/home_tab.dart';
import 'package:car_dealer/tabs/saved_tab.dart';
import 'package:car_dealer/tabs/search_tab.dart';
import 'package:car_dealer/widgets/bottom_tabs.dart';
import 'package:car_dealer/widgets/loading_page.dart';
import 'package:car_dealer/widgets/appbar.dart';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseServices _firebaseServices = FirebaseServices();
  Map<String, dynamic> user;
  bool loading;
  PageController _tabsPageController;
  int _selectedTab = 0;

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
    return loading
        ? LoadingPage()
        : Scaffold(
            appBar: MyAppBar(user:user),
            // AppBar(
            //     backgroundColor: Colors.white,
            //     title: Text(
            //       "Car Dealer App",
            //       style: TextStyle(color: Colors.black),
            //     ),
            //     actions: <Widget>[
            //       IconButton(
            //         padding: EdgeInsets.only(right: 20.0),
            //         icon: Icon(Icons.power_settings_new),
            //         iconSize: 30,
            //         color: Colors.red,
            //         onPressed: () {
            //           //Confiramtion Dailoag
            //           _exitApp(context);
            //         },
            //       ),
            //       user['admin'] == true
            //           ? IconButton(
            //               padding: EdgeInsets.only(right: 20.0),
            //               icon: Icon(Icons.car_rental),
            //               iconSize: 30,
            //               color: Colors.black,
            //               onPressed: () {
            //                 Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                     builder: (context) => AdminPage(),
            //                   ),
            //                 );
            //               },
            //             )
            //           : Container(),
            //     ]),

            resizeToAvoidBottomInset: false,
            // drawer: MySideBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PageView(
                    controller: _tabsPageController,
                    onPageChanged: (num) {
                      setState(() {
                        _selectedTab = num;
                      });
                    },
                    children: [
                      HomeTab(),
                      SearchTab(),
                      SavedTab(),
                      // SellCar(
                      //   email: user["email"],
                      //   username: user["username"],
                      // ),
                    ],
                  ),
                ),
                BottomTabs(
                  selectedTab: _selectedTab,
                  tabPressed: (num) {
                    _tabsPageController.animateToPage(num,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic);
                  },
                ),
              ],
            ),
          );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Do you want to exit this application?'),
            content: Text('See you again...'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  signOut();
                  print("Quit");
                  Navigator.pushNamed(context, "/");
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
