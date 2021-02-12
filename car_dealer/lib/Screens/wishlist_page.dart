import 'package:car_dealer/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:car_dealer/widgets/custom_action_bar.dart';
import 'package:car_dealer/screens/show_page.dart';
import 'package:car_dealer/widgets/sidebar.dart';



class WishlistPage extends StatefulWidget {
  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text("Car Dealer App")),
      resizeToAvoidBottomPadding: false,
      drawer: MySideBar(),
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future:  _firebaseServices.usersRef
                  .doc(_firebaseServices.getUserId())
                  .collection("Wishlist")
                  .get(),
              builder: (context, snapshot) {
                print("Wish List");
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    padding: EdgeInsets.only(top: 100, bottom: 24),
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
                        builder: (context, carSnap) {
                          if(carSnap.hasError) {
                            return Container(
                              child: Center(
                                child: Text("${carSnap.error}"),
                              ),
                            );
                          }

                          if(carSnap.connectionState == ConnectionState.done) {
                            Map _carMap = carSnap.data.data();

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 24.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      child: Image.network(
                                        "${_carMap['images'][0]}",
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
                                          "${_carMap['name']}",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets
                                              .symmetric(
                                            vertical: 4.0,
                                          ),
                                          child: Text(
                                            "\$${_carMap['price']}",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ),
                                        Text(
                                          "Size - ${document.data()['size']}",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );

                          }

                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                      );
                  }).toList(),
                );
              }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasBackArrrow: true,
            title: "Wish List",
          )
        ],
      ),
    );
  }
}