import 'package:flutter/material.dart';
import 'package:car_dealer/components/constants.dart';

const mainColor=Color(0xFF14b58d);
const secColor=Color(0xFF109c79);
const backgroundColor=Color(0xFFdaf1de);

class SpecsBlock extends StatelessWidget {
  const SpecsBlock({
    Key key,
    this.icon,
    this.label,
    this.value,
  }) : super(key: key);

  final Widget icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Constants.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            icon,
            const SizedBox(height: 2.0),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade800,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
