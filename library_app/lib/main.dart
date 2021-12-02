/*
TO DO:

3.) Work on adding in remaining functionality
      - Add search functionality
*/

import 'package:flutter/material.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/price_compare_page.dart';
import 'package:localstore/localstore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// App state to enable navigation
class _MyAppState extends State<MyApp> {
  bool isHome = true;
  //bool comparePrice = false;
  Localstore db =
      Localstore.instance; // Initializes database like local storage

  // Variable to transfer price data to price screen
  Map<String, String> pricing = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      // Page navigation to and from the price listing page
      home: Navigator(
          pages: [
            MaterialPage(
              child: MyHomePage(
                storage: db,
                setScreen: (homeScreen, data) {
                  setState(() {
                    isHome = homeScreen;
                    pricing = data;
                  });
                },
              ),
            ),
            if (isHome == false)
              MaterialPage(
                  child: PriceComparisson(
                title: 'Compare Book Prices',
                priceData: pricing,
              )),
          ],
          // Tell the app what page to go back to when back button pressed
          onPopPage: (route, result) {
            bool popStatus = route.didPop(result);
            if (popStatus == true) {
              isHome = true;
              pricing = {};
            }
            return isHome;
          }),
    );
  }
}
