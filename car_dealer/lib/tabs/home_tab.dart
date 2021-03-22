import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/car_card.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          StreamBuilder<List<CarDetails>>(
            initialData: [],
            stream: _firebaseMethods.getAllCars(),
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
                        return data[index].approved == true ? CarCard(car: data[index],): Container();
                      });
                }
                else{
                  return Scaffold(
                body: Center(
                  child: Text("No Products"),
                ),
              );
                }
              

              // Loading State
              // return Scaffold(
              //   body: Center(
              //     child: CircularProgressIndicator(),
              //   ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
