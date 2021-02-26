import 'package:flutter/material.dart';

import 'package:car_dealer/widgets/custom_button.dart';
import 'package:car_dealer/widgets/background1.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/widgets/sidebar.dart';


class PricePredict extends StatefulWidget {
  @override
  _PricePredictState createState() => _PricePredictState();
}

class _PricePredictState extends State<PricePredict> {
  TextEditingController name, fuelType, transmission, ownerType;
  TextEditingController  _km, _seats, _years;
  TextEditingController _mileage, _power, _engine;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 // AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  
  bool validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(title: Text("Car Dealer App")),
      resizeToAvoidBottomPadding: false,
      drawer: MySideBar(),
      body: Background(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              // child: Column(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    "\nEnter details to predict Price",
                    style: Constants.mainHead,
                    textAlign: TextAlign.left,
                  ),
                ),
                Form(
                  key: _formKey,
                  //autovalidateMode: _autovalidateMode,
                  child: Column(
                    children: <Widget>[
                      Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      onChanged: (val) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name of the Car',
                      ),
                    ),
                  ),
                      Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      onChanged: (val) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mileage offered',
                      ),
                    ),
                  ),
                     Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      onChanged: (val) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Kilometer Driven',
                      ),
                    ),
                  ), 
                     Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      onChanged: (val) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Owner type',
                      ),
                    ),
                  ), 
              Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      onChanged: (val) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Engine',
                      ),
                    ),
                  ), 
                       Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      onChanged: (val) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'No of Seats',
                      ),
                    ),
                  ), 
                     Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      onChanged: (val) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Power',
                      ),
                    ),
                  ), 
                      Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      onChanged: (val) {},
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Total years',
                      ),
                    ),
                  ), 
                     
                      SubmitBtn(
                        text: "Predict Price",
                        onPressed: () {},
                        sizeW: size.width,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 26.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
