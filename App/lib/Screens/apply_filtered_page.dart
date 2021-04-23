import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:car_dealer/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ApplyFilterPage extends StatefulWidget {
  final int maxPrice, minPrice, minYear, maxYear;
  final List brands;
  final double maxMileage, minMileage;
  final String transmissionType, fuelType, ownerNo;
  ApplyFilterPage(
      {this.minPrice,
      this.maxPrice,
      this.brands,
      this.minYear,
      this.maxYear,
      this.minMileage,
      this.maxMileage,
      this.transmissionType,
      this.fuelType,
      this.ownerNo});
  @override
  _ApplyFilterPageState createState() => _ApplyFilterPageState();
}
class _ApplyFilterPageState extends State<ApplyFilterPage> {

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
          
           
            brands: widget.brands,
            ownerType: widget.ownerNo,
            transmissionType: widget.transmissionType,
            fuelType: widget.fuelType,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return  Center(
                child: Text(
                "Error: ${snapshot.error}",
                    style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ))));
            }
            List<CarDetails> data = snapshot.data;
            List<CarDetails> filterData = [];
            for (int i = 0; i < data.length; i++) {
              if (data[i].year >= widget.minYear &&
                  data[i].year <= widget.maxYear && data[i].mileage <= widget.maxMileage &&data[i].mileage >= widget.minMileage){
                filterData.add(data[i]);
              }
            }
            if (filterData.length > 0) {
              return Container(
                child: ListView.builder(
                    itemCount: filterData.length,
                    itemBuilder: (context, index) {
                      return CarCard(
                        car: filterData[index],
                      );
                    }),
              );
            } else {
              return Center(
                  child: Lottie.asset(
                  "assets/images/empty-category.json",
                 
                  width: double.infinity,
                  // height: 250,
                  fit: BoxFit.cover,
              ),
              );
            }
          },
        ),
      ),
    );
  }
}
