import 'package:car_dealer/models/car_details.dart';
import 'package:car_dealer/services/firebase_db.dart';
import 'package:car_dealer/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:car_dealer/screens/filter_page.dart';


class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var  _order=true;
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Stack(
        children: [
          StreamBuilder<List<CarDetails>>(
            initialData: [],
            stream: _firebaseMethods.getAllCars(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                    ),
                  ),
                );
              }
              List<CarDetails> data = snapshot.data;
              print("order1" + _order.toString());
              if (data.length > 0) {
            
                return Container(
                  child: Column(
                    children: [
                      Container(
                        color:Colors.blue.withOpacity(0.1),
                        child: Row(
                          
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [ IconButton(
                                icon: Icon(Icons.filter_alt),
                                onPressed: () {
                                 Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Filters()
                                      ),
                                    );
                                }),
                            IconButton(
                                icon: Icon(Icons.sort),
                                onPressed: () {
                                  setState(() {

                                    // k = snapshot.data.length - index - 1;
                                    print(data[0].title);
                                    _order = !_order;
                                    print("order3" + _order.toString());
                                  });
                                })
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                              reverse: _order,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return data[index].approved == true
                                    ? CarCard(
                                        car: data[index],
                                      )
                                    : Container();
                              }),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Scaffold(
                  body: Center(
                    child: Text(
                      "No Products",
                      style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
