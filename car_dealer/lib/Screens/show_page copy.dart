// // import 'dart:html';

// // import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:expandable/expandable.dart';

// import 'package:car_dealer/widgets/custom_action_bar.dart';
// import 'package:car_dealer/components/constants.dart';
// import 'package:car_dealer/widgets/image_swipe.dart';
// import 'package:car_dealer/widgets/bordered_container.dart';
// import 'package:car_dealer/widgets/custom_block.dart';
// import 'package:car_dealer/widgets/expand_card.dart';


// import 'package:car_dealer/services/firebase_auth.dart';

// class ShowPage extends StatefulWidget {
//   final String productId;
//   ShowPage({this.productId});
//   @override
//   _ShowPageState createState() => _ShowPageState();
// }

// class _ShowPageState extends State<ShowPage> {
//   FirebaseServices _firebaseServices = FirebaseServices();

//   final CollectionReference _carRef =
//       FirebaseFirestore.instance.collection("Cars");
//   final CollectionReference _userRef =
//       FirebaseFirestore.instance.collection("Users");

//   // User _user = FirebaseAuth.instance.currentUser;
//   void _addToList() async {
//     final DateTime now = DateTime.now();
//     final DateFormat formatter = DateFormat('dd-MM-yyyy');
//     final String formatted = formatter.format(now);
//     _userRef
//         .doc(_firebaseServices.getUserId())
//         .collection("Wishlist")
//         .doc(widget.productId)
//         .set({"date": formatted});
//   }

//   final SnackBar _snackBar = SnackBar(
//     content: Text("Product added to wishlist"),
//   );
//  bool _visibleSpec = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(),
//         body: Stack(
//       children: [
//         FutureBuilder(
//             future: _carRef.doc(widget.productId).get(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Scaffold(
//                   body: Center(
//                     child: Text("Error: ${snapshot.error}"),
//                   ),
//                 );
//               }
//               if (snapshot.connectionState == ConnectionState.done) {
//                 Map<String, dynamic> documentData = snapshot.data.data();
//                 List imageList = documentData['imageUrls'];
//                 return Container(
//                   color:Colors.grey[200],
//                     padding: EdgeInsets.all(0),
//                     child:
//                      ListView( 
                      
