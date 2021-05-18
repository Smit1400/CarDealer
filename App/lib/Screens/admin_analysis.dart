import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:lottie/lottie.dart';
import 'dart:collection';

import 'package:car_dealer/components/constants.dart';

import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/models/per_month_model.dart';
import 'package:car_dealer/models/per_nmonth_model.dart';
import 'package:car_dealer/models/cars_per_brand.dart';
import 'package:car_dealer/models/cars_per_user_model.dart';
import 'package:car_dealer/models/users.dart';

import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/per_month_chart.dart';
import 'package:car_dealer/widgets/per_month_linechart.dart';
import 'package:car_dealer/widgets/admin_no_card.dart';
import 'package:car_dealer/widgets/brands_chart.dart';
import 'package:car_dealer/widgets/appbar.dart';

class AdminAnalysis extends StatefulWidget {
  bool appbar;
  AdminAnalysis({this.appbar = false});
  @override
  _AdminAnalysisState createState() => _AdminAnalysisState();
}

int totalSeller = 0;

class _AdminAnalysisState extends State<AdminAnalysis> {
  List _years = [
    {
      "value": 'All',
    },
    {"value": '2019'},
    {"value": '2020'},
    {"value": '2021'},
    {"value": '2022'},
    {"value": '2023'},
  ];
  FirebaseMethods _methods = FirebaseMethods();
  List<PerMonthModel> carsRegPerMonth = [];
  List<PerMonthModel> userRegPerMonth = [];
  List<PerNMonthModel> carSoldPerMonth = [];
  List<CarsPerBrand> carsRegPerBrand = [];
  int totalUser = 0;
  String selectedYear = "All";
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
      Map<String, int> dataCarsRegPerMonth = {};
      Map<String, int> dataUserRegPerMonth = {};
      Map<String, int> dataCarSoldPerMonth = {};

      List<CarDetails> carsSold = await _methods.getAllSoldCars();

      setState(() {
        print("Not sold cars length--------------");
        print(cars.length);
        noNotSold = cars.length;
        noSold = carsSold.length;
        totalUser = users.length;
        userRegPerMonth = [];
        carsRegPerMonth = [];
        carSoldPerMonth = [];
      });
      for (CarDetails car in cars) {
        String month = DateTime.parse(car.carId.substring(5)).month.toString();
        String year = DateTime.parse(car.carId.substring(5)).year.toString();
        // print("selected year----->" + selectedYear);
        // print("year----->" + year);
        if (selectedYear == "All" || year == selectedYear) {
          if (dataCarsRegPerMonth.containsKey(month)) {
            setState(() {
              dataCarsRegPerMonth[month] = dataCarsRegPerMonth[month] + 1;
            });
          } else {
            setState(() {
              dataCarsRegPerMonth[month] = 1;
            });
          }
        }
      }
      print(dataCarsRegPerMonth);
      dataCarsRegPerMonth.forEach((month, cars) {
        setState(() {
          carsRegPerMonth.add(PerMonthModel(
            monthN: int.tryParse(month),
            month: mo[int.tryParse(month)],
            cars: cars,
            color: charts.ColorUtil.fromDartColor(Colors.teal),
          ));
        });
      });
      carsRegPerMonth.sort((a, b) => a.monthN.compareTo(b.monthN));
      for (User user in users) {
        String month = DateTime.parse(user.date).month.toString();
        String year = DateTime.parse(user.date).year.toString();
        print("selected year----->" + selectedYear);
        print("year----->" + year);
        if (selectedYear == "All" || year == selectedYear) {
          if (dataUserRegPerMonth.containsKey(month)) {
            setState(() {
              dataUserRegPerMonth[month] = dataUserRegPerMonth[month] + 1;
            });
          } else {
            setState(() {
              dataUserRegPerMonth[month] = 1;
            });
          }
        }
      }

      print(dataUserRegPerMonth);
      dataUserRegPerMonth.forEach((month, cars) {
        setState(() {
          userRegPerMonth.add(PerMonthModel(
            monthN: int.tryParse(month),
            month: mo[int.tryParse(month)],
            cars: cars,
            color: charts.ColorUtil.fromDartColor(Constants.mainColor),
          ));
        });
      });
      userRegPerMonth.sort((a, b) => a.monthN.compareTo(b.monthN));

      for (CarDetails car in cars) {
        if (car.isSold == true) {
          String month = DateTime.parse(car.dateSold).month.toString();
          String year = DateTime.parse(car.dateSold).year.toString();
          print("selected year----->" + selectedYear);
          print("year----->" + year);
          if (selectedYear == "All" || year == selectedYear) {
            if (dataCarSoldPerMonth.containsKey(month)) {
              setState(() {
                dataCarSoldPerMonth[month] = dataCarSoldPerMonth[month] + 1;
              });
            } else {
              setState(() {
                dataCarSoldPerMonth[month] = 1;
              });
            }
          }
        }
      }
      ;
      dataCarSoldPerMonth.forEach((month, cars) {
        setState(() {
          carSoldPerMonth.add(PerNMonthModel(
            month: int.tryParse(month),
            cars: cars,
            color: charts.ColorUtil.fromDartColor(Colors.teal),
          ));
        });
      });
      carSoldPerMonth.sort((a, b) => a.month.compareTo(b.month));
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
      Map<String, int> dataCarsRegPerBrand = {};

