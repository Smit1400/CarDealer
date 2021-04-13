import 'package:car_dealer/Screens/admin_analysis.dart';
import 'package:car_dealer/screens/auth screens/auth2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:car_dealer/screens/landing_page.dart';
import 'package:car_dealer/screens/index_page.dart';
import 'package:car_dealer/screens/wishlist_page.dart';
import 'package:car_dealer/tabs/home_tab.dart';
import 'package:car_dealer/tabs/saved_tab.dart';
import 'package:car_dealer/tabs/search_tab.dart';
import 'package:car_dealer/screens/price_predict.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
 
      // theme: ThemeData(
      //   textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      // ),
      initialRoute: '/',
      routes: {
        '/':(context) =>AdminAnalysis(),
        '/auth':(context) => HomePage(),
        // '/':(context) =>NewHomeScreen(),
        // '/login': (context) => LoginPage(),
        // '/register': (context) => RegisterPage(),
        // '/auth':(context) => AuthScreen(),
        '/index':(context)=>IndexPage(),
        '/pedictprice':(context)=>PricePredict(),
        // '/sellcar':(context)=>SellCar(),
        '/wishlist':(context)=>WishlistPage(),
        '/hometab':(context)=>HomeTab(),
        '/savedtab':(context)=>SavedTab(),
        '/searchtab':(context)=>SearchTab(),
      },
      // home: LandingPage(),
    );
  }
}
