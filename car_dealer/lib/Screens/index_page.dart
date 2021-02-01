import 'package:flutter/material.dart';
import 'package:car_dealer/tabs/home_tab.dart';
import 'package:car_dealer/tabs/saved_tab.dart';
import 'package:car_dealer/tabs/search_tab.dart';
// import 'package:car_dealer/widgets/bottom_tabs.dart';
import 'package:flutter/rendering.dart';
import 'package:car_dealer/widgets/bottom_tabs.dart';
import 'package:car_dealer/services/firebase_auth.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  FirebaseServices _firebaseServices =FirebaseServices();
  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    print("User ID:${_firebaseServices.getUserId()}");
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
}
