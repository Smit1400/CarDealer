import 'package:car_dealer/screens/landing_page.dart';
import 'package:car_dealer/screens/auth screens/auth2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:car_dealer/tabs/home_tab.dart';
import 'package:car_dealer/tabs/saved_tab.dart';
import 'package:car_dealer/tabs/search_tab.dart';
import 'package:car_dealer/screens/price_predict.dart';
import 'package:car_dealer/screens/faq.dart';
import 'Screens/index_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context) =>LandingPage(),
        '/auth':(context) => HomePage(),
        '/index':(context)=>IndexPage(),
        '/pedictprice':(context)=>PricePredict(),
        '/hometab':(context)=>HomeTab(),
        '/savedtab':(context)=>SavedTab(),
        '/searchtab':(context)=>SearchTab(),
        '/faq':(context)=>faq(),
      },
    );
  }
}
