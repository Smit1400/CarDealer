import 'package:car_dealer/Screens/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/services/firebase_auth.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrrow;
  final bool hasTitle;
  final bool hasBackground;
  final bool hasCount;
  CustomActionBar(
      {this.title,
      this.hasBackArrrow,
      this.hasTitle,
      this.hasBackground,
      this.hasCount});
  // final CollectionReference _userRef =
  //     FirebaseFirestore.instance.collection("Users");
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;
    bool _hasCount = hasCount ?? true;
    CollectionReference userList = FirebaseFirestore.instance
        .collection('Users')
        .doc(_firebaseServices.getUserId())
        .collection("Wishlist");
    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(
                  colors: [
                    Colors.lightBlue[100],
                    Colors.white.withOpacity(0),
                  ],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                )
              : null),
      padding: EdgeInsets.only(
        top: 10.0,
        left: 24.0,
        right: 24.0,
        bottom: 42.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("assets/images/back_arrow.png"),
                  color: Colors.white,
                  width: 16.0,
                  height: 16.0,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? "Action Bar",
              style: Constants.boldHeading,
            ),
          if(_hasCount)GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WishlistPage(),
                  ));
            },
            child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: StreamBuilder<QuerySnapshot>(
                    stream: userList.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      int _itemcount = 0;
                      if (snapshot.connectionState == ConnectionState.active) {
                        List _documents = snapshot.data.docs;
                        _itemcount = _documents.length;
                        print(_itemcount);
                      }
                      return Text(
                        "$_itemcount" ?? "0",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      );
                    }
                    )
                    ),
          )
          else Container(child: Text(""),)
        ],
      ),
    );
  }
}
