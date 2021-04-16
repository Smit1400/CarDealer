import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/models/per_month_model.dart';
import 'package:car_dealer/models/users.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/per_month_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lottie/lottie.dart';

class AdminAnalysis extends StatefulWidget {
  @override
  _AdminAnalysisState createState() => _AdminAnalysisState();
}

class _AdminAnalysisState extends State<AdminAnalysis> {
  FirebaseMethods _methods = FirebaseMethods();
  List<PerMonthModel> graphData = [];
  List<PerMonthModel> graphData2 = [];
  bool _loading = true;
  Map<int, String> mo = {
    1: 'Jan',
    2: 'Feb',
    3: 'Mar',
    4: 'Apr',
    5: 'May',
    6: 'Jun',
    7: 'Jul',
    8: 'Aug',
    9: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec'
  };

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      _loading = true;
    });
    try {
      List<CarDetails> cars = await _methods.getCars();
      List<User> users = await _methods.getUsers();
      print(users);
      Map<String, int> data1 = {};
      Map<String, int> data2 = {};
      for (CarDetails car in cars) {
        String month = DateTime.parse(car.carId.substring(5)).month.toString();
        if (data1.containsKey(month)) {
          setState(() {
            data1[month] = data1[month] + 1;
          });
        } else {
          setState(() {
            data1[month] = 1;
          });
        }
      }
      print(data1);
      data1.forEach((month, cars) {
        setState(() {
          graphData.add(PerMonthModel(
            month: mo[int.tryParse(month)],
            cars: cars,
            color: charts.ColorUtil.fromDartColor(Colors.teal),
          ));
        });
      });
      for (User user in users) {
        String month = DateTime.parse(user.date).month.toString();
        if (data2.containsKey(month)) {
          setState(() {
            data2[month] = data2[month] + 1;
          });
        } else {
          setState(() {
            data2[month] = 1;
          });
        }
        // print(user);
      }
      print("Hello");
      print(data2);
      data2.forEach((month, cars) {
        setState(() {
          graphData2.add(PerMonthModel(
            month: mo[int.tryParse(month)],
            cars: cars,
            color: charts.ColorUtil.fromDartColor(Constants.mainColor),
          ));
        });
      });
    } on FirebaseException catch (e) {
      print(e.message);
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF041E42),
        title: Text(
          "Analysis",
          style: GoogleFonts.oswald(),
        ),
        iconTheme: IconThemeData(color: Constants.mainColor),
      ),
      body: _loading
          ? Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Lottie.asset(
                  "assets/images/3971-graph.json",
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  PerMonthChart(
                    data: graphData,
                    id: "Cars",
                    title: "Cars Registered Per Month",
                  ),
                  SizedBox(height: 15),
                  PerMonthChart(
                    data: graphData2,
                    id: "Users",
                    title: "Users Registered Per Month",
                  )
                ],
              ),
            ),
    );
  }
}
