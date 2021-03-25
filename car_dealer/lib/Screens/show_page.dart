import 'package:flutter/material.dart';
import 'package:car_dealer/widgets/custom_action_bar.dart';
import 'package:car_dealer/widgets/image_swipe.dart';
import 'package:car_dealer/widgets/bordered_container.dart';
import 'package:car_dealer/widgets/custom_block.dart';
import 'package:car_dealer/services/firebase_auth.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
_callNumber(String phoneNumber) async {
  String number = phoneNumber;
  await FlutterPhoneDirectCaller.callNumber(number);
}
_launchPhoneURL(String phoneNumber) async {
  String url = 'tel:' + phoneNumber;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
class ShowPage extends StatefulWidget {
  final String productId;
  ShowPage({this.productId});
  @override
  _ShowPageState createState() => _ShowPageState();
}
TextEditingController textEditingController = TextEditingController();
class _ShowPageState extends State<ShowPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  final SnackBar _snackBar = SnackBar(
    content: Text("Car added to wishlist"),
  );
//  bool _visibleSpec = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // appBar: AppBar(),
        body: SafeArea(
            child: Stack(
      children: [
        FutureBuilder(
            future: _firebaseServices.carRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data.data();
                List imageList = documentData['imageUrls'];
                return Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(0),
                    child: ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: [
                        Center(
                          child: ImageSwipe(
                            imageList: imageList,
                            price: "${documentData['price']}" ?? "Price",
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: Text(
                              "${documentData['title']}" ?? "Product title",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                // fontStyle: FontStyle.
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4.0),
                                child: Text("Key Specification",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      // fontStyle: FontStyle.
                                    )),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SpecsBlock(
                                      label: "Engine",
                                      value:
                                          ("${documentData['engine']}" + " cc"),
                                      icon: Icon(
                                        Icons.directions_car,
                                      ),
                                    ),
                                    SpecsBlock(
                                      label: "Mileage",
                                      value: (" ${documentData['mileage']}" +
                                          " kmpl"),
                                      icon: Icon(
                                        Icons.directions_car,
                                      ),
                                    ),
                                    SpecsBlock(
                                      label: "Power",
                                      value: (" ${documentData['power']}" +
                                          " bhp"),
                                      icon: Icon(
                                        Icons.directions_car,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              descListItem(
                                  title: "Description",
                                  icon: Icons.description,
                                  context: context,
                                  txt: " ${documentData['description']}"),
                              specListItem(
                                  title: "Specifications",
                                  icon: Icons.menu,
                                  context: context,
                                  vals: [
                                    "${documentData['brand']}",
                                    " ${documentData['fuel_type']}",
                                    " ${documentData['year']}",
                                    " ${documentData['seats']}",
                                    " ${documentData['transimission_type']}",
                                    " ${documentData['km_driven']}",
                                    " ${documentData['owner_type']}"
                                  ]),
                              userDescListItem(
                                  title: "UserDetails",
                                  icon: Icons.person,
                                  context: context,
                                  vals: [
                                    " ${documentData['ownerName']}",
                                    " ${documentData['mobileNumber']}"
                                  ]),
                              Card(
                                  elevation: 0.5,
                                  child: ListTile(
                                      leading: Icon(
                                        Icons.open_in_new_rounded,
                                        size: 40,
                                      ),
                                      title: Text(
                                        "Share",
                                        style: TextStyle(fontSize: 17),
                                      ))),
                            ],
                          ),
                        ),
                        Expanded(
                            child: GestureDetector(
                          onTap: () async {
                            _firebaseMethods.addCarToWishlist(widget.productId);
                            Scaffold.of(context).showSnackBar(_snackBar);
                          },
                          child: Container(
                              height: 65,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(12)),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.bookmark_border_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text("Add to wishlist",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600))
                                ],
                              )),
                        )),
                      ],
                    ));
              }
              return Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              ));
            }),
        CustomActionBar(
          hasBackArrrow: true,
          hasTitle: false,
          hasBackground: false,
        )
      ],
    )));
  }
}

Widget specListItem(
    {int index, String title, IconData icon, BuildContext context, List vals}) {
  print(vals);
  return Material(
    color: Colors.transparent,
    child: Theme(
        data: ThemeData(accentColor: Colors.black),
        child: Card(
          elevation: 0.5,
          child: ExpansionTile(
            leading: Icon(
              icon,
              size: 40,
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 17),
            ),
            children: <Widget>[
              BorderedContainer(
                title: "Brand",
                value: vals[0],
                color: Colors.white70,
              ),
              BorderedContainer(
                title: "Fuel Type",
                value: vals[1],
                color: Colors.white70.withOpacity(0.8),
              ),
              BorderedContainer(
                title: "Year of Manufacture",
                value: vals[2],
                color: Colors.white70,
              ),
              BorderedContainer(
                title: "No. of seats",
                value: vals[3],
                color: Colors.white70.withOpacity(0.8),
              ),
              BorderedContainer(
                title: "Transmission Type",
                value: vals[4],
                color: Colors.white70,
              ),
              BorderedContainer(
                title: "Kilometer driven",
                value: vals[5],
                color: Colors.white70.withOpacity(0.8),
              ),
              BorderedContainer(
                title: "Owner Type",
                value: vals[6],
                color: Colors.white70,
              ),
            ],
          ),
        )),
  );
}
Widget userDescListItem(
    {int index, String title, IconData icon, BuildContext context, List vals}) {
  print(vals);
  return Material(
    color: Colors.transparent,
    child: Theme(
        data: ThemeData(accentColor: Colors.black),
        child: Card(
          elevation: 0.5,
          child: ExpansionTile(
            leading: Icon(
              icon,
              size: 40,
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 17),
            ),
            children: <Widget>[
              BorderedContainer(
                title: "Owner name",
                value: vals[0],
                color: Colors.white70.withOpacity(0.8),
              ),
              Card(
      elevation: 0.5,
      color:Colors.white70.withOpacity(0.8),
     
      // margin: margin ??  const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        // width: 100,
        padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child:GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text('Contact'),
          Text(vals[1],style: TextStyle( fontWeight: FontWeight.bold, ),),
          ],
        ),
       
        /*onTap:(){
          _launchPhoneURL(textEditingController.value[1]);
          }, */
        ),
      ),
          
    ),
            ],
          ),
        ),
        ),
  );
}
Widget descListItem(
    {String title, IconData icon, BuildContext context, String txt}) {
  return Material(
    color: Colors.transparent,
    child: Theme(
      data: ThemeData(accentColor: Colors.black),
      child: Card(
          elevation: 0.5,
          child: ExpansionTile(
            childrenPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            expandedAlignment: Alignment.centerLeft,
            leading: Icon(
              icon,
              size: 40,
            ),
            title: Text(
              title,
              style: TextStyle(fontSize: 17),
            ),
            children: <Widget>[
              Container(
                // decoration: BoxDecoration(color:Colors.red.withOpacity(0.8),),
                child: Text(txt),
              )
            ],
          )),
    ),
  );
}
