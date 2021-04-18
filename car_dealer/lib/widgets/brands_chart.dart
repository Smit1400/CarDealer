import 'package:car_dealer/components/constants.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:car_dealer/models/cars_per_brand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarsPerBrandChart extends StatelessWidget {
  final List<CarsPerBrand> data;
  CarsPerBrandChart({@required this.data});
 
  @override
  Widget build(BuildContext context) {
     int count = 0;
    data.forEach((brand) {
      count += brand.cars;
    });
    print(count);
    List<charts.Series<CarsPerBrand, String>> series = [
      charts.Series(
        id: "Cars",
        data: data,
        domainFn: (CarsPerBrand car, _) => car.brand,

        // colorFn: (CarsPerBrand car, _) => car.color,
        measureFn: (CarsPerBrand car, _) => car.cars,
        labelAccessorFn: (CarsPerBrand car, _) => '${car.brand}-${car.cars}\n  ${(car.cars*100~/count)}%',
      ),
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        color: Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                "Cars Per Brand",
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    color: Constants.mainColor,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: charts.PieChart(
                  series,
                  // vertical: false,
                  animate: true,
                  animationDuration: Duration(
                    seconds: 1,
                  ),
                  defaultRenderer: new charts.ArcRendererConfig(
                    arcRendererDecorators: [
                      new charts.ArcLabelDecorator(
                          //labelPadding:-25,
                          labelPosition: charts.ArcLabelPosition.inside),
                    ],
                  ),

                  //         domainAxis: new charts.OrdinalAxisSpec(
                  // renderSpec: new charts.SmallTickRendererSpec(

                  //     // Tick and Label styling here.
                  //     labelStyle: new charts.TextStyleSpec(
                  //         fontSize: 15, // size in Pts.
                  //         color: charts.ColorUtil.fromDartColor(Constants.mainColor)),

                  //     // Change the line colors to match text color.
                  //     lineStyle: new charts.LineStyleSpec(
                  //         color: charts.ColorUtil.fromDartColor(Color(0xFF041E42))))),

                  /// Assign a custom style for the measure axis.
                  // primaryMeasureAxis: new charts.NumericAxisSpec(
                  //     renderSpec: new charts.GridlineRendererSpec(

                  //         // Tick and Label styling here.
                  //         labelStyle: new charts.TextStyleSpec(
                  //             fontSize: 15, // size in Pts.
                  //             color: charts.ColorUtil.fromDartColor(Constants.mainColor)),

                  //         // Change the line colors to match text color.
                  //         lineStyle: new charts.LineStyleSpec(
                  //             color: charts.ColorUtil.fromDartColor(Color(0xFF041E42))))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
