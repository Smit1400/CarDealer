import 'package:flutter/material.dart';
// import 'package:car_dealer/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_dealer/screens/price_predict.dart';
import 'package:car_dealer/screens/sell_car_page.dart';

class MyMenu extends StatelessWidget {
  final String text, img;
  final Function onPressed;
  final IconData iconx;
  MyMenu({this.text, this.onPressed, this.img, this.iconx});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onTap:onPressed,
        child: Row(
      children: <Widget>[
        Image.asset(img, width: 40, height: 40),
        Text(text),
      ],
    ));
  }
}

// class Popup extends StatelessWidget {
//   @override
//   Widget build(BuildContext xcontext) {
//     return  PopupMenuButton(
//       padding: EdgeInsets.all(20),
//       itemBuilder: (xcontext) {
//         var list = List<PopupMenuEntry<Object>>();
//         // list.add
//         list.add(
//           PopupMenuItem(
//             child: Row(
//               children: [
//                 Image.asset("assets/images/sell_car2.png",
//                     width: 20, height: 20),
//                 Text(
//                   "Predict Car Price",
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ],
//             ),
//             value: 1,
//           ),
//         );
//         list.add(
//           PopupMenuItem(
//             child: Row(
//               children: [
//                 Icon(Icons.logout,color:Colors.black),
//                 Text(
//                   "LogOut",
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ],
//             ),
//             value: 2,
//           ),
//         );
//         return list;
//       },
//       initialValue: 2,
//       onCanceled: () {
//         print("You have canceled the menu.");
//       },
//       onSelected: (value) {
//         print("value:$value");
//       },
//     );
//   }
// }

// MyMenu(img: "assets/images/rupee3.png",text:"Sell Car",onPressed:_exitApp ,)

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  
  Size get preferredSize => const Size.fromHeight(55);

  Widget build(BuildContext context) {
    return AppBar(
        // leading:Image.asset("assets/images/appicon.png", fit: BoxFit.contain,width:15,height: 15,),
        leading: Icon(Icons.car_rental, size: 25),
        backgroundColor: Colors.black87,
        title: Text(
          "Car Dealer App",
        ),
        actions: <Widget>[
          PopupMenuButton(
            // padding: EdgeInsets.all(20),
            itemBuilder: (xcontext) {
              var list = List<PopupMenuEntry<Object>>();
              // list.add
              list.add(
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(xcontext).pop(false);
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new PricePredict(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Image.asset("assets/images/sell_car2.png",
                            width: 25, height: 25, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Predict Car Price",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  value: 1,
                ),
              );
              list.add(PopupMenuDivider(height: 5));
              list.add(PopupMenuItem(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(xcontext).pop(false);
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new PricePredict(),
                        ),
                      );
                    },
                  child: Row(
                    children: [
                      Image.asset("assets/images/rupee3.png",
                          width: 25, height: 25, color: Colors.black),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Sell Your Car",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
               
                ),
                   value: 2,
              ));
              list.add(PopupMenuDivider(height: 5));
              list.add(
                PopupMenuItem(
                  child:GestureDetector(
                    onTap:(){
                      _exitApp(context);
                        // Navigator.of(xcontext).pop(false);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.black),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "LogOut",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
             
                ),
                     value: 3,
                )
              );
              return list;
            },
            // initialValue: 2,
            onCanceled: () {
              print("You have canceled the menu.");
            },
            onSelected: (value) {
              print("value:$value");
            },
          )
        ]);
  }


  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          child: AlertDialog(
            title: Text('Do you want to exit this application?'),
            content: Text('See you again...'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                  // Navigator.of(xcontext).pop(false);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  signOut();
                  print("Quit");
                  Navigator.pushNamed(context, "/");
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