//                       children: [
//                         Center(
//                           child: ImageSwipe(
//                             imageList: imageList,
//                             price: "${documentData['price']}" ?? "Price",
//                           ),
//                         ),
//                         SizedBox(height:20),
//                         Center(
//                               // padding: EdgeInsets.only(
//                               //     top: 24, bottom: 4, left: 24, right: 24),
//                               child: Text(
//                                   "${documentData['title']}" ?? "Product title",
//                                   style: TextStyle(
//                                     color:Colors.black87,
//                                     fontSize: 28,
//                                     fontWeight: FontWeight.bold
//                                   )),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               top: 24, bottom: 4, left: 24, right: 24),
//                           child: Text(
//                               "Brand :${documentData['brand']}" ?? "Brand Name",
//                               style: TextStyle(
//                                 color:Colors.black54,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold
//                               )
//                               ),
//                         ),
//                         Padding(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 24, vertical: 4),
//                           child: Text("User Detials:",
//                               style: TextStyle(fontSize: 16)),
//                         ),
//                         Padding(
//                           padding:
//                               EdgeInsets.symmetric(horizontal: 24, vertical: 4),
//                           child: Text("${documentData['ownerName']}",
//                               style: Constants.regularDarkText),
//                         ),
//                         Row(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 6.0, bottom: 4.0),
//                                     child: Text(
//                                       "Key Specs",
//                                       style: Theme.of(context).textTheme.title,
//                                     ),
//                                   ),
//                                   SingleChildScrollView(
//                                     scrollDirection: Axis.horizontal,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                       children: <Widget>[
//                                         SpecsBlock(
//                                           label: "Engine", value:("${documentData['engine']}"+ " cc"),
//                                            icon: Icon(Icons.directions_car,),
//                                         ),
//                                         SpecsBlock(
//                                           label: "Mileage",
//                                           value:(" ${documentData['mileage']}"+ " kmpl"),
//                                           icon: Icon(Icons.directions_car,),
//                                         ),
//                                         SpecsBlock(
//                                           label: "Power",
//                                            value:(" ${documentData['power']}"+ " bhp"),
//                                           icon: Icon(Icons.directions_car,),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(height: 10.0),
//                                   // Card1(),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 6.0, bottom: 4.0),
//                                     child: Text(
//                                       "Desciption",
//                                       style: Theme.of(context).textTheme.title,
//                                     ),
//                                   ),
//                                   Padding(
//                                   padding:
//                                       EdgeInsets.symmetric(horizontal: 24, vertical: 4),
//                                   child: Text("${documentData['description']}",
//                                       style: TextStyle(
//                                         color:Colors.black54,
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold
//                                       )
//                                       ),
//                                 ),
//                                 const SizedBox(height: 10.0),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
//                                   child: Text(
//                                     "Free Gifts",
//                                     // style: Theme.of(context).textTheme.subhead,
//                                   ),
//                                 ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 6.0, bottom: 4.0),
//                                     child: Text(
//                                         "helmet, Gloves, Rain Coat, Bike Cover,"),
//                                   ),
//                                   const SizedBox(height: 10.0),
     
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 6.0, bottom: 4.0),
//                                     child: Text(
//                                       "Specification",
//                                       style: Theme.of(context).textTheme.title,
//                                     ),
//                                   ),
//                                  BorderedContainer(
//                                     padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                     margin: const EdgeInsets.symmetric(vertical: 4.0),
//                                     title: "Fuel Type",
//                                     value: " ${documentData['fuel_type']}",
//                                     color:Colors.white,
//                                   ),
//                                   BorderedContainer(
//                                     padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                     margin: const EdgeInsets.symmetric(vertical: 4.0),
//                                     title: "Year of Manufacture",
//                                     value: " ${documentData['year']}",
//                                     color:Colors.white,
//                                   ),
//                                    BorderedContainer(
//                                     padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                     margin: const EdgeInsets.symmetric(vertical: 4.0),
//                                     title: "No. of seats",
//                                     value: " ${documentData['seats']}",
//                                     color:Colors.white,
//                                   ),
//                                   BorderedContainer(
//                                     padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//                                     margin: const EdgeInsets.symmetric(vertical: 4.0),
//                                     title: "Transmission Type",
//                                     value: " ${documentData['transimission_type']}"??"Transmission type missing",
//                                     color:Colors.white,
//                                   ),
                               
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                                 // padding: EdgeInsets.only(left: 20),
//                                 child: GestureDetector(
//                               onTap: () async {
//                                 _addToList();
//                                 Scaffold.of(context).showSnackBar(_snackBar);
//                               },
//                               child: Container(
//                                   height: 65,
//                                   margin: EdgeInsets.symmetric(
//                                       horizontal: 30, vertical: 15),
//                                   decoration: BoxDecoration(
//                                       color: Colors.blueAccent[200],
//                                       borderRadius: BorderRadius.circular(12)),
//                                   alignment: Alignment.center,
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Image(
//                                           image: AssetImage(
//                                               "assets/images/saved_tab.png"),
//                                           height: 22),
//                                       SizedBox(
//                                         width: 20,
//                                       ),
//                                       Text("Add to wishlist",
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w600))
//                                     ],
//                                   )),
//                             )),
//                           ],
//                         )
//                       ],
//                     ));
//               }
//               return Scaffold(
//                   body: Center(
//                 child: CircularProgressIndicator(),
//               ));
//             }),
//         CustomActionBar(
//           hasBackArrrow: true,
//           hasTitle: false,
//           hasBackground: false,
//         )
//       ],
//     ));
//   }
// }
// import 'dart:html';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:car_dealer/widgets/custom_action_bar.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/widgets/image_swipe.dart';
import 'package:car_dealer/widgets/bordered_container.dart';
import 'package:car_dealer/widgets/custom_block.dart';
import 'package:car_dealer/services/firebase_auth.dart';

