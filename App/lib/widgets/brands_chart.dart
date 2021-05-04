import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/models/cars_per_brand.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

    List<PieSeries<CarsPerBrand, String>> series = [
      PieSeries(
        // id: "Cars",
        dataSource: data,
        xValueMapper: (CarsPerBrand car, _) => car.brand,
        yValueMapper: (CarsPerBrand car, _) => car.cars,
        dataLabelMapper: (CarsPerBrand car, _) =>
            '${(car.cars * 100 ~/ count)}%',
        dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.outside,
            textStyle: TextStyle(color: Colors.white, fontSize: 13),
            // color:Colors.white,
            useSeriesColor: true),


        // labelAccessorFn: (CarsPerBrand car, _) =>
        //     '${car.brand}\n ${(car.cars * 100 ~/ count)}%',
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
                "Cars Per Brand",
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    color: Constants.mainColor,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: SfCircularChart(
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    borderColor: Constants.mainColor,
                    borderWidth: 2,
                    color: Colors.black,
                  ),
                  legend: Legend(
                      isVisible: true,
                      backgroundColor: Constants.mainColor,
                      overflowMode: LegendItemOverflowMode.wrap,
                      title: LegendTitle(
                          text: 'Brands',
                          textStyle: TextStyle(
                              color: Colors.indigo,
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600))

                      // position: LegendPosition.left
                      ),
                  series: series,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
