import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class CarsPerBrand {
  final String brand;
  final int cars;
  final charts.Color color;

  CarsPerBrand({
  @required this.brand,
  @required this.cars,
  @required this.color,
  });
}
