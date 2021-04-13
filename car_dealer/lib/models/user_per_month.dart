import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class CarsPerMonth {
  final String month;
  final int cars;
  final charts.Color color;

  CarsPerMonth({
  @required this.month,
  @required this.cars,
  @required this.color,
  });
}
