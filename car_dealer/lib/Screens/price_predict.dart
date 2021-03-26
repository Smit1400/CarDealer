import 'dart:convert';
import 'dart:io';

import 'package:car_dealer/services/firebase_auth.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/custom_form_field.dart';
import 'package:car_dealer/widgets/dialog_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:car_dealer/widgets/custom_button.dart';
import 'package:car_dealer/widgets/background1.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:car_dealer/widgets/custom_action_bar.dart';


class PricePredict extends StatefulWidget {
  @override
  _PricePredictState createState() => _PricePredictState();
}

class _PricePredictState extends State<PricePredict> {
  String name, mileage, imageUrl;

  File _selectedImage;
  bool _loading = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseServices _firebaseServices = FirebaseServices();
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  List<String> _brandnames = [
    ' Maruti',
    'Suzuki',
    'Hyundai',
    'Tata',
    ' Mahindra',
    ' Kia',
    'BMW',
    'Jeep',
    'Ford',
    'Honda',
    'Totyota',
    'Ambassador',
    'Audi',
    'Bajaj',
    'Ferrari'
  ];

  String _selectedbrand, _selectedfuel, _selectedtransmission, _selectedowner;
  int _year, _km, _seats;
  double _mileage, _engine, _power;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  List<String> _fueltypes = ['CNG', 'Diesel', 'Petrol', 'LPG', 'Electric'];

  List<String> _transmissionTypes = ['Manual', 'Automatic'];

  List<String> _ownwerno = ['First', 'Second', 'Fourth & Above', 'Third'];

  Map arguments = {};
  bool check() {
    if (_year != null &&
        _km != null &&
        _mileage != null &&
        _engine != null &&
        _seats != null &&
        _power != null &&
        _selectedfuel != null &&
        _selectedtransmission != null &&
        _selectedowner != null) {
      return true;
    }
    return false;
  }

  bool validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

  Future<void> _submit(BuildContext context) async {
    //
    print("IN SUBMIT FUNCTION.");
    try {
      print("IN SUBMIT FUNCTION.");
      setState(() {
        _loading = true;
      });
      if (check()) {
        print("[INFO] Predicting");
        final Uri _uri = Uri.parse('http://localhost:8000/predict');
        Map d = {
          "engine": _engine,
          "mileage": _mileage,
          "km_driven": _km,
          "power": _power,
          "seats": _seats,
          "owner_type": _selectedowner.toString(),
          "year": _year,
          "fuel_type": _selectedfuel.toString(),
          'transmission': _selectedtransmission.toString(),
        };
        var jsonData = jsonEncode(d);
        var response = await http.post(_uri, body: jsonData);
        if (response.statusCode == 200) {
          var finalData = jsonDecode(response.body);
          print(finalData);
          await showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              title: "Price Prediction",
              buttonText1: 'OK',
              button1Func: () {
                Navigator.of(context).pop();
              },
              icon: Icons.check,
              description: 'The predicted price for your car is \nRs. ${finalData['predicted_value']}',
              iconColor: Colors.green,
            );
          });

        } else {
          print(response.statusCode);
          await showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              title: "ERROR",
              buttonText1: 'OK',
              button1Func: () {
                Navigator.of(context).pop();
              },
              icon: Icons.clear,
              description: 'Some error occured!',
              iconColor: Colors.red,
            );
          });
        }
      } else {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text("Some fields are empty")));
      }
    } on FirebaseException catch (e) {
      print("[FIREBASE ERROR] ${e.message}");
      await showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              title: "ERROR",
              buttonText1: 'OK',
              button1Func: () {
                Navigator.of(context).pop();
              },
              icon: Icons.clear,
              description: '${e.message}',
              iconColor: Colors.red,
            );
          });
    } catch (e) {
      print("[ERROR N] ${e.toString()}");
      await showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              title: "ERROR",
              buttonText1: 'OK',
              button1Func: () {
                Navigator.of(context).pop();
              },
              icon: Icons.clear,
              description: '${e.toString()}',
              iconColor: Colors.red,
            );
          });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments as Map;
    print("[INFO] $arguments");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      //     appBar: AppBar(backgroundColor: Colors.black87,
      // title: Text("Predict Car Price"),
      // ),
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        // drawer: MySideBar(),
        body:
        SafeArea(child:  Stack(children: [
          Background(
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 15),
                      width: size.width,
                      child: Center(
                        child: Text("Enter Car Details",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 25),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue[100],
                              // boxShadow: [
                              //   BoxShadow(
                              //       blurRadius: 10,
                              //       color: Colors.black26,
                              //       offset: Offset(0, 2))
                              // ],
                            ),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            margin: EdgeInsets.all(10),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none),
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Cannot Be Empty")
                              ]),
                              hint: Text("Select brand"),
                              value: _selectedbrand,
                              elevation: 0,
                              isExpanded: true,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w400),
                              onChanged: (val) {
                                setState(() {
                                  _selectedbrand = val;
                                });
                              },
                              items: _brandnames.map((bname) {
                                return DropdownMenuItem(
                                  child: new Text(bname),
                                  value: bname,
                                );
                              }).toList(),
                            ),
                          ),
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _year = int.parse(val);
                            },
                            labelText: "Year",
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue[100],
                            ),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            margin: EdgeInsets.all(10),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none),
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Cannot Be Empty")
                              ]),
                              hint: Text("Select fuel"),
                              value: _selectedfuel,
                              elevation: 0,
                              isExpanded: true,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w400),
                              onChanged: (val) {
                                setState(() {
                                  _selectedfuel = val;
                                });
                              },
                              items: _fueltypes.map((fname) {
                                return DropdownMenuItem(
                                  child: new Text(fname),
                                  value: fname,
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue[100],
                            ),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            margin: EdgeInsets.all(10),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none),
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Cannot Be Empty")
                              ]),
                              hint: Text("Select Transmission"),
                              value: _selectedtransmission,
                              elevation: 0,
                              isExpanded: true,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w400),
                              onChanged: (val) {
                                setState(() {
                                  _selectedtransmission = val;
                                });
                              },
                              items: _transmissionTypes.map((fname) {
                                return DropdownMenuItem(
                                  child: new Text(fname),
                                  value: fname,
                                );
                              }).toList(),
                            ),
                          ),
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _km = int.parse(val);
                            },
                            labelText: "KM Driven",
                          ),
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _mileage = double.parse(val);
                            },
                            labelText: "Mileage in KM/KG",
                          ),
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _engine = double.parse(val);
                            },
                            labelText: "Engine in CC",
                          ),
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _power = double.parse(val);
                            },
                            labelText: "Power in bhp",
                          ),
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _seats = int.parse(val);
                            },
                            labelText: "Seats",
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue[100],
                            ),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            margin: EdgeInsets.all(10),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                  enabledBorder: InputBorder.none),
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Cannot Be Empty")
                              ]),
                              hint: Text("Owner type"),
                              value: _selectedowner,
                              elevation: 0,
                              isExpanded: true,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.w400),
                              onChanged: (val) {
                                setState(() {
                                  _selectedowner = val;
                                });
                              },
                              items: _ownwerno.map((fname) {
                                return DropdownMenuItem(
                                  child: new Text(fname),
                                  value: fname,
                                );
                              }).toList(),
                            ),
                          ),
                          SubmitBtn(
                            text: "Find Price",
                            onPressed: () => _submit(context),
                            sizeW: size.width,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
           CustomActionBar(
            title: "Predict Car Price",
            hasBackArrrow: true,
            hasCount: false,
          ),
          _loading == true
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : Container()
        ])));
  }
}
