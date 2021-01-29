import 'package:flutter/material.dart';
import 'package:car_dealer/widgets/custom_action_bar.dart';
class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Saved Tab"),
          ),
          CustomActionBar(
            title: "Saved",
            hasBackArrrow: false,
          ),
        ],
      ),
    );
  }
}