class ShowPage extends StatefulWidget {
  final String productId;
  ShowPage({this.productId});
  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _carRef =
      FirebaseFirestore.instance.collection("Cars");
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
//  bool _visibleSpec = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // appBar: AppBar(),
        body:SafeArea(child:
        Stack(
      children: [
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
                List imageList = documentData['imageUrls'];
                return Container(
                  color:Colors.grey[200],
                    padding: EdgeInsets.all(0),
                    child:
                     ListView( 
                         shrinkWrap: true,
                        primary: false,
                      children: [

                        Center(
                          child: ImageSwipe(
                            imageList: imageList,
                            price: "${documentData['price']}" ?? "Price",
                          ),
                        ),
                        SizedBox(height:20),
                     
                        Center(
                              // padding: EdgeInsets.only(
                              //     top: 24, bottom: 4, left: 24, right: 24),
                              child: Text(
                                  "${documentData['title']}" ?? "Product title",
                                  style: TextStyle(
                                    color:Colors.black87,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold
                                  )),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 24, bottom: 4, left: 24, right: 24),
                          child: Text(
                              "Brand :${documentData['brand']}" ?? "Brand Name",
                              style: TextStyle(
                                color:Colors.black54,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              )
                              ),
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
                          child: Text("${documentData['ownerName']}",
                              style: Constants.regularDarkText),
                        ),
                      
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6.0, bottom: 4.0),
                                    child: Text(
                                      "Key Specs",
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        SpecsBlock(
                                          label: "Engine", value:("${documentData['engine']}"+ " cc"),
                                           icon: Icon(Icons.directions_car,),
                                        ),
                                        SpecsBlock(
                                          label: "Mileage",
                                          value:(" ${documentData['mileage']}"+ " kmpl"),
                                          icon: Icon(Icons.directions_car,),
                                        ),
                                        SpecsBlock(
                                          label: "Power",
                                           value:(" ${documentData['power']}"+ " bhp"),
                                          icon: Icon(Icons.directions_car,),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  // Card1(),
                               
                                  Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                                  child: Text("${documentData['description']}",
                                      style: TextStyle(
                                        color:Colors.black54,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                      )
                                      ),
                                ),
                                const SizedBox(height: 10.0),
                                SizedBox(height:20),
                                DesclistItem(title: "Description", icon: Icons.description,context:context,vals:[" ${documentData['fuel_type']}"]),
                                ListTile(
                                leading: Icon(
                                  Icons.open_in_new_rounded,
                                  size: 40,
                                ),
                                title: Text(
                                  "Share",
                                  style: TextStyle(fontSize: 17),
                                )),
                                Padding(
                                  padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
                                  child: Text(
                                    "Free Gifts",
                                  ),
                                ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6.0, bottom: 4.0),
                                    child: Text(
                                        "helmet, Gloves, Rain Coat, Bike Cover,"),
                                  ),
                                  const SizedBox(height: 10.0),
     
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6.0, bottom: 4.0),
                                    child: Text(
                                      "Specification",
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                  ),
                                 BorderedContainer(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                                    title: "Fuel Type",
                                    value: " ${documentData['fuel_type']}",
                                    color:Colors.white,
                                  ),
                                  BorderedContainer(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                                    title: "Year of Manufacture",
                                    value: " ${documentData['year']}",
                                    color:Colors.white,
                                  ),
                                   BorderedContainer(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                                    title: "No. of seats",
                                    value: " ${documentData['seats']}",
                                    color:Colors.white,
                                  ),
                                  BorderedContainer(
                                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                                    title: "Transmission Type",
                                    value: " ${documentData['transimission_type']}"??"Transmission type missing",
                                    color:Colors.white,
                                  ),
                               
                                ],
                              ),
                            ),
                            Expanded(
                                // padding: EdgeInsets.only(left: 20),
                                child: GestureDetector(
                              onTap: () async {
                                _addToList();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                  height: 65,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent[200],
                                      borderRadius: BorderRadius.circular(12)),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                          image: AssetImage(
                                              "assets/images/saved_tab.png"),
                                          height: 22),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Text("Add to wishlist",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600))
                                    ],
                                  )),
                            )),
                       
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
    )));
  }
}
Widget DesclistItem({int index, String title, IconData icon,BuildContext context,List vals}) {
  return Material(
    color: Colors.transparent,
    child: Theme(
      data: ThemeData(accentColor: Colors.black),
      child: ExpansionTile(
        leading: Icon(
          icon,
          size: 40,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 17),
        ),
        children: <Widget>[
        BorderedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            title: "Transmission Type",
            value: vals[0],
            color:Colors.white,
          ),
           ],
      ),
    ),
  );
}
Widget listItem({int index, String title, IconData icon,BuildContext context}) {
  return Material(
    color: Colors.transparent,
    child: Theme(
      data: ThemeData(accentColor: Colors.black),
      child: ExpansionTile(
        leading: Icon(
          icon,
          size: 40,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 17),
        ),
        children: <Widget>[for (int i = 0; i < 5; i++) cardWidget(context)],
      ),
    ),
  );
}
Widget cardWidget(context) {
  return Padding(
    padding: const EdgeInsets.only(top: 5.0, bottom: 8),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.91,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(1, 3), color: Colors.grey[300], blurRadius: 5),
            BoxShadow(
                offset: Offset(-1, -3),
                color: Colors.grey[300],
                blurRadius: 5)
          ]),
      child: Row(
        children: [
          Icon(
            Icons.image_rounded,
            size: 22,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Title of Card",
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    ),
  );
}