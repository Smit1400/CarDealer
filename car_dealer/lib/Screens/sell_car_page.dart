import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io';

// import 'package:car_dealer/screens/index_page.dart';
import 'package:car_dealer/widgets/custom_button.dart';
// import 'package:car_dealer/widgets/custom_input.dart';
import 'package:car_dealer/widgets/background1.dart';
// import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/widgets/sidebar.dart';
import 'package:car_dealer/widgets/custom_action_bar.dart';

// class DropDown extends StatefulWidget {
//  List<String> _items;
//  String _selected;
//   DropDown(List<String> items,String selected){
//     this._items=items;
//     this._selected=selected;
//   }
//   @override
//   _DropDownState createState() => _DropDownState();
// }
// class _DropDownState extends State<DropDown> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // width:50,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10.0),
//         color: Colors.blue[100],
//         boxShadow: [
//           BoxShadow(
//               blurRadius: 10,
//               color: Colors.black26,
//               offset: Offset(0, 2))
//         ],
//       ),
//       padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//       margin: EdgeInsets.all(10),
//       child: DropdownButton(
//         hint: Text("Select brand"),
//         value: widget._selected,
//         elevation: 0,
//         isExpanded: true,
//         style: TextStyle(
//             fontSize: 18,
//             color: Colors.indigo,
//             fontWeight: FontWeight.w400),
//         onChanged: (val) {
//           setState(() {
//             widget._selected = val;
//           });
//         },
//         items: widget._items.map((bname) {
//           return DropdownMenuItem(
//             child: new Text(bname),
//             value: bname,
//           );
//         }).toList(),
//       ),
//     );

//   }
// }

class ImageUpload extends StatelessWidget {
  String imageUrl;
  uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    PickedFile image;
    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _imagePicker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot = await _firebaseStorage
            .ref()
            .child('images/imageName')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        imageUrl = downloadUrl;
      } else {
        print('No Image Path Received');
      }
    } else {
      print('Permission not granted. Try Again with permission access');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(2, 2),
                spreadRadius: 2,
                blurRadius: 1,
              ),
            ],
          ),
          child: (imageUrl != null)
              ? Image.network(imageUrl)
              : Image.network('https://i.imgur.com/sUFH1Aq.png')),
      SizedBox(
        height: 20.0,
      ),
      RaisedButton(
        child: Text("Upload Image",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        onPressed: () {
          uploadImage();
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.blue)),
        elevation: 5.0,
        color: Colors.blue,
        textColor: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        splashColor: Colors.grey,
      ),
    ]);
  }
}

class SellCar extends StatefulWidget {
  @override
  _SellCarState createState() => _SellCarState();
}

class _SellCarState extends State<SellCar> {
  String name, mileage;
  List<String> _brandnames = [
    ' Maruti',
    'Suzuki',
    'Hyundai',
    'Tata',
    ' Mahindra',
    ' Kia',
    'BMW',
    'Jeep',
    'Ford',
    'Honda',
    'Totyota',
    'Ambassador',
    'Audi',
    'Bajaj',
    'Ferrari'
  ];
  String _selectedbrand, _selectedfuel, _selectedowner, _title, _description;
  int _year, _km, _price;
  List<String> _fueltypes = [
    'CNG & hybrids',
    'Diesel',
    'Electric',
    'LPG',
    'Petrol'
  ];
  List<String> _ownwerno = ['1', '2', '3', '4', '4+'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(title: Text("Car Dealer App")),
        resizeToAvoidBottomPadding: false,
        drawer: MySideBar(),
        body: Stack(children: [
          Background(
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blue[100],
                            // boxShadow: [
                            //   BoxShadow(
                            //       blurRadius: 10,
                            //       color: Colors.black26,
                            //       offset: Offset(0, 2))
                            // ],
                          ),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          margin: EdgeInsets.all(10),
                          child: DropdownButton(
                            hint: Text("Select brand"),
                            value: _selectedbrand,
                            elevation: 0,
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.indigo,
                                fontWeight: FontWeight.w400),
                            onChanged: (val) {
                              setState(() {
                                _selectedbrand = val;
                              });
                            },
                            items: _brandnames.map((bname) {
                              return DropdownMenuItem(
                                child: new Text(bname),
                                value: bname,
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              _year = int.parse(val);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide(color: Colors.indigoAccent),
                              ),
                              labelStyle: new TextStyle(color: Colors.indigo),
                              labelText: 'Year',
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blue[100],
                          ),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          margin: EdgeInsets.all(10),
                          child: DropdownButton(
                            hint: Text("Select fuel"),
                            value: _selectedfuel,
                            elevation: 0,
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.indigo,
                                fontWeight: FontWeight.w400),
                            onChanged: (val) {
                              setState(() {
                                _selectedfuel = val;
                              });
                            },
                            items: _fueltypes.map((fname) {
                              return DropdownMenuItem(
                                child: new Text(fname),
                                value: fname,
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              _km = int.parse(val);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide(color: Colors.indigoAccent),
                              ),
                              labelStyle: new TextStyle(color: Colors.indigo),
                              labelText: 'KM Driven',
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.blue[100],
                          ),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          margin: EdgeInsets.all(10),
                          child: DropdownButton(
                            hint: Text("Owner type"),
                            value: _selectedowner,
                            elevation: 0,
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.indigo,
                                fontWeight: FontWeight.w400),
                            onChanged: (val) {
                              setState(() {
                                _selectedowner = val;
                              });
                            },
                            items: _ownwerno.map((fname) {
                              return DropdownMenuItem(
                                child: new Text(fname),
                                value: fname,
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            onChanged: (val) {
                              _title = val;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide:
                                      BorderSide(color: Colors.indigoAccent),
                                ),
                                labelStyle: new TextStyle(color: Colors.indigo),
                                labelText: 'Title',
                                hintText:
                                    'mention the features(e.g. brand, model, age, type)'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            onChanged: (val) {
                              _description = val;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                  borderSide:
                                      BorderSide(color: Colors.indigoAccent),
                                ),
                                labelStyle: new TextStyle(color: Colors.indigo),
                                labelText: 'Description',
                                hintText:
                                    'include condition, features and reason for selling'),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (val) {
                              _price = int.parse(val);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                                borderSide:
                                    BorderSide(color: Colors.indigoAccent),
                              ),
                              labelStyle: new TextStyle(color: Colors.indigo),
                              labelText: 'Price in \u{20B9}',
                            ),
                          ),
                        ),
                        ImageUpload(),
                        SubmitBtn(
                          text: "Sell Car",
                          onPressed: () {},
                          sizeW: size.width,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomActionBar(
              hasBackArrrow: true,
              title: "Sell car",
              hasTitle: true,
              hasBackground: false,
              hasCount: false)
        ]));
  }
}
