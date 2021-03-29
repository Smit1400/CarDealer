import 'package:flutter/material.dart';
import 'package:car_dealer/widgets/custom_action_bar.dart';
import 'package:car_dealer/services/firebase_auth.dart';
import 'package:car_dealer/screens/show_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedTab extends StatelessWidget {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.usersRef
                .doc(_firebaseServices.getUserId())
                .collection("Wishlist")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(
                  padding: EdgeInsets.only(
                    top: 80.0,
                    bottom: 12.0,
                    left: 12.0,
                    right: 12.0,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowPage(
                                productId: document.id,
                              ),
                            ));
                      },
                      child: FutureBuilder(
                        future: _firebaseServices.carRef.doc(document.id).get(),
                        builder: (context, productSnap) {
                          if (productSnap.hasError) {
                            return Container(
                              child: Center(
                                child: Text("${productSnap.error}"),
                              ),
                            );
                          }
                          if (productSnap == null) {
                            return const Center(
                              child: Text(
                                "Not Available",
                                style: TextStyle(
                                    fontSize: 30.0, color: Colors.grey),
                              ),
                            );
                          } else if (productSnap.connectionState ==
                              ConnectionState.done) {
                            Map _productMap = productSnap.data.data();
                            print(_productMap);
                            if (_productMap == null) {
                              return const Center(
                              child: Text(
                                "Car Sold!",
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.grey),
                              ),
                            );
                            } else {
                              return Container(
                                child: Card(
                                  elevation: 0.5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                    20.0,
                                  )),
                                  child: Container(
                                    decoration: BoxDecoration(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 90,
                                          height: 90,
                                          //color:Colors.blueGrey,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              "${_productMap['imageUrls'][0]}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: 16.0,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                //'Name of the Car : '
                                                "${_productMap['brand']}",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.blueGrey[800],
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 4.0,
                                                ),
                                                child: Text(
                                                  //'Price : '
                                                  "${_productMap['title']}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.grey[600],
                                                      /*Theme.of(context)
                                                    .accentColor,*/
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                              Text(
                                                //'No of Seats : '
                                                "\Rs. ${_productMap['price']}", //document.data()['seats']
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.grey[800],
                                                    fontWeight:
                                                        FontWeight.w400),
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
                                ),
                              );
                            }
                          }
                          return Container(
                              // child: Center(
                              //   child: CircularProgressIndicator(),
                              // ),
                              );
                        },
                      ),
                    );
                  }).toList(),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "Wishlist",
            hasBackArrrow: false,
          )
        ],
      ),
    );
  }
}
