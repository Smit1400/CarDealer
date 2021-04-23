import 'package:flutter/material.dart';
import 'package:car_dealer/widgets/appbar.dart';
import 'package:car_dealer/screens/expansion_panel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:car_dealer/components/constants.dart';

class faq extends StatefulWidget {
  @override
  _faqState createState() => _faqState();
}

class _faqState extends State<faq> {
  var l = [
    {
      'que': "What are the important documents to sell the car ?",
      'ans':
          "Documents needed to submit are NOC , Original RC , last service receipt , service manual , Registered owner- Aadhaar card/Pan Card/Passport ."
    },
    {
      'que': "What is the process to upload the car for sale ?",
      'ans':
          "Input necessary details regarding the car and after approval from admin , it would be available for the customer to buy."
    },
    {
      'que': "What makes Car Buddy the best place to sell the car ?",
      'ans':
          "Selling the car with Car Buddy with easy  and convinent steps such as filling the basic details of the car."
    },
    {
      'que':
          "Does the app verify the image uploaded by the seller is of car or not ?",
      'ans':
          "Yes, the app validate the image uploaded by the seller is of car or not with the ML model and also provision to upload top , front , side ,etc views of the car with the description."
    },
    {
      'que': "How does the buyer contact to the seller for the car?",
      'ans':
          "The app has provided contact number of the seller and chat option avilable for enquiries."
    },
    {
      'que': "What are the filters available to search a particular car?",
      'ans':
          "Filters available to search a particular car are car brand name, price, model year ,mileage ,owner number ,type of fuel and transmission type."
    },
  ];
  static const mainColor = Color(0xFFAFEADC);
  static const secColor = Color(0xFF041E42);
  static const backgroundColor = Color(0xFFAFEADC);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF041E42),
        title: Text(
          "Car Buddy",
          style: GoogleFonts.oswald(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Text(
                      'Frequently asked Questions',
                      style: GoogleFonts.oswald(
                      textStyle:TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF041E42),
                      ),
                      )
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  for (var i = 0; i < l.length; i++)
                    Container(
                      decoration: BoxDecoration(border:Border.all(color: Colors.grey[200])),
                      padding:EdgeInsets.symmetric(vertical: 10),
                      child: (
                        ExpansionTile(
                          backgroundColor: Color(0xFFAFEADC),
                          title: Text(
                            l[i]['que'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF041E42),
                            ),
                          ),
                          children: <Widget>[
                            Center(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                                child: Text(
                                  l[i]['ans'],
                                  style: TextStyle(
                                    color: secColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        // SizedBox(
                        //   height: 18,
                        // ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
