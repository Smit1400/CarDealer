import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/models/user_per_month.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/cars_per_month_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AdminAnalysis extends StatefulWidget {
  @override
  _AdminAnalysisState createState() => _AdminAnalysisState();
}

class _AdminAnalysisState extends State<AdminAnalysis> {
  FirebaseMethods _methods = FirebaseMethods();
  List<CarsPerMonth> graphData = [];
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
      Map<String, int> data = {};
      for (CarDetails car in cars) {
        String month = DateTime.parse(car.carId.substring(5)).month.toString();
        if (data.containsKey(month)) {
          setState(() {
            data[month] = data[month] + 1;
          });
        } else {
          setState(() {
            data[month] = 1;
          });
        }
      }
      print(data);
      data.forEach((month, cars) {
        setState(() {
          graphData.add(CarsPerMonth(
            month: mo[int.tryParse(month)],
            cars: cars,
            color: charts.ColorUtil.fromDartColor(Colors.teal),
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
      body: Column(
        children: [
          CarsPerMonthChart(
            data: graphData,
          )
        ],
      ),
    );
  }
}
