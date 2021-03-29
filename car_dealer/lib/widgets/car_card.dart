import 'package:car_dealer/Screens/show_page.dart';
import 'package:car_dealer/models/car_details.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/components/constants.dart';

const Color mainColor=Color(0xFF436eee);

class CarCard extends StatelessWidget {
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  final CarDetails car;
  final SnackBar _snackBar = SnackBar(
    content: Text("Car added to wishlist"),
  );
  CarCard({@required this.car});
 
  
  @override
  Widget build(BuildContext context) {
     String capsTitle = "${car.title}".substring(0, 1).toUpperCase() +"${car.title}".substring(1);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    int pr=(car.price).round();
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.all(10),
          child: Container(
            width: width,
            padding: EdgeInsets.all(10),
            // height: height * 0.3,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: height * 0.2 * 0.7,
                      width: width * 0.5,
                      child: Image.network(
                        car.imageUrls[0],
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${car.brand}",
                            style: TextStyle(
                              
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            capsTitle,
                            style: TextStyle(
                               
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                         
                          Text('Rs.$pr',
                          style: TextStyle(
                                color: mainColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),),
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowPage(
                                      productId: car.carId,
                                    )));
                      },
                      child: Container(
                        width: width * 0.4,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          gradient: LinearGradient(
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight,
                            colors: [
                              Constants.mainColor,
                            Constants.secColor
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
                    ),
                    Container(
                      width: width * 0.4,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: mainColor,
                        gradient: LinearGradient(
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          colors: [
                            Constants.mainColor,
                            Constants.secColor
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
        ),
        Positioned(
          right: 0,
          top: 0,
          child: GestureDetector(
            onTap: () async {
              _firebaseMethods.addCarToWishlist(car.carId);
              // _addToList();
              Scaffold.of(context).showSnackBar(_snackBar);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, right: 20.0),
              child: Image.asset(
                "assets/images/saved_tab.png",
                scale: 1.6,
              ),
            ),
          ),
        )
      ],
    );
  }
}
