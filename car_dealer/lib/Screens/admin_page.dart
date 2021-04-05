import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/admin_card.dart';
import 'package:car_dealer/widgets/custom_action_bar.dart';
import 'package:car_dealer/widgets/custom_background.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              CustomBackground(
                path: "assets/images/approval-waiting.json",
                child: Container(
                  // width: double.infinity,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding:EdgeInsets.only(top: 55),
                        ),
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
                            data = data.where((car) => car.approved == false).toList();
                            if (data.length > 0) {
                              return ListView.builder(
                                shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return data[index].approved == false
                                        ? AdminCard(
                                      car: data[index],
                                    )
                                        : Container();
                                  });
                            } else if (data.length <= 0) {
                              return Scaffold(
                                body: Center(
                                  child: Text(
                                    "No Cars",
                                    style: TextStyle(fontSize: 22, color: Colors.black),
                                  ),
                                ),
                              );
                            }
                            return LoadingPage();
                          },
                        ),
                      ],
                    ),
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
      ),
    );
  }
}
