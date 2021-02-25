import 'dart:ui';
import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/services/firebase_auth.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io';

// import 'package:car_dealer/screens/index_page.dart';
import 'package:car_dealer/widgets/custom_button.dart';
// import 'package:car_dealer/widgets/custom_input.dart';
import 'package:car_dealer/widgets/background1.dart';
// import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/widgets/sidebar.dart';
import 'package:car_dealer/widgets/custom_action_bar.dart';
import 'package:toast/toast.dart';

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
  final String email;
  final String username;
  SellCar({@required this.email, @required this.username});
  @override
  _SellCarState createState() => _SellCarState();
}

class _SellCarState extends State<SellCar> {
  String name, mileage, imageUrl;

  File _selectedImage;
  bool _loading = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseServices _firebaseServices = FirebaseServices();
  FirebaseMethods _firebaseMethods = FirebaseMethods();

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
  int _year, _km, _price, _mileage, _engine, _seats, _power;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  List<String> _fueltypes = [
    'CNG & hybrids',
    'Diesel',
    'Electric',
    'LPG',
    'Petrol'
  ];

  List<String> _ownwerno = ['1', '2', '3', '4', '4+'];

  Map arguments = {};

  _uploadImage() async {
    var tempImage = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(tempImage.path);
    });
  }

  Future<String> _getDownLoadUrl(BuildContext context) async {
    try {
      final Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('car_images/${basename(_selectedImage.path)}');
      final TaskSnapshot task =
          await firebaseStorageRef.putFile(_selectedImage);
      print("[INFO] Successfully stored image in firebase storage.");
      String url = await task.ref.getDownloadURL();
      return url;
    } catch (e) {
      throw e.toString();
    }
  }

  bool validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

  Future<void> _submit(BuildContext context) async {
    try {
      setState(() {
        _loading = true;
      });
      if (_selectedImage != null) {
        String imageUrl = await _getDownLoadUrl(context);
        String carId = "cars_${DateTime.now().toIso8601String()}";
        CarDetails carDetails = CarDetails(
            brand: _selectedbrand,
            carId: carId,
            userId: _firebaseServices.getUserId(),
            ownerName: arguments["username"],
            mileage: _mileage.toDouble(),
            kilometer_driven: _km.toDouble(),
            engine: _engine.toDouble(),
            owner_type: _selectedowner,
            power: _power.toDouble(),
            price: _price.toDouble(),
            seats: _seats,
            year: _year,
            fuel_type: _selectedfuel,
            title: _title,
            description: _description,
            mobileNumber: 9999999999,
            imageUrl: imageUrl);
        _firebaseMethods.addCarDetailsToDb(carDetails);
        print("[INFO] Successfully Registered");
        Toast.show("Car Registered. Wait for approval", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
            textColor: Colors.white,
            backgroundColor: Colors.black.withOpacity(0.6));

        var count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 2;
        });
      } else {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text("No Image was selected")));
      }
    } on FirebaseException catch (e) {
      print("[FIREBASE ERROR] ${e.message}");
    } catch (e) {
      print("[ERROR N] ${e.toString()}");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments as Map;
    print("[INFO] $arguments");
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        // appBar: AppBar(title: Text("Car Dealer App")),
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
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
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
                            child: DropdownButtonFormField(
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Cannot Be Empty")
                              ]),
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
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _year = int.parse(val);
                            },
                            labelText: "Year",
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue[100],
                            ),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            margin: EdgeInsets.all(10),
                            child: DropdownButtonFormField(
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Cannot Be Empty")
                              ]),
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
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _km = int.parse(val);
                            },
                            labelText: "KM Driven",
                          ),
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _mileage = int.parse(val);
                            },
                            labelText: "Mileage in KM/KG",
                          ),
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _engine = int.parse(val);
                            },
                            labelText: "Engine in CC",
                          ),
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _power = int.parse(val);
                            },
                            labelText: "Power in bhp",
                          ),
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _seats = int.parse(val);
                            },
                            labelText: "Seats",
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue[100],
                            ),
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            margin: EdgeInsets.all(10),
                            child: DropdownButtonFormField(
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Cannot Be Empty")
                              ]),
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
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.name,
                            onChanged: (val) {
                              _title = val;
                            },
                            labelText: "Title",
                          ),
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.multiline,
                            onChanged: (val) {
                              _description = val;
                            },
                            labelText: "Description",
                          ),
                          CustomFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "Cannot Be Empty")
                            ]),
                            keyBoardType: TextInputType.number,
                            onChanged: (val) {
                              _price = int.parse(val);
                            },
                            labelText: "Price",
                          ),
                          imageUploadWidget(),
                          SubmitBtn(
                            text: "Sell Car",
                            onPressed: () => _submit(context),
                            sizeW: size.width,
                          )
                        ],
                      ),
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
              hasCount: false),
          _loading == true
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : Container()
        ]));
  }

  Widget imageUploadWidget() {
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
          child: (_selectedImage != null)
              ? Image.file(_selectedImage)
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
          _uploadImage();
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
