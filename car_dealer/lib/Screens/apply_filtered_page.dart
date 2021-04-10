import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplyFilterPage extends StatefulWidget {
  final int maxPrice, minPrice, minYear, maxYear;
  final List brands;
  final String transmissionType, fuelType, ownerNo;
  ApplyFilterPage(
      {this.minPrice, this.maxPrice, this.brands, this.minYear, this.maxYear,this.transmissionType, this.fuelType,this.ownerNo});
  @override
  _ApplyFilterPageState createState() => _ApplyFilterPageState();
}

class _ApplyFilterPageState extends State<ApplyFilterPage> {
  var _order = true;
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  @override
  Widget build(BuildContext context) {
    // bool _order = false;
    // print(widget.brands[2]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF041E42),
        title: Text(
          "Filtered items",
          style: GoogleFonts.oswald(),
        ),
        iconTheme: IconThemeData(color: Constants.mainColor),
      ),
      body: Container(
        child: StreamBuilder<List<CarDetails>>(
          initialData: [],
          stream: _firebaseMethods.getAllFilteredCars(
              minPrice: widget.minPrice,
              maxPrice: widget.maxPrice,
              minYear: widget.minYear,
              maxYear: widget.maxYear,
              brands: widget.brands,
              ownerType: widget.ownerNo,
              transmissionType: widget.transmissionType,
              fuelType:widget.fuelType,),
              builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text(
                    "Error: ${snapshot.error}",
                    style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    )),
                  ),
                ),
              );
            }
            List<CarDetails> data = snapshot.data;
            print("order1" + _order.toString());
            if (data.length > 0) {
              return Container(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return (data[index].year>=widget.minYear && data[index].year<=widget.maxYear) 
                          ? CarCard(
                              car: data[index],
                            )
                          : Container();
                    }),
              );
            } else {
              return Center(
                child: Text(
                  "No Cars",
                  style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
