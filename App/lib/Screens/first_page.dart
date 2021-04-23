
import 'package:flutter/material.dart';


import 'package:carousel_slider/carousel_slider.dart';
// const Color mainColor=Color(0xFF5a5aff);
 
class FirstScreen extends StatefulWidget {
  @override

  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  int _currentIndex=0;

  List cardList=[
    Item1(),
    Item2(),
    Item3(),
    Item4()
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

   static const mainColor=Color(0xFFAFEADC);
  static const secColor=Color(0xFF041E42);
  static const backgroundColor=Color(0xFFAFEADC);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:Color(0xFFAFEADC),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
       
        children: <Widget>[
          SizedBox(height: size.height * 0.05 ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Car Buddy",
              style: TextStyle(
                  fontFamily: "Alegreya",
                  fontWeight: FontWeight.bold,
                  color: secColor,
                  fontSize: 70),
              textAlign: TextAlign.left,
            ),
          ),
          //SizedBox(height: size.height * 0.01),
        SizedBox(height:30.0,),
         /* Container(
            alignment: Alignment.center,
            child: new Image.asset('assets/images/img4.jpg'),
          ),*/
        
            CarouselSlider(
              options: CarouselOptions(
                height: 230.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(milliseconds: 700),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: cardList.map((card){
                return Builder(
                  builder:(BuildContext context){
                    return Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color:Color(0xFF041E42).withOpacity(0.1),
                        child: card,
                      ),
                    );
                  }
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(cardList, (index, url) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.black : Colors.grey,
                  ),
                );
              }),
            ),
            SizedBox(height:30.0,),
            SizedBox(
              width :180,
              height: 50,
              child:ElevatedButton(
              child: Text("Get Started",textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),
              onPressed: () {
                                    Navigator.pushNamed(context, '/auth');
                                  },
              style: ElevatedButton.styleFrom(
                primary: secColor,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60.0),
                ),
              ),
)
            /*Container(
                    // set width equal to height to make a square
                    width: 100,
                    height: 100,
                    child: RaisedButton(
                      color:secColor,
                      shape: RoundedRectangleBorder(
                          // set the value to a very big number like 100, 1000...
                          borderRadius: BorderRadius.circular(100)),
                      child: Text('Get Started',textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),
                      onPressed: () {
                        Navigator.pushNamed(context, '/auth');
                      },
                    ))*/
            /*Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/auth');
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              textColor: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: size.width * 0.5,
                /*decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: new LinearGradient(colors: [
                      Color.fromARGB(255, 255, 136, 34),
                      Color.fromARGB(255, 255, 177, 41)
                    ])),*/
                    color: secColor,
                padding: const EdgeInsets.all(0),
                child: Text(
                  "Get Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white),
                ),
              ),
            ),
          ),
          */
            ),
          ],

         ),
    );

  }
}
//  static const mainColor=Color(0xFFAFEADC);
//   static const secColor=Color(0xFF041E42);
  class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    // Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       stops: [0.3, 1],
    //       colors: [Colors.grey[300],Colors.grey[700],]
    //     ),
    //   ),
    //   child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/img4.jpg',
            height: 220.0,
            fit: BoxFit.cover,
          )
        ],
      // ),
    );
  }
}
class Item1 extends StatelessWidget {
  const Item1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    //  Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       stops: [0.3, 1],
    //       colors: [Colors.grey[300],Colors.grey[700],]
    //     ),
    //   ),
    //   child:
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
          'assets/images/img3.jpg',
    
            height: 220.0,
            fit: BoxFit.cover,
          )
        ],
      // ),
    );
  }
}
class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    // Container(
    //  decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       stops: [0.3, 1],
    //       colors: [Colors.grey[300],Colors.grey[700],]
    //     ),
    //   ),
      // child:
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/img5.jpg',
            height: 220.0,
            fit: BoxFit.cover,
          )
        ],
      // ),
    );
  }
}
class Item4 extends StatelessWidget {
  const Item4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    // Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment.topLeft,
    //       end: Alignment.bottomRight,
    //       stops: [0.3, 1],
    //       colors: [Colors.grey[300],Colors.grey[700],]
    //     ),
    //   ),
      // child:
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/img2.jpg',
            height: 220.0,
            fit: BoxFit.fill,
          )
        ],
      // ),
    );
  }
}



