import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  final String path;

  const CustomBackground({
    Key key,
    @required this.child,
    @required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
              child: Opacity(
                opacity: 0.3,
                child: Lottie.asset(
                  path,
                  width: double.infinity,
                ),
              )
          ),
          child
        ],
      ),
    );
  }
}
