import 'package:car_dealer/components/constants.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:car_dealer/models/per_nmonth_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerMonthLineChart extends StatelessWidget {
  final List<PerNMonthModel> data;
  final String id;
  final String title;
  PerMonthLineChart({@required this.data, @required this.id, @required this.title});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<PerNMonthModel, num>> series = [
      charts.Series(
        id: id,
        data: data,
        domainFn: (PerNMonthModel car, _) => car.month,
          fillColorFn: (_, __) {
          return charts.ColorUtil.fromDartColor(Constants.mainColor);
        },
        seriesColor: charts.ColorUtil.fromDartColor(Constants.mainColor),

        colorFn: (PerNMonthModel car, _) => charts.MaterialPalette.blue.shadeDefault,
        measureFn: (PerNMonthModel car, _) => car.cars,
        labelAccessorFn: (PerNMonthModel car, _) => '${car.cars}',


      ),
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        // color: Color(0xff2c4260),
        color: Colors.white,

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                title,
                style: GoogleFonts.oswald(
                  textStyle: TextStyle(
                    color:  Color(0xff2c4260),
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: charts.LineChart(
                  
                  series,
     
                  animate: true,
                  animationDuration: Duration(
                    seconds: 1,
                  ),
                  defaultRenderer:
                charts.LineRendererConfig(
                // Dot size
                radiusPx: 5.0,
                stacked: false,
                // line width
                strokeWidthPx: 2.0,
                // Whether to display the line
                includeLine: true,
                // Whether to display dots
                includePoints: true,
                // Whether to display the included area
                includeArea: true,
                // Area color transparency 0.0-1.0
                areaOpacity: 0.2 ,
                )
                  
               
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
String text;

