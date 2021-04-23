import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/models/per_month_model.dart';
import 'package:car_dealer/models/users.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/per_month_chart.dart';
import 'package:car_dealer/models/cars_per_brand.dart';
import 'package:car_dealer/models/users_per_month.dart';

import 'package:car_dealer/widgets/admin_no_card.dart';
import 'package:car_dealer/widgets/brands_chart.dart';
import 'package:car_dealer/widgets/appbar.dart';

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
  List<CarsPerBrand> graphData3 = [];

  int noNotSold = 0;
  int noSold = 0;
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
    getBrandData();
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
      List<CarDetails> carsSold = await _methods.getAllSoldCars();

      setState(() {
        print("Not sold cars length--------------");
        print(cars.length);
        noNotSold = cars.length;
        noSold = carsSold.length;
      });
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

  void getBrandData() async {
    setState(() {
      _loading = true;
    });
    try {
      List<CarDetails> cars = await _methods.getCars();
      Map<String, int> data = {};
      for (CarDetails car in cars) {
        String brandName = car.brand;
        // String month = DateTime.parse(car.carId.substring(5)).month.toString();
        if (data.containsKey(brandName)) {
          setState(() {
            data[brandName] = data[brandName] + 1;
          });
        } else {
          setState(() {
            data[brandName] = 1;
          });
        }
      }
      print(data);

      data.forEach((brandName, cars) {
        print(cars);
        setState(() {
          graphData3.add(CarsPerBrand(
            brand: brandName,
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
      appBar: MyAppBar(),
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
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      adminNoCard(
                        count: noNotSold,
                        title: "Total cars not sold",
                        color1: Color(0xFF3366FF),
                        color2: Color(0xFF00CCFF),
                      ),
                      adminNoCard(
                        count: noSold,
                        title: "Total cars sold",
                        color1: Color(0xFFdb5d44),
                        color2: Color(0xFFde8d64),
                      ),
                    ],
                  ),
                  PerMonthChart(
                    data: graphData,
                    id: "Cars",
                    title: "Cars Registered Per Month",
                  ),
                  UserAnalysis(),
                  // SizedBox(height: 10),
                  PerMonthChart(
                    data: graphData2,
                    id: "Users",
                    title: "Users Registered Per Month",
                  ),
                  // SizedBox(height: 10),
                   
                  //  SizedBox(height: 10),
                  CarsPerBrandChart(
                    data: graphData3,
                  )
                ],
              ),
            ),
    );
  }
}

class Person {
  String name;
  int age;
  num height;
  Person({this.name, this.age, this.height});
}

class UserAnalysis extends StatefulWidget {
  @override
  _UserAnalysisState createState() => _UserAnalysisState();
}

class _UserAnalysisState extends State<UserAnalysis> {
  FirebaseMethods _methods = FirebaseMethods();

  List<CarsPerUser> UserCarsData = [];

  bool _loading = true;

  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    setState(() {
      _loading = true;
    });
    try {
      List<CarDetails> cars = await _methods.getCars();
      Map<String, dynamic> data = {};
      Map<String, dynamic> data2 = {};

      List<int> mbno = [];
      for (CarDetails car in cars) {
        String ownerName = car.ownerName;
        // String mbNo = car.mobileNumber;
        // String month = DateTime.parse(car.carId.substring(5)).month.toString();
        if (data.containsKey(ownerName)) {
          setState(() {
            data[ownerName] = data[ownerName] + 1;
          });
        } else {
          setState(() {
            data[ownerName] = 1;
            mbno.add(car.mobileNumber);
          });
        }
      }
      print(data);
      int k = 0;
      data.forEach((ownerName, cars) {
        print(cars);

        setState(() {
          UserCarsData.add(CarsPerUser(
              ownerName: ownerName, cars: cars, mobileNumber: mbno[k]));
        });
        k += 1;
        
      });
      print("User Data------------------->");
        print(UserCarsData);
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

  bool _sortNameAsc = true;
  bool _sortAgeAsc = true;
  bool _sortHeightAsc = true;
  bool _sortAscending = true;
  bool _sortAsc = true;
  int _sortColumnIndex;
  List<Person> _persons;
  // List<CarsPerBrand> _UserCarsData;

  @override
  Widget build(BuildContext context) {
    var myColumns = [
      DataColumn(
        label: Text(
          'Owner name',
        ),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortNameAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortNameAsc;
            }
            UserCarsData.sort((a, b) => a.ownerName.compareTo(b.ownerName));
            if (!_sortAscending) {
              UserCarsData = UserCarsData.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: Text(
          'No. of cars',
        ),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortHeightAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortHeightAsc;
            }
            UserCarsData.sort((a, b) => a.cars.compareTo(b.cars));
            if (!_sortAscending) {
              UserCarsData = UserCarsData.reversed.toList();
            }
          });
        },
      ),
      DataColumn(
        label: Text(
          'Mobile Number',
        ),
        onSort: (columnIndex, sortAscending) {
          setState(() {
            if (columnIndex == _sortColumnIndex) {
              _sortAsc = _sortAgeAsc = sortAscending;
            } else {
              _sortColumnIndex = columnIndex;
              _sortAsc = _sortAgeAsc;
            }
            UserCarsData.sort(
                (a, b) => a.mobileNumber.compareTo(b.mobileNumber));
            if (!_sortAscending) {
              UserCarsData = UserCarsData.reversed.toList();
            }
          });
        },
      ),
    ];

    var myRows = UserCarsData.map((person) {
      return DataRow(cells: [
        DataCell(Text(
          person.ownerName,
        )),
        DataCell(Text('${person.cars}')),
        DataCell(Text('${person.mobileNumber}')),
      ]);
    });
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
     
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FittedBox(
          child: DataTable(
            showBottomBorder: true,
            headingRowColor:
                MaterialStateProperty.resolveWith((states) =>  Color(0xff2c4260),),
            headingTextStyle: GoogleFonts.oswald(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            columnSpacing: 25,
            dataRowColor: MaterialStateProperty.resolveWith(
                (states) => Constants.mainColor),
            dataTextStyle: TextStyle(
                fontSize: 16,
                color: Constants.secColor,
                fontWeight: FontWeight.w400),
            columns: myColumns,
            rows: myRows.toList(),
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAsc,
          ),
        ),
      ),
    );
  }
}
