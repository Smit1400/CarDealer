import 'package:car_dealer/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:car_dealer/tabs/home_tab.dart';
import 'package:car_dealer/tabs/saved_tab.dart';
import 'package:car_dealer/tabs/search_tab.dart';
import 'package:car_dealer/widgets/bottom_tabs.dart';
import 'package:car_dealer/widgets/loading_page.dart';
import 'package:car_dealer/widgets/appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  PageController _tabsPageController;
  // int _selectedTab = 0;
    int index = 0;

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
       appBar: AppBar(
    backgroundColor: Color(0xFF041E42),
    title: Text(
      "Cars",
      style: GoogleFonts.oswald(),
    )
       ),
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
    );

    //  Scaffold(
    //    appBar: AppBar(
    // backgroundColor: Color(0xFF041E42),
    // title: Text(
    //   "Cars",
    //   style: GoogleFonts.oswald(),
    // )
    //    ),

    //     resizeToAvoidBottomInset: false,
    //     // drawer: MySideBar(),
    //     body: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Expanded(
    //           child: PageView(
    //             physics: NeverScrollableScrollPhysics(),
    //             controller: _tabsPageController,
    //             onPageChanged: (num) {
    //               setState(() {
    //                 _selectedTab = num;
    //               });
    //             },
    //             children: [
    //               HomeTab(),
    //               SearchTab(),
    //               SavedTab(),
    //             ],
    //           ),
    //         ),
    //         BottomTabs(
    //           selectedTab: _selectedTab,
    //           tabPressed: (num) {
    //             _tabsPageController.animateToPage(num,
    //                 duration: Duration(milliseconds: 300),
    //                 curve: Curves.easeOutCubic);
    //           },
    //         ),
    //       ],
    //     ),
    //   );
  }
}
