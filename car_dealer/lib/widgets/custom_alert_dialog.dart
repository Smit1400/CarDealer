
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CustomAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.only(right: 16.0),
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(75),
              bottomLeft: Radius.circular(75),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10)
            )
          ),
          child: Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              CircleAvatar(radius: 45, backgroundColor: Colors.grey.shade200, 
              child: 
              Icon(Icons.car_rental,size: 60,)
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text("Alert!", style: Theme.of(context).textTheme.title,),
                    SizedBox(height: 10.0),
                    Flexible(
                      child: Text(
                        "Do you want to exit car dealer app?",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(height: 10.0),
                    Row(children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text("No"),
                          color: Colors.red,
                          colorBrightness: Brightness.dark,
                          onPressed: (){
                            print("you choose no");
                            Navigator.of(context).pop(false);
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: RaisedButton(
                          child: Text("Yes"),
                          color: Colors.green,
                          colorBrightness: Brightness.dark,
                          onPressed: (){
                              Navigator.of(context).pop(false);
                              signOut();
                              print("Quit");
                              // Navigator.pushNamed(context, "/");
                            },
                            
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        ),
                      ),
                    ],)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signOut() async {
    await _auth.signOut();
  }