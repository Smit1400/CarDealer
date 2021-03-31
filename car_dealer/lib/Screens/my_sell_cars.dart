import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/car_card.dart';
import 'package:car_dealer/widgets/product_card.dart';

import 'package:car_dealer/widgets/appbar.dart';

import 'package:flutter/material.dart';


class MySellCars extends StatefulWidget {
  @override
  _MySellCarsState createState() => _MySellCarsState();
}

class _MySellCarsState extends State<MySellCars> {

  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar(),
      resizeToAvoidBottomInset: false,
      body:
     SafeArea(
      child: Stack(
        children: [
          StreamBuilder<List<CarDetails>>(
            initialData: [],
            stream: _firebaseMethods.getSellCarsUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
                List<CarDetails> data = snapshot.data;
                if (data.length > 0) {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return data[index].approved == true ? 
                        ProductCard(
                        title: data[index].title,
                        imageUrl: data[index].imageUrls[0],
                        price: "\Rs.${data[index].price}",
                        productId: data[index].carId,
                      )
                        // ProductCard(car: data[index],)
                        : Container();
                      });
                }
                else{
                  return Scaffold(
                body: Center(
                  child: Text("No Products"),
                ),
              );
                }
              

    
            },
          ),
        ],
      ),
    ));
  }
}
