import 'package:car_dealer/widgets/navigation_model.dart';
import 'package:flutter/material.dart';


class CollapsingDrawer extends StatefulWidget {
  @override
  _CollapsingDrawerState createState() => _CollapsingDrawerState();
}

class _CollapsingDrawerState extends State<CollapsingDrawer> {
  double maxWidth=250;
  double minWidth=70;
  @override
  Widget build(BuildContext context) {
    return Container(
    width:250,
    color: Colors.black,
    child:Column(
      children: <Widget>[
        Expanded(child: 
        ListView.builder(
          itemBuilder: (context, counter) {
          return CollapsingListTile(
            title: navigationItems[counter].title,
            icon: navigationItems[counter].icon,
          );
        },
        itemCount: navigationItems.length,
        )
        ),
      ],
    ));
  }
}

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  CollapsingListTile({this.title, this.icon});
  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(widget.icon,color:Colors.white30),
        SizedBox(width:10),  
        Text(widget.title),  
      ],
    );
  }
}
