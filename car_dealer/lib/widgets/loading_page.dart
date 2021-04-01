import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/images/old-car-moving-animation.json",
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
        ],
      )),
    );
  }
}
