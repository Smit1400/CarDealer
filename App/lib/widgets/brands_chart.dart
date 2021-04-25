import 'package:car_dealer/components/constants.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:car_dealer/models/cars_per_brand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:charts_common/src/common/color.dart' as c;

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
    double size = 0;
  
    List<charts.Series<CarsPerBrand, String>> series = [
      charts.Series(
        id: "Cars",
        data: data,
        domainFn: (CarsPerBrand car, _) => car.brand,

        // colorFn: (CarsPerBrand car, _) => car.color,
        measureFn: (CarsPerBrand car, _) => car.cars,
        labelAccessorFn: (CarsPerBrand car, _) =>
            '${car.brand}\n ${(car.cars * 100 ~/ count)}%',
      ),
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(10),
      child: Card(
        color: Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Text(
                "Top 5 Brands",
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
                          insideLabelStyleSpec: charts.TextStyleSpec(
                              fontSize: 10,
                              color: c.Color.fromHex(code: "#311d52")),
                          outsideLabelStyleSpec: charts.TextStyleSpec(
                              fontSize: 10,
                              color: c.Color.fromHex(code: "#311d52")),
                          leaderLineColor:
                              charts.ColorUtil.fromDartColor(Colors.red),
                          //labelPadding:-25,
                          labelPosition: charts.ArcLabelPosition.inside),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
