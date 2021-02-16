import 'package:flutter/foundation.dart';

class CarDetails {
  final String carId;
  final String userId;
  final String ownerName;
  final int mobileNumber;
  final String brand;
  final double mileage;
  final double kilometer_driven;
  final String owner_type;
  final double engine;
  final int seats;
  final double power;
  final int year;
  final double price;
  final String fuel_type;
  final String title;
  final String description;
  final String imageUrl;
  bool approved;

  CarDetails({
    @required this.brand,
    @required this.carId,
    @required this.userId,
    @required this.ownerName,
    @required this.mileage,
    @required this.kilometer_driven,
    @required this.engine,
    @required this.owner_type,
    @required this.power,
    @required this.price,
    @required this.seats,
    @required this.year,
    @required this.fuel_type,
    @required this.title,
    @required this.description,
    @required this.mobileNumber,
    @required this.imageUrl,
    this.approved = false,
  });

  factory CarDetails.fromMap(Map<String, dynamic> data) {
    return CarDetails(
      brand: data["brand"],
      engine: data["engine"],
      mileage: data["mileage"],
      kilometer_driven: data["kilometer_driven"],
      power: data["power"],
      price: data["price"],
      seats: data["seats"],
      owner_type: data["owner_type"],
      year: data["year"],
      carId: data["carId"],
      userId: data["userId"],
      ownerName: data["ownerName"],
      fuel_type: data["fuel_type"],
      description: data["description"],
      title: data["title"],
      mobileNumber: data["mobileNumber"],
      imageUrl: data["imageUrl"],
      approved: data["approved"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "brand": this.brand,
      "engine": this.engine,
      "mileage": this.mileage,
      "kilometer_driven": this.kilometer_driven,
      "power": this.power,
      "price": this.price,
      "seats": this.seats,
      "owner_type": this.owner_type,
      "year": this.year,
      "carId": this.carId,
      "userId": this.userId,
      "ownerName": this.ownerName,
      "fuel_type": this.fuel_type,
      "title": this.title,
      "description": this.description,
      "mobileNumber":  this.mobileNumber,
      "imageUrl": this.imageUrl,
      "approved": this.approved,
    };
  }
}
