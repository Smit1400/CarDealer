import 'package:flutter/material.dart';
import 'package:car_dealer/widgets/custom_action_bar.dart';

class SearchTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("Search tab"),
          ),
          CustomActionBar(
            title: "Search",
            hasBackArrrow: false,
          ),
        ],
      ),
    );
  }
}
