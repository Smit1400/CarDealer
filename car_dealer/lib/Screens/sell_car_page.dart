import 'dart:ui';
import 'dart:io';
import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/widgets/custom_background.dart';
import 'package:car_dealer/widgets/dialog_box.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:toast/toast.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/services/firebase_auth.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/custom_form_field.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:car_dealer/widgets/custom_action_bar.dart';
import 'package:car_dealer/widgets/custom_button.dart';


class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
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
      // ignore: deprecated_member_use
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

  // ignore: deprecated_member_use
  List<Asset> images = List<Asset>();
  // ignore: deprecated_member_use
  List<File> files = List<File>();

  String _selectedbrand,
      _selectedfuel,
      _selectedtransmission,
      _selectedowner,
      _title,
      _description;
  int _year, _km, _price, _mileage, _engine, _seats, _power;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  List<String> _fueltypes = ['CNG', 'Diesel', 'Petrol', 'LPG', 'Electric'];

  List<String> _transmissionTypes = ['Manual', 'Automatic'];

  List<String> _ownwerno = ['First', 'Second', 'Fourth & Above', 'Third'];

  Map arguments = {};

  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  Future<void> loadAssets() async {
    // ignore: deprecated_member_use
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#ba5fe8",
          actionBarTitle: "Car Dealer",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
      print("[ERROR] $error");
    }

    if (!mounted) return;

    for (int i = 0; i < resultList.length; i++) {
      var byteData = await resultList[i].getByteData();

      var tempFile =
          File("${(await getTemporaryDirectory()).path}/${resultList[i].name}");
      var file = await tempFile.writeAsBytes(
        byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
      );

      setState(() {
        files.add(file);
      });
    }
  }



  Future<List<dynamic>> _getDownLoadUrl(BuildContext context) async {
    try {
      List urls = [];
      for (int i = 0; i < files.length; i++) {
        final Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('car_images/${basename(files[i].path)}');
        final TaskSnapshot task = await firebaseStorageRef.putFile(files[i]);
        print("[INFO] Successfully stored image in firebase storage.");
        String url = await task.ref.getDownloadURL();
        setState(() {
          urls.add(url);
        });
      }
      return urls;
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
      if (files != null && files.length > 0) {
        List imageUrls = await _getDownLoadUrl(context);
        String carId = "cars_${DateTime.now().toIso8601String()}";
        CarDetails carDetails = CarDetails(
            transmissionType: _selectedtransmission,
            brand: _selectedbrand,
            carId: carId,
            userId: _firebaseServices.getUserId(),
            ownerName: widget.username,
            mileage: _mileage.toDouble(),
            kilometer_driven: _km.toDouble(),
            engine: _engine.toDouble(),
            owner_type: _selectedowner,
            power: _power.toDouble(),
            price: _price.toDouble(),
            seats: _seats,
            year: _year,
            fuel_type: _selectedfuel,
            title: _title.toLowerCase(),
            description: _description,
            mobileNumber: 9999999999,
            imageUrls: imageUrls);
        _firebaseMethods.addCarDetailsToDb(carDetails);
        print("[INFO] Successfully Registered");
        Toast.show("Car Registered. Wait for approval", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.TOP,
            textColor: Colors.white,
            backgroundColor: Colors.green);
        Navigator.pop(context);
      } else {
        _scaffoldKey.currentState
            // ignore: deprecated_member_use
            .showSnackBar(SnackBar(content: Text("No Image was selected")));
      }
    } on FirebaseException catch (e) {
      print("[FIREBASE ERROR] ${e.message}");
      await showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              title: "ERROR",
              buttonText1: 'OK',
              button1Func: () {
                Navigator.of(context).pop();
              },
              icon: Icons.clear,
              description: '${e.message}',
              iconColor: Colors.red,
            );
          });
    } catch (e) {
      print("[ERROR N] ${e.toString()}");
      await showDialog(
          context: context,
          builder: (context) {
            return DialogBox(
              title: "ERROR",
              buttonText1: 'OK',
              button1Func: () {
                Navigator.of(context).pop();
              },
              icon: Icons.clear,
              description: '${e.toString()}',
              iconColor: Colors.red,
            );
          });
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
        //appBar: AppBar(backgroundColor: Colors.black87,
        //title: Text("Sell your car"),
        //),

        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        // drawer: MySideBar(),
        body: SafeArea(
            child: Stack(
          children: [
            CustomBackground(
              path: "assets/images/sell-car.json",
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 35),
                      ),
                      Form(
                        key: _formKey,
                        autovalidateMode: _autovalidateMode,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 25),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Constants.mainColor,
                              ),
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              margin: EdgeInsets.all(10),
                              child: DropdownButtonFormField(
                                dropdownColor: Constants.mainColor,
                                autovalidateMode: _autovalidateMode,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Constants.mainColor,
                                    enabledBorder: InputBorder.none),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "Cannot Be Empty")
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
                                borderRadius: BorderRadius.circular(20.0),
                                color: Constants.mainColor,
                              ),
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              margin: EdgeInsets.all(10),
                              child: DropdownButtonFormField(
                                dropdownColor: Constants.mainColor,
                                autovalidateMode: _autovalidateMode,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Constants.mainColor,
                                    enabledBorder: InputBorder.none),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "Cannot Be Empty")
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
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Constants.mainColor,
                              ),
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              margin: EdgeInsets.all(10),
                              child: DropdownButtonFormField(
                                dropdownColor: Constants.mainColor,
                                autovalidateMode: _autovalidateMode,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Constants.mainColor,
                                    enabledBorder: InputBorder.none),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "Cannot Be Empty")
                                ]),
                                hint: Text("Select Transmission"),
                                value: _selectedtransmission,
                                elevation: 0,
                                isExpanded: true,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.w400),
                                onChanged: (val) {
                                  setState(() {
                                    _selectedtransmission = val;
                                  });
                                },
                                items: _transmissionTypes.map((fname) {
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
                              labelText: "Mileage in kmpl",
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
                                borderRadius: BorderRadius.circular(20.0),
                                color: Constants.mainColor,
                              ),
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              margin: EdgeInsets.all(10),
                              child: DropdownButtonFormField(
                                dropdownColor: Constants.mainColor,
                                autovalidateMode: _autovalidateMode,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Constants.mainColor,
                                    enabledBorder: InputBorder.none),
                                validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: "Cannot Be Empty")
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
                              text: "Register Car",
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
              title: "Sell Car",
              hasBackArrrow: true,
              hasCount: false,
              hasBackground: false,
            ),
            _loading == true
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: Lottie.asset(
                        "assets/images/3532-car.json",
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),
          ],
        )));
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
          child: (files.length > 0 && files != null)
              ? Image.file(files[0])
              : Image.network('https://i.imgur.com/sUFH1Aq.png')),
      SizedBox(
        height: 20.0,
      ),
      // ignore: deprecated_member_use
      RaisedButton(
        child: Text(
          "Upload Image",
          style: GoogleFonts.oswald(
            textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        onPressed: () {
          loadAssets();
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),),
        elevation: 5.0,
        color: Constants.mainColor,
        textColor: Constants.secColor,
        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
        splashColor: Colors.grey,
      ),
    ]);
  }
}
