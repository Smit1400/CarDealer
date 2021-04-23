import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:car_dealer/screens/apply_filtered_page.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class Filters extends StatefulWidget {
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  DateFormat formatter = DateFormat('yyyy');
  String formatted;
  Color active = Constants.secColor.withOpacity(0.8);
  Color inactive = Constants.secColor.withOpacity(0.3);
  // RangeValues _valuesPrice = RangeValues(0, 100);
  double minPrice = 10000;
  double maxPrice = 5000000;
  int _selectedMinPrice = 10000;
  int _selectedMaxPrice = 5000000;
  int _selectedMinYear = 2001;
  int _selectedMaxYear = 2022;
  SfRangeValues _valuesPrice = SfRangeValues(10000.0, 5000000.0);

  DateTime minYear = DateTime(2001, 01, 01);
  DateTime maxYear = DateTime(2022, 01, 01);
  SfRangeValues _valuesYear =SfRangeValues(DateTime(2001, 01, 01), DateTime(2022, 01, 01));

  double minMileage = 10.0;
  double maxMileage = 50.0;
  double _selectedMinMileage = 10.0;
  double _selectedMaxMileage = 50.0;
  SfRangeValues _valuesMileage = SfRangeValues(10.0, 50.0);
  String _selectedTransmissionType = '';
  String _selectedFuelType = '';
  String _selectedOwnerNo = '';

  List _selectedBrands = [];
  List _transmissionType = [
    {
      "value": 'Manual',
    },
    {"value": 'Automatic'},
  ];
  List _fuelType = [
    {
      "value": 'CNG',
    },
    {
      "value": 'Diesel',
    },
    {
      "value": 'Petrol',
    },
    {
      "value": 'LPG',
    },
    {
      "value": 'Electric',
    },
  ];

  List _ownerno = [
     {
      "value": 'First',
    },{
      "value": 'Second',
    },{
      "value": 'Third',
    },{
      "value": 'Fourth & Above'
    }
  ];

  List _brands = [
    {"display": ' Maruti', "value": ' Maruti'},
    {
      "display": 'Suzuki',
      "value": 'Suzuki',
    },
    {"display": 'Hyundai', "value": 'Hyundai'},
    {"display": 'Tata', "value": 'Tata'},
    {
      "display": ' Mahindra',
      "value": ' Mahindra',
    },
    {
      "display": 'Kia',
      "value": ' Kia',
    },
    {
      "display": 'BMW',
      "value": 'BMW',
    },
    {
      "display": 'Jeep',
      "value": 'Jeep',
    },
    {
      "display": 'Ford',
      "value": 'Ford',
    },
    {
      "display": 'Honda',
      "value": 'Honda',
    },
    {
      "display": 'Totyota',
      "value": 'Totyota',
    },
    {
      "display": 'Ambassador',
      "value": 'Ambassador',
    },
    {
      "display": 'Audi',
      "value": 'Audi',
    },
    {
      "display": 'Bajaj',
      "value": 'Bajaj',
    },
    {"display": 'Ferrari', "value": 'Ferrari'}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF041E42),
          title: Text(
            "Car Buddy",
            style: GoogleFonts.oswald(),
          ),
          iconTheme: IconThemeData(color: Constants.mainColor),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(

              children: [
                SizedBox(height:25),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.blue[100], blurRadius: 2)
                  ], borderRadius: BorderRadius.circular(20)),
                  child: MultiSelectFormField(
                    autovalidate: false,
                    chipBackGroundColor: Constants.mainColor,
                    chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                    dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    checkBoxActiveColor: Constants.mainColor,
                    checkBoxCheckColor: Constants.secColor,
                    dialogShapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                    title: Text("Car Brands",
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Constants.secColor),
                        )),
                    dataSource: _brands,
                    textField: 'display',
                    valueField: 'value',
                    okButtonLabel: 'OK',
                    cancelButtonLabel: 'CANCEL',
                    hintWidget: Text('Please choose one or more'),
                    initialValue: _selectedBrands,
                    onSaved: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedBrands = value;
                        print(_selectedBrands);
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.blue[100], blurRadius: 2)
                  ], borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Price",
                          style: GoogleFonts.oswald(
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Constants.secColor),
                          )),
                      SfRangeSlider(
                        activeColor: Colors.lightBlueAccent,
                        inactiveColor: Colors.lightBlueAccent[100],
                        min: minPrice,
                        max: maxPrice,
                        values: _valuesPrice,
                        // interval: ,
                        showTicks: true,
                        showLabels: true,
                        enableTooltip: true,

                        numberFormat: NumberFormat("\Rs"),
                        onChanged: (SfRangeValues values) {
                          setState(() {
                            _valuesPrice = values;

                            _selectedMinPrice = values.start.toInt();
                            _selectedMaxPrice = values.end.toInt();
                            print(_selectedMinPrice.toString() +
                                " - " +
                                _selectedMaxPrice.toString());
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(color: Colors.blue[100], blurRadius: 2)
                    ], borderRadius: BorderRadius.circular(20)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Model Year",
                              style: GoogleFonts.oswald(
                                textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Constants.secColor),
                              )),
                          SfRangeSlider(
                            min: minYear,
                            max: maxYear,
                            values: _valuesYear,
                            interval: 4,
                            //  showTicks: true,

                            enableTooltip: true,
                            showLabels: true,
                            dateIntervalType: DateIntervalType.years,
                            dateFormat: DateFormat.y(),
                            onChanged: (SfRangeValues value) {
                              setState(() {
                                _valuesYear = value;
                                formatted = formatter.format(value.start);
                                _selectedMinYear = int.parse(formatted);
                                formatted = formatter.format(value.end);
                                _selectedMaxYear = int.parse(formatted);
                                print(_selectedMinYear.toString() +
                                    " - " +
                                    _selectedMaxYear.toString());
                              });
                            },
                          ),
                        ])),
                         SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.blue[100], blurRadius: 2)
                  ], borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Mileage(in kmpl)",
                          style: GoogleFonts.oswald(
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Constants.secColor),
                          )),
                      SfRangeSlider(
                        activeColor: active,
                        inactiveColor: Colors.blueAccent[100],
                        min: minMileage,
                        max: maxMileage,
                        values: _valuesMileage,
                        // interval: ,
                        showTicks: true,
                        showLabels: true,
                        enableTooltip: true,

                        // numberFormat: NumberFormat("kmpl","end"),
                        onChanged: (SfRangeValues values) {
                          setState(() {
                            _valuesMileage = values;

                            _selectedMinMileage = values.start;
                            _selectedMaxMileage = values.end;
                            print(_selectedMinMileage.toString() +
                                " - " +
                                _selectedMaxMileage.toString());
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.blue[100], blurRadius: 2)
                  ], borderRadius: BorderRadius.circular(20)),
                  child: DropDownFormField(
                    filled: false,
                    titleText: 'Owner Number',
                    hintText: 'Please choose one',
                    value: _selectedOwnerNo,
                    onSaved: (value) {
                      setState(() {
                         _selectedOwnerNo = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                       _selectedOwnerNo = value;
                      });
                    },
                    dataSource: _ownerno,
                    textField: 'value',
                    valueField: 'value',
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.blue[100], blurRadius: 2)
                  ], borderRadius: BorderRadius.circular(20)),
                  child: DropDownFormField(
                    filled: false,
                    titleText: 'Fuel Type',
                    hintText: 'Please choose one',
                    value: _selectedFuelType,
                    onSaved: (value) {
                      setState(() {
                         _selectedFuelType = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                      _selectedFuelType = value;
                      });
                    },
                    dataSource: _fuelType,
                    textField: 'value',
                    valueField: 'value',
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(color: Colors.blue[100], blurRadius: 2)
                  ], borderRadius: BorderRadius.circular(20)),
                  child: DropDownFormField(
                    filled: false,
                    titleText: 'Transmission Type',
                    hintText: 'Please choose one',
                    value: _selectedTransmissionType,
                    onSaved: (value) {
                      setState(() {
                        _selectedTransmissionType = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _selectedTransmissionType = value;
                      });
                    },
                    dataSource: _transmissionType,
                    textField: 'value',
                    valueField: 'value',
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Constants.mainColor),
                    ),
                    onPressed: () async {
                      // _selectedBrandsString = _selectedBrands.toString();
                      // print(_selectedBrandsString);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApplyFilterPage(
                                  minPrice: _selectedMinPrice,
                                  maxPrice: _selectedMaxPrice,
                                  minMileage: _selectedMinMileage,
                                  maxMileage: _selectedMaxMileage,
                                  minYear: _selectedMinYear,
                                  maxYear: _selectedMaxYear,
                                  brands: _selectedBrands,
                                  transmissionType: _selectedTransmissionType,
                                  fuelType: _selectedFuelType,
                                  ownerNo: _selectedOwnerNo,
                                )),
                      );
                    },
                    child: Container(
                        child: Text("Apply filters",
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                  color: Constants.secColor),
                            )))),
              ],
            ),
          ),
        ));
  }
}
