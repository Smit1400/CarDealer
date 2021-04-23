import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavigationModel {
  String title;
  IconData icon;
  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Home", icon: Icons.store),
  NavigationModel(title: "Search car", icon: Icons.search),
  NavigationModel(title: "Sell car", icon: MdiIcons.car),
  NavigationModel(title: "Wishlist", icon: Icons.check_box),
  NavigationModel(title: "Predict car price", icon: Icons.attach_money),
];
