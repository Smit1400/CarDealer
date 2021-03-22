import 'package:car_dealer/Screens/show_page.dart';
import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/dialog_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminCard extends StatefulWidget {
  final CarDetails car;
  AdminCard({@required this.car});

  @override
  _AdminCardState createState() => _AdminCardState();
}

class _AdminCardState extends State<AdminCard> {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<void> approveCars(CarDetails car) async {
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
              icon: Icons.check,
              description: 'Do you want approve the car for sale?',
              iconColor: Colors.green,
            );
          });
      if (confirm) {
        Map<String, dynamic> details = car.toMap();
        details['approved'] = true;
        await _firebaseMethods.updateCarDetails(CarDetails.fromMap(details));
      }
    } on FirebaseException catch (e) {
      print("[FIREBASE ERROR] ${e.message}");
    } catch (e) {
      print("[ERROR] ${e.toString()}");
    }
  }

  Future<void> deleteCar(CarDetails car) async {
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
              icon: Icons.clear,
              description: 'Do you want delet the car?',
              iconColor: Colors.red,
            );
          });
      if (confirm) {
        await _firebaseMethods.deleteCar(car.carId);
      }
    } on FirebaseException catch (e) {
      print("[FIREBASE ERROR] ${e.message}");
    } catch (e) {
      print("[ERROR] ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowPage(
                      productId: widget.car.carId,
                    )));
      },
      child: Card(
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
                      widget.car.imageUrls[0],
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
                          "${widget.car.brand}",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Rs.${widget.car.price}'),
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
                    onTap: () => deleteCar(widget.car),
                    child: Container(
                      width: width * 0.4,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          colors: [
                            Colors.red,
                            Colors.redAccent,
                          ],
                          stops: [0.0, 1.0],
                          tileMode: TileMode.repeated,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => approveCars(widget.car),
                    child: Container(
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
                          "Approve",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
