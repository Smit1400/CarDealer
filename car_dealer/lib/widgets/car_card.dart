import 'package:car_dealer/models/car_details.dart';
import 'package:flutter/material.dart';

class CarCard extends StatelessWidget {
  final CarDetails car;
  CarCard({@required this.car});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        width: width,
        padding: EdgeInsets.all(10),
        // height: height * 0.3,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: height * 0.2 * 0.7,
                  width: width * 0.5,
                  child: Image.network(
                    car.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${car.brand}",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Rs.${car.price}'),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.,
              children: [
                Container(
                  width: width * 0.4,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors: [
                        Colors.orange,
                        Colors.orangeAccent,
                      ],
                      stops: [0.0, 1.0],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "View",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  width: width * 0.4,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      colors: [
                        Colors.green,
                        Colors.greenAccent,
                      ],
                      stops: [0.0, 1.0],
                      tileMode: TileMode.repeated,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Chat",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
