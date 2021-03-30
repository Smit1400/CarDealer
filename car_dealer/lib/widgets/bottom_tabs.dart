import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  BottomTabs({this.selectedTab, this.tabPressed});

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {


  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;

    return Container(
      height: 60,
      decoration: BoxDecoration(

          color: Colors.green.withOpacity(0.9),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1.0,
              blurRadius: 30.0,
            )
          ]),
  child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(

            icon: Icons.home_outlined,
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },

          ),
          BottomTabBtn(
            icon: Icons.search_outlined,
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomTabBtn(
            icon: Icons.save_alt_outlined,
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),


        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Function onPressed;
  BottomTabBtn({this.icon, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 24.0,
        ),
        // child: Image(
        //   image: AssetImage(imagePath ?? "assets/images/home_tab.png",),
        //   width: 30.0,
        //   height: 30.0,
        //   color: _selected ? Colors.white : Colors.black,
        // ),
        child: Icon(icon,
        size: _selected ? 40 : 30,
          color: _selected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}