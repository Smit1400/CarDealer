import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/admin_card.dart';
import 'package:car_dealer/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:car_dealer/widgets/loading_page.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  int check = 0;

  @override
  void initState() {
    super.initState();
  }

  // showToast(BuildContext context) {
  //   if (check == 0) {
  //     Toast.show("Click Card to view card details", context,
  //         duration: Toast.LENGTH_SHORT,
  //         gravity: Toast.CENTER,
  //         textColor: Colors.white,
  //         backgroundColor: Colors.black.withOpacity(0.7));
  //     setState(() {
  //       check = 1;
  //     });
  //   }
  // }
  // assets/images/approval-waiting.json
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
                child: Opacity(
              opacity: 0.3,
              child: Lottie.asset(
                "assets/images/approval-waiting.json",
                width: double.infinity,
              ),
            )),
            Container(
              padding: EdgeInsets.only(top: 55),
              // width: double.infinity,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: StreamBuilder<List<CarDetails>>(
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
                    data = data.where((car) => car.approved == false).toList();
                    if (data.length > 0) {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return AdminCard(
                              car: data[index],
                            );
                          });
                    } else if (data.length <= 0) {
                      return Center(
                        child: Text(
                          "No Cars",
                          style: TextStyle(fontSize: 22, color: Colors.black),
                        ),
                      );
                    }
                       return Scaffold(
                      body: Center(
                        child: Lottie.asset(
                           "assets/images/old-car-moving-animation.json",
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                    // LoadingPage(path: "assets/images/old-car-moving-animation.json");
                   
                  },
                ),
              ),
            ),
            CustomActionBar(
              title: "Car Approval",
              hasBackArrrow: true,
              hasCount: false,
              hasBackground: false,
            ),
          ],
        ),
      ),
    );
  }
}
