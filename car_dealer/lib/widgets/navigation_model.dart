import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;
  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Home", icon: Icons.store),
  NavigationModel(title: "Search car", icon: Icons.search),
  NavigationModel(title: "Sell car", icon: Icons.car_rental),
  NavigationModel(title: "Wishlist", icon: Icons.fact_check),
  NavigationModel(title: "Predict car price", icon: Icons.money),

];
