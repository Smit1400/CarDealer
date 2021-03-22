import 'package:flutter/material.dart';


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
