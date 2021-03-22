import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  final String title;
  final String value;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;
  final double elevation;

  const BorderedContainer({
    this.title,
    this.value,
    this.padding,
    this.margin,
    this.color,
    this.elevation = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
     
      // margin: margin ??  const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        // width: 100,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text(title),
          Text(value,style: TextStyle( fontWeight: FontWeight.bold, ),),
          ],
        ),
      ),
    );
  }
}
