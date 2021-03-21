import 'package:car_dealer/screens/price_predict.dart';
import 'package:car_dealer/screens/sell_car_page.dart';
import 'package:car_dealer/services/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:car_dealer/tabs/home_tab.dart';
import 'package:car_dealer/tabs/saved_tab.dart';
import 'package:car_dealer/tabs/search_tab.dart';


import 'package:car_dealer/widgets/bottom_tabs.dart';
import 'package:car_dealer/widgets/appbar.dart';


// import 'package:car_dealer/widgets/sidebar.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

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
  Widget build(BuildContext context,) {
    return Scaffold(
      appBar: MyAppBar(),

      resizeToAvoidBottomPadding: false,
      // drawer: MySideBar(),
      body: SafeArea(
      child:
      loading == true
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
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
                      // PricePredict(),
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
    ));
  }

 


}