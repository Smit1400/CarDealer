import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class PerNMonthModel {
  final int month;
  final int cars;
  final charts.Color color;

  PerNMonthModel({
  @required this.month,
  @required this.cars,
  @required this.color,
  });
}
