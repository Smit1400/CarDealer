import 'package:car_dealer/screens/price_predict.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:car_dealer/tabs/home_tab.dart';
import 'package:car_dealer/tabs/saved_tab.dart';
import 'package:car_dealer/tabs/search_tab.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:flutter/rendering.dart';
import 'package:car_dealer/widgets/bottom_tabs.dart';
import 'package:car_dealer/services/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    print("User ID:${_firebaseServices.getUserId()}");
    _tabsPageController = PageController();
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  List<CollapsibleItem> _items;
  String _headline;
  NetworkImage _avatarImg =
      NetworkImage('https://www.w3schools.com/howto/img_avatar.png');

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Home',
        icon: Icons.home,
        onPressed: () => setState(() => _headline = 'Home'),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Search car',
        icon: Icons.search,
        onPressed: () {
          setState(() => _headline = 'Search car');
        },
      ),
      CollapsibleItem(
          text: 'Sell car',
          icon: MdiIcons.car,
         onPressed : () => {
           Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PricePredict())),
            },
      ),
      CollapsibleItem(
        text: 'Wishlist',
        icon: Icons.check_box,
        onPressed: () => setState(() => _headline = 'Wishlist'),
      ),
      CollapsibleItem(
        text: 'Close sidebar',
        icon: Icons.close,
        onPressed: () => Navigator.pop(context),
      ),
      CollapsibleItem(
        text: 'Log out',
        icon: Icons.logout,
        onPressed: () => Navigator.pop(context),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Car Dealer App")),
      resizeToAvoidBottomPadding: false,
      // drawer: CollapsingDrawer(),
      drawer: CollapsibleSidebar(
        items: _items,
        avatarImg: _avatarImg,
        title: 'User name',
        body: Container(
    
        ),
        backgroundColor: Colors.black,
        maxWidth: 250,
        selectedTextColor: Colors.blue,
        textStyle: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        titleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        toggleTitleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
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
