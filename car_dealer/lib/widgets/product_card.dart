//import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/screens/login_page.dart';
import 'package:car_dealer/screens/show_page.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  final String productId;
  ProductCard(
      {this.onPressed, this.imageUrl, this.title, this.price, this.productId});
  static const mainColor=Color(0xFFAFEADC);
  static const secColor=Color(0xFF041E42);
  static const backgroundColor=Color(0xFFAFEADC);
  @override
  Widget build(BuildContext context) {
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
      colors: [mainColor,secColor])
  ),
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Card(
              //color: mainColor,
            
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading:Icon(Icons.search),
                    title: Text("$title",style: TextStyle(color:secColor,fontSize: 20,
    fontWeight: FontWeight.bold)),
                    subtitle: Text("$price",style: TextStyle(color:secColor,fontSize: 16,
    fontWeight: FontWeight.bold)),
                  ),
                  Container(
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
                  ),
                ],
              ),
            ),
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