// import 'dart:html';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:car_dealer/widgets/custom_action_bar.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/widgets/image_swipe.dart';
import 'package:car_dealer/services/firebase_auth.dart';

class ShowPage extends StatefulWidget {
  final String productId;
  ShowPage({this.productId});
  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  FirebaseServices _firebaseServices =FirebaseServices();

  final CollectionReference _carRef =
      FirebaseFirestore.instance.collection("Products");
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection("Users");

  // User _user = FirebaseAuth.instance.currentUser;
  void _addToList() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(now);
    _userRef
        .doc(_firebaseServices.getUserId())
        .collection("Wishlist")
        .doc(widget.productId)
        .set({"date": formatted});
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Product added to wishlist"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Container(
        //     child: Center(
        //   child: Text("Show Page"),
        // )),
        FutureBuilder(
            future: _carRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data.data();
                List imageList = documentData['images'];
                return Padding(
                    padding: EdgeInsets.all(0),
                    child: ListView(
                      children: [
                        ImageSwipe(
                          imageList: imageList,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 24, bottom: 4, left: 24, right: 24),
                          child: Text(
                              "${documentData['name']}" ?? "Product name",
                              style: Constants.boldHeading),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                          child: Text("${documentData['price']}" ?? "Price",
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                          child: Text("User Detials:",
                              style: TextStyle(fontSize: 16)),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                          child: Text("Username",
                              style: Constants.regularDarkText),
                        ),
                        Row(
                          children: [
                            // GestureDetector(
                            //     onTap: () async {
                            //       _addToList();
                            //       Scaffold.of(context).showSnackBar(_snackBar);
                            //     },
                            //     child: Container(
                            //       padding: EdgeInsets.all(15),
                            //       margin: EdgeInsets.all(20),
                            //       height: 55,
                            //       width: 55,
                            //       decoration: BoxDecoration(
                            //           color: Colors.blueGrey[100],
                            //           borderRadius: BorderRadius.circular(12)),
                            //       child: Image(
                            //           image: AssetImage(
                            //               "assets/images/saved_tab.png"),
                            //           height: 22),
                            //     )),
                            Expanded(
                           
                              // padding: EdgeInsets.only(left: 20),
                              child:GestureDetector(
                                onTap: () async {
                                  _addToList();
                                  Scaffold.of(context).showSnackBar(_snackBar);
                                },
                              child: Container(
                                  height: 65,
                                  margin: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                                  decoration: BoxDecoration(
                                      color:  Colors.blueAccent[200],
                                      borderRadius: BorderRadius.circular(12)),
                                  alignment: Alignment.center,

                                  child:Row(mainAxisAlignment: MainAxisAlignment.center,

                                    children: [
                                    Image(
                                      image: AssetImage(
                                          "assets/images/saved_tab.png"),
                                      height: 22),
                                      SizedBox(width: 20,),
                                      Text("Add to wishlist",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600))
                                  ],)
                                  ),
                            )),
                          ],
                        )
                      ],
                    ));
              }
              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            }),
        CustomActionBar(
          hasBackArrrow: true,
          hasTitle: false,
          hasBackground: false,
        )
      ],
    ));
  }
}
