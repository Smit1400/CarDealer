import 'package:flutter/material.dart';
class Expansionpanel extends StatefulWidget {
  Expansionpaneltate createState() =>  Expansionpaneltate();
}
class NewItem {
  bool isExpanded;
  final String header;
  final Widget body;
  NewItem(this.isExpanded, this.header, this.body);
}
class Expansionpaneltate extends State<Expansionpanel> {
  List<NewItem> items = <NewItem>[
    NewItem(
      false, // isExpanded ?
      'Header', // header
      Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text('Documents needed are adhaar card and address proof .'),
            
            Radio(value: null, groupValue: null, onChanged: null)
          ]
        )
      ), // body
     // Icon(Icons.image) // iconPic
    ),
  ];
ListView List_Criteria;
Widget build(BuildContext context) {
    List_Criteria = ListView(
      children: [
         Padding(
          padding: EdgeInsets.all(10.0),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                items[index].isExpanded = !items[index].isExpanded;
              });
            },
            children: items.map((NewItem item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return  ListTile(
                    // leading: item.iconpic,
                    title:  Text(
                      item.header,
                      textAlign: TextAlign.left,
                      style:  TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  );
                },
                isExpanded: item.isExpanded,
                body: item.body,
              );
            }).toList(),
          ),
        ),
      ],
    );
    Scaffold scaffold =  Scaffold(
      appBar:  AppBar(
        title:  Text("ExpansionPanelList"),
      ),
      body: List_Criteria,
    );
    return scaffold;
  }
}