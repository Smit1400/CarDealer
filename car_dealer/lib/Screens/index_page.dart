import 'package:car_dealer/screens/price_predict.dart';
import 'package:car_dealer/screens/sell_car_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:car_dealer/tabs/home_tab.dart';
import 'package:car_dealer/tabs/saved_tab.dart';
import 'package:car_dealer/tabs/search_tab.dart';

import 'package:car_dealer/widgets/bottom_tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:car_dealer/widgets/sidebar.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    // print("User ID:${_firebaseServices.getUserId()}");
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Car Dealer App"),
      actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 20.0),
            icon: Icon(Icons.power_settings_new),
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              //Confiramtion Dailoag 
              _exitApp(context);
            },
          ),
        ]),
     
      resizeToAvoidBottomPadding: false,
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
                PricePredict(),
                SellCar(),
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
          child: AlertDialog(
            title: Text('Do you want to exit this application?'),
            content: Text('See you again...'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              FlatButton(
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
