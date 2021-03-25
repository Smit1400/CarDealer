import 'package:flutter/material.dart';
import 'package:car_dealer/screens/price_predict.dart';
import 'package:car_dealer/screens/sell_car_page.dart';
import 'package:car_dealer/widgets/custom_alert_dialog.dart';
import 'package:car_dealer/Screens/admin_page.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Map<String, dynamic> user;

  MyAppBar({@required this.user});
  @override
  Size get preferredSize => const Size.fromHeight(55);
  Widget build(BuildContext context) {
    print(user["username"]);
    return AppBar(
        leading:Image.asset("assets/images/logo5.png", fit: BoxFit.contain,height: 19,),
        // leading: Icon(Icons.car_rental, size: 25),
        backgroundColor: Colors.black87.withOpacity(0.9),
        title: Text(
          "Car Buddy",
        ),
        actions: <Widget>[
          PopupMenuButton(
              // padding: EdgeInsets.all(20),
              itemBuilder: (xcontext) {
            var list = List<PopupMenuEntry<Object>>();
            list.add(
              PopupMenuItem(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(xcontext).pop(1);
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
                  Navigator.of(xcontext).pop(2);
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
            list.add(PopupMenuDivider(height: 10));
            list.add( user['admin'] == true?
              PopupMenuItem(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(xcontext).pop();
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new AdminPage(),
                  ),
                );
                },
                child: Row(
                  children: [
                    Icon(Icons.check,color: Colors.black,),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Approve selling car",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              value: 4,
            ) : null
            );
           
            list.add(PopupMenuDivider(height: 5));
            list.add(PopupMenuItem(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(xcontext).pop(3);
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
            ));
            return list;
          }, onCanceled: () {
            print("You have canceled the menu.");
          }, onSelected: (value) {
            if (value == 1) {
              print("valueprinted:$value");
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new PricePredict(),
                ),
              );
            }
            if (value == 2) {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new SellCar(
                          email: user["email"],
                          username: user["username"],
                        )),
              );
            }
            if (value == 3) {
              showDialog(
                  context: context, builder: (context) => CustomAlertDialog());
            }
            print("value:$value");
          }),
        ]);
  }
}
