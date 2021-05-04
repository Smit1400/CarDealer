import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class PerMonthModel {
  final int monthN;
  final String month;
  final int cars;
  final charts.Color color;

  PerMonthModel({
    this.monthN,
  @required this.month,
  @required this.cars,
  @required this.color,
  });
}