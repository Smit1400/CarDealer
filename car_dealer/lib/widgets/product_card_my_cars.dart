//import 'package:car_dealer/components/constants.dart';
// import 'package:car_dealer/screens/login_page.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/screens/show_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/dialog_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCard extends StatelessWidget {
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  final String carId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final double price;
  final String productId;
  final bool isSold;
  ProductCard(
      {this.carId,
      this.onPressed,
      this.imageUrl,
      this.title,
      this.price,
      this.productId,
      this.isSold});
  static const mainColor = Color(0xFFAFEADC);
  static const secColor = Color(0xFF041E42);
  static const backgroundColor = Color(0xFFAFEADC);
  @override
  Widget build(BuildContext context) {
    Future<void> updateCar() async {
      try {
        bool confirm = await showDialog(
            context: context,
            builder: (context) {
              return DialogBox(
                title: "Confirmation",
                buttonText1: 'Yes',
                button1Func: () {
                  Navigator.of(context).pop(true);
                },
                buttonText2: 'No',
                button2Func: () {
                  Navigator.of(context).pop(false);
                },
                icon: FontAwesomeIcons.question,
                description: 'Do you agree your car is sold?',
                iconColor: Colors.red,
              );
            });
        if (confirm) {
          await _firebaseMethods.carSold(carId);
        }
      } on FirebaseException catch (e) {
        print("[FIREBASE ERROR] ${e.message}");
      } catch (e) {
        print("[ERROR] ${e.toString()}");
      }
    }

    int pr = (price).round();
    String capsTitle = title.substring(0, 1).toUpperCase() + title.substring(1);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowPage(
                productId: productId,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [mainColor, secColor])),
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Card(
                  //color: mainColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.car_rental,
                          size: 38,
                          color: Constants.secColor,
                        ),
                        title: Text(capsTitle,
                            style: TextStyle(
                                color: secColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        subtitle: Text("Rs. $pr",
                            style: TextStyle(
                                color: secColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 250.0,
                        child: ClipRRect(
                          // borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            "$imageUrl",
                            fit: BoxFit.cover,
                          ),
                        ),
                        //fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                !isSold
                    ? Positioned(
                        right: 20,
                        bottom: 30,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Constants.mainColor),
                          ),
                          onPressed: () {
                            updateCar();
                          },
                          child: Text(
                            "CAR SOLD ",
                          ),
                        ),
                      )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/*
Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Card(
              color: mainColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Image.network(
                        "$imageUrl",
                        fit: BoxFit.cover,
                      ),//Icon(Icons.directions_car_rounded),
                    title: Text("$title"),
                    subtitle: Text("$price"),
                  ),
                  /*Container(
                    alignment: Alignment.center,
                    height: 350.0,
                    child: ClipRRect(
                      // borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        "$imageUrl",
                        fit: BoxFit.cover,
                      ),
                    ),
                    //fit: BoxFit.cover,
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),*/