import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:car_dealer/services/firebase_auth.dart';

class MySideBar extends StatefulWidget {
  @override
  _MySideBarState createState() => _MySideBarState();
}

class MySidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _MySideBarState extends State<MySideBar> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _username;
  List<CollapsibleItem> _items;
  Map<String, dynamic> userData;

  Future<void> user() async {
    await _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .get()
        .then((result) {
      print(result.data());
      setState(() {
        userData  = result.data();
        _username = result.data()['username'];
      });
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> _exitApp(BuildContext dialogContext) {
    return showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Do you want to exit this application?'),
            content: Text('See you again...'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(dialogContext).pop(false);
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

  // String _headline;
  NetworkImage _avatarImg =
      NetworkImage('https://www.w3schools.com/howto/img_avatar.png');
  String _select="home";
  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Extra',
        icon: Icons.home,
        isSelected: _select=="home"??true,
        onPressed: () => Navigator.pushNamed(context, '/index'),
      ),
      CollapsibleItem(
        text: 'Home',
        icon: Icons.home,
        onPressed: () => Navigator.pushNamed(context, '/index'),
      ),
      // CollapsibleItem(
      //   text: 'Search car',
      //   icon: Icons.search,
      //   onPressed: ()=> {
      //     Navigator.pushNamed(context, '/searchtab')
      //   },
      // ),
      CollapsibleItem(
        text: 'Pedict Price',
        icon: Icons.money,
        onPressed: () {
          Navigator.pushNamed(context, '/pedictprice');
          _select = "predict";
        },
      ),
      CollapsibleItem(
        text: 'Sell Car',
        icon: Icons.store,
        onPressed: () => {Navigator.pushNamed(context, '/sellcar', arguments: userData)},
      ),
      CollapsibleItem(
        text: 'Wishlist',
        icon: Icons.list,
        onPressed: () => {Navigator.pushNamed(context, '/wishlist')},
      ),
      CollapsibleItem(
        text: 'Close sidebar',
        icon: Icons.close,
        onPressed: () => Navigator.pop(context),
      ),
      CollapsibleItem(
        text: 'Log out',
        icon: Icons.logout,
        onPressed: () => _exitApp(context),
      ),
    ];
  }

  @override
  void initState() {
    // print("User ID:${_firebaseServices.getUserId()}");

    super.initState();
    _items = _generateItems;
    user();
    print("user called");
    // _headline = _items.firstWhere((item) => item.isSelected).text;
  }

  @override
  Widget build(BuildContext context) {
    return CollapsibleSidebar(
      items: _items,
      avatarImg: _avatarImg,
      title: _username ?? "username",
      body: Container(),
      backgroundColor: Colors.black,
      maxWidth: 250,
      selectedTextColor: Colors.blue,
      textStyle: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
      titleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      toggleTitleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
