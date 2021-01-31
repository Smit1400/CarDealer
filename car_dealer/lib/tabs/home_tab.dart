import 'package:flutter/material.dart';
import 'package:car_dealer/widgets/custom_action_bar.dart';
import 'package:car_dealer/widgets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTab extends StatelessWidget {
    final CollectionReference _carRef =
      FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Stack(
              children: [
                FutureBuilder<QuerySnapshot>(
                    future: _carRef.get(),
                    builder: (context, snapshot) {
                      print("home page");
                      if (snapshot.hasError) {
                        return Scaffold(
                          body: Center(
                            child: Text("Error: ${snapshot.error}"),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView(
                          padding: EdgeInsets.only(top:100,bottom: 24),
                          children: snapshot.data.docs.map((document) {
                            return Container(
                              margin:EdgeInsets.symmetric(horizontal: 24,vertical: 12),
                              height:354,
                              child:Stack(
                                children: [ 
                                  Container(
                                    height:350,
                                    child:ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network("${document.data()['images'][0]}",
                                              fit:BoxFit.cover,)
                                        ),
                                  ), 
                                  Positioned(
                                    bottom: 0,
                                    left:0,
                                    right:0,
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child:Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(document.data()['name']??"Product Name",style:Constants.regularHeading),
                                      Text("\Rs.${document.data()['price']}"?? "Price",
                                      style:TextStyle(
                                        fontSize: 18,
                                        color:Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w600
                                      ))
                                    ],
                                  )
                                    ),
                                  ),
                                ],
                              )
                            
                              // Text("Name:${document.data()['name']}"),
                            );
                          }).toList(),
                        );
                      }
                      return Scaffold(
                          body: Center(
                        child: CircularProgressIndicator(),
                      ));
                    }),
              ],
            ),
          ),
          CustomActionBar(
            title: "Home",
            hasBackArrrow: false,
          ),
        ],
      ),
    );
  }
}
