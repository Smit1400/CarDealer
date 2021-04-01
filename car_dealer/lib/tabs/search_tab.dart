import 'package:flutter/material.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/services/firebase_auth.dart';
import 'package:car_dealer/widgets/custom_input.dart';
import 'package:car_dealer/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Lottie.asset(
                "assets/images/52959-search-eye.json",
                height: 200,
                // width: 200,
                fit: BoxFit.fitHeight,
              ),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.carRef.orderBy('title').startAt(
                  [_searchString]).endAt(["$_searchString\uf8ff"]).get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  print(snapshot.data);
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 128.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      String capsTitle = document.data()['title'].substring(0, 1).toUpperCase() + document.data()['title'].substring(1);
                      print(document.data());
                      return ProductCard(
                        title: capsTitle,
                        imageUrl: document.data()['imageUrls'][0],
                        price: "\Rs.${document.data()['price']}",
                        productId: document.id,
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
          Padding(
            padding: const EdgeInsets.only(
              top: 25.0,
            ),
            child: CustomInput(
              hintText: "Search here...",
              onSubmitted: (value) {
                setState(() {
                  _searchString = value.toLowerCase();
                  print("Search string: " + _searchString);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
