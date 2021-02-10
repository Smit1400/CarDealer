import 'package:flutter/material.dart';
import 'package:car_dealer/tabs/home_tab.dart';
import 'package:car_dealer/tabs/saved_tab.dart';
import 'package:car_dealer/tabs/search_tab.dart';
import 'package:car_dealer/screens/extra.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
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
        icon: Icons.store,
        onPressed: () => setState(() => _headline = 'Home'),
        isSelected: true,
      ),
      CollapsibleItem(
        text: 'Search car',
        icon: Icons.search,
        onPressed: () => setState(() => _headline = 'Search car'),
      ),
      CollapsibleItem(
        text: 'Sell car',
        icon: Icons.car_rental,
        onPressed: () => setState(() => _headline = 'Sell car'),
      ),
      CollapsibleItem(
        text: 'Wishlist',
        icon: Icons.fact_check,
        onPressed: () => setState(() => _headline = 'Wishlist'),
      ),

      CollapsibleItem(
        text: 'Alarm',
        icon: Icons.access_alarm,
        onPressed: () => setState(() => _headline = 'Alarm'),
      ),
      CollapsibleItem(
        text: 'Event',
        icon: Icons.event,
        onPressed: () => setState(() => _headline = 'Event'),
      ),
      CollapsibleItem(
        text: 'Email',
        icon: Icons.email,
        onPressed: () => setState(() => _headline = 'Email'),
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CollapsibleSidebar(
        items: _items,
        avatarImg: _avatarImg,
        title: 'xyz prw',
        // body: _body(size, context),
        
        backgroundColor: Colors.black,
        selectedTextColor: Colors.blue,
        textStyle: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
        titleStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold),
        toggleTitleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
     body:
 Column(
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
    ));
  }
}
