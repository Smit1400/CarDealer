import 'package:flutter/material.dart';
import 'package:car_dealer/services/firebase_auth.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/screens/show_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:lottie/lottie.dart';

class SavedTab extends StatefulWidget {
  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
          stream: _firebaseServices.usersRef
              .doc(_firebaseServices.getUserId())
              .collection("Wishlist")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text("Error: ${snapshot.error}"),
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data.docs.length > 0) {
                return ListView(
                  padding: EdgeInsets.only(
                    top: 20.0,
                    bottom: 12.0,
                    left: 12.0,
                    right: 12.0,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return WishlistCard(carId: document.id);
                  }).toList(),
                );
              } else {
                return Center(
                  child: Lottie.asset(
                    "assets/images/sad-empty-box.json",
                    width: double.infinity,
                    // height: 250,
                    fit: BoxFit.cover,
                  ),
                );
              }
            } 
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}

class WishlistCard extends StatefulWidget {
  String carId;
  WishlistCard({this.carId});
  @override
  _WishlistCardState createState() => _WishlistCardState();
}

class _WishlistCardState extends State<WishlistCard> {
  final FirebaseServices _firebaseServices = FirebaseServices();
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  final SnackBar _snackBar = SnackBar(
    content: Text("Car removed from wishlist"),
  );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseServices.carRef.doc(widget.carId).get(),
      builder: (context, productSnap) {
        if (productSnap.hasError) {
          return Container(
            child: Center(
              child: Text("${productSnap.error}"),
            ),
          );
        } else if (productSnap.hasData) {
          Map _car = productSnap.data.data();
          if (_car == null) {
            return const Center(
              child: Text(
                "Car Sold!",
                style: TextStyle(fontSize: 25.0, color: Constants.secColor),
              ),
            );
          } else {
            String capsTitle =
                "${_car['title']}".substring(0, 1).toUpperCase() +
                    "${_car['title']}".substring(1);
            return Stack(children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowPage(
                          productId: widget.carId,
                        ),
                      ));
                },
                child: Container(
                  // child:Dismissible(
                  //      key: Key(_car['carId']),
                  //       onDismissed: (direction) {
                  //         setState(() {
                  //           items.removeAt(index);
                  //         });
                  //       },
                  child: Card(
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                      20.0,
                    )),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 28.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                "${_car['imageUrls'][0]}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 16.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  //'Name of the Car : '
                                  "${_car['brand']}",
                                  style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[800],
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: Text(
                                    capsTitle,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  "\Rs. ${_car['price'].round()}",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Constants.secColor,
                                      fontWeight: FontWeight.w700),
                                ),
                                Divider(
                                  //height: 50,
                                  thickness: 10,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), // ,)
                ),
              ),
              Positioned(
                right: 10,
                top: 20,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Constants.mainColor),
                    ),
                    onPressed: () async {
                      print("${_car['carId']}");
                      _firebaseMethods
                          .deleteCarFromWishlist("${_car['carId']}");
                      Scaffold.of(context)
                          // ignore: deprecated_member_use
                          .showSnackBar(_snackBar);
                    },
                    child: Container(
                        child: Icon(
                      Icons.delete,
                      color: Constants.secColor,
                    ))),
              ),
              _car['isSold']
                  ? Positioned(
                      left: 50,
                      bottom: 30,
                      child: Text(
                        " SOLD ",
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      ),
                    )
                  : Container(),
            ]);
          }
        }
        return Container();
      },
    );
  }
}