      for (CarDetails car in cars) {
        String brandName = car.brand;
        // String month = DateTime.parse(car.carId.substring(5)).month.toString();
        if (dataCarsRegPerBrand.containsKey(brandName)) {
          setState(() {
            dataCarsRegPerBrand[brandName] = dataCarsRegPerBrand[brandName] + 1;
          });
        } else {
          setState(() {
            dataCarsRegPerBrand[brandName] = 1;
          });
        }
      }
      print(dataCarsRegPerBrand);
      dataCarsRegPerBrand.forEach((brand, cars) {
        setState(() {
          carsRegPerBrand.add(CarsPerBrand(
            brand: brand,
            cars: cars,
            color: charts.ColorUtil.fromDartColor(Colors.teal),
          ));
        });
      });
      carsRegPerBrand.sort((a, b) => a.cars.compareTo(b.cars));
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
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            // appBar: MyAppBar(),
             appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  "assets/images/logo5.png",
                  fit: BoxFit.contain,
                  height: 19,
                ),
              ),
              backgroundColor: Color(0xFF041E42),
              title: Text(
                "Car Buddy",
                style: GoogleFonts.oswald(),
              ),
              iconTheme: IconThemeData(color: Constants.mainColor),
              bottom: TabBar(
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(color: Constants.mainColor, width: 3.5)),
                tabs: <Widget>[
                  Tab(
                      child: Text(
                    '   Cars  ',
                    style: GoogleFonts.lobster(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  )),
                  Tab(
                      child: Text(
                    '   Users   ',
                    style: GoogleFonts.lobster(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  )),
                ],
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: TabBarView(children: <Widget>[
              _loading
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
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(color: Colors.blue[100], blurRadius: 2)
                            ], borderRadius: BorderRadius.circular(20)),
                            child: DropDownFormField(
                              filled: false,
                              titleText: 'Year',
                              hintText: 'Please choose one',
                              value: selectedYear,
                              onSaved: (value) {
                                setState(() {
                                  selectedYear = value;
                                });
                              },
                              onChanged: (value) {
                                setState(() {
                                  selectedYear = value;
                                  getData();
                                });
                              },
                              dataSource: _years,
                              textField: 'value',
                              valueField: 'value',
                            ),
                          ),
                          // RaisedButton(
                          //   color:Constants.mainColor,
                          //     child: Text("Apply",
                          //     style: GoogleFonts.oswald(
                          //       textStyle: TextStyle(
                          //           color: Constants.secColor, fontSize: 18),
                          //     )),

                          //     onPressed: () {
                          //       getData();
                          //     }),
                          PerMonthChart(
                            data: carsRegPerMonth,
                            id: "Cars",
                            title: "Cars Registered Per Month",
                          ),
                          PerMonthLineChart(
                            data: carSoldPerMonth,
                            id: "Cars",
                            title: "Cars Sold Per Month",
                          ),
                          // SizedBox(height: 10),
                          CarsPerBrandChart(
                            data: carsRegPerBrand,
                          )
                        ],
                      ),
                    ),
              _loading
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
                                count: totalUser,
                                title: "Total no. of users",
                                color1: Color(0xFF3366FF),
                                color2: Color(0xFF00CCFF),
                              ),
                              adminNoCard(
                                count: totalSeller,
                                title: "Total no. of seller ",
                                color1: Color(0xFFdb5d44),
                                color2: Color(0xFFde8d64),
                              ),
                            ],
                          ),

                          UserAnalysis(),
                          // SizedBox(height: 10),
                          PerMonthChart(
                            data: userRegPerMonth,
                            id: "Users",
                            title: "Users Registered Per Month",
                          ),
                        ],
                      ),
                    ),
            ])));
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

  List<CarsPerUserModel> UserCarsData = [];

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

      int k = 0;
      print(data);
      data.forEach((ownerName, cars) {
        setState(() {
          UserCarsData.add(CarsPerUserModel(
              ownerName: ownerName, cars: cars, mobileNumber: mbno[k]));
        });
        setState(() {
          totalSeller = UserCarsData.length;
        });
        k += 1;
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
      height: 200,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FittedBox(
          child: DataTable(
            showBottomBorder: true,
            headingRowColor: MaterialStateProperty.resolveWith(
              (states) => Color(0xff2c4260),
            ),
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
