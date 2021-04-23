import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class PerMonthModel {
  final String month;
  final int cars;
  final charts.Color color;

  PerMonthModel({
  @required this.month,
  @required this.cars,
  @required this.color,
  });
}
