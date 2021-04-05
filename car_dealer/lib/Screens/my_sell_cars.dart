import 'package:car_dealer/components/constants.dart';
import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/product_card_my_cars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';


class MySellCars extends StatefulWidget {
  @override
  _MySellCarsState createState() => _MySellCarsState();
}

class _MySellCarsState extends State<MySellCars> {
// final _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    //print(screenWidth);
    //print(screenHeight);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
      // key: _scaffoldKey,
        appBar: AppBar(
          
      //      leading: Padding(
      //   padding: const EdgeInsets.only(left: 8.0),
      //   child: Image.asset(
      //     "assets/images/logo5.png",
      //     fit: BoxFit.contain,
      //     height: 19,
      //   ),
      // ),
      backgroundColor: Color(0xFF041E42),
      title: Text(
        "Car Buddy",
        style: GoogleFonts.oswald(),
      ),
          iconTheme: IconThemeData(color: Constants.mainColor),
          // title: Text('Car Buddy',
          //     style: TextStyle(
          //         fontSize: screenHeight*0.028,
          //         color: Constants.secColor,
          //         fontWeight: FontWeight.bold)),
          // backgroundColor: Colors.white,
          bottom: TabBar(
            isScrollable: true,
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Constants.mainColor, width: 5.0)),
            tabs: <Widget>[
              Tab(
                  child:
                      Text('   SOLD  ',)),
              Tab(
                  child:
                      Text('   NOT SOLD   ',)),
     
            ],
          ),
        ),
   
      resizeToAvoidBottomInset: false,
      body: TabBarView(
      children: <Widget>[
      Container(
        child: (
          StreamBuilder<List<CarDetails>>(
            initialData: [],
            stream: _firebaseMethods.getSoldCarsUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
                List<CarDetails> data = snapshot.data;
                if (data.length > 0) {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return data[index].approved == true ? 
                        ProductCard(
                        title: data[index].title,
                        imageUrl: data[index].imageUrls[0],
                        price: data[index].price,
                        productId: data[index].carId,
                        isSold:true
                      )
                        // ProductCard(car: data[index],)
                        : Container();
                      });
                }
                else{
                  return Scaffold(
                body: Center(
                  child: Text("No Products", style: GoogleFonts.oswald(
                    textStyle: TextStyle(color: Constants.secColor, fontSize: 24,
                  ),),
                ),
              ));
            }
            },
          )
      ),
    ),
    Container(
        child: (
          StreamBuilder<List<CarDetails>>(
            initialData: [],
            stream: _firebaseMethods.getSellCarsUser(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
                List<CarDetails> data = snapshot.data;
                if (data.length > 0) {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return data[index].approved == true ? 
                        ProductCard(
                          carId:data[index].carId,
                        title: data[index].title,
                        imageUrl: data[index].imageUrls[0],
                        price: data[index].price,
                        productId: data[index].carId,
                        isSold:false
                      )
                        // ProductCard(car: data[index],)
                        : Container();
                      });
                }
                else{
                  return Scaffold(
                body: Center(
                  child: Text("No Products", style: GoogleFonts.oswald(
                    textStyle: TextStyle(color: Constants.secColor, fontSize: 24,
                  ),),
                ),
                ),
              );
            }
            },
          )
      ),
    ),
      ]
    )
    ));
  }
}
