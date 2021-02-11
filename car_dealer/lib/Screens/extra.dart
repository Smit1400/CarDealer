import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sidebar ui',
      home: Scaffold(
        body: SidebarPage(),
      ),
    );
  }
}

class SidebarPage extends StatefulWidget {
  @override
  _SidebarPageState createState() => _SidebarPageState();
}

class _SidebarPageState extends State<SidebarPage> {
  List<CollapsibleItem> _items;
  String _headline;
  NetworkImage _avatarImg =
      NetworkImage('https://www.w3schools.com/howto/img_avatar.png');

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    _headline = _items.firstWhere((item) => item.isSelected).text;
  }

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
    var size = MediaQuery.of(context).size;
    return Material(
      type: MaterialType.transparency,
      child:
    SafeArea(
      child: CollapsibleSidebar(
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
     body:Container(),
      ),
    ));
  }

  // Widget _body(Size size, BuildContext context) {
  //   return Container(
  //     height: double.infinity,
  //     width: double.infinity,
  //     color: Colors.blueGrey[50],
  //     child: Center(
  //       child: Transform.rotate(
  //         angle: math.pi / 2,
  //         child: Transform.translate(
  //           offset: Offset(-size.height * 0.3, -size.width * 0.21),
  //           child: Text(
  //             _headline,
  //             style: Theme.of(context).textTheme.headline1,
  //             overflow: TextOverflow.visible,
  //             softWrap: false,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}