/*
TO DO:

3.) Work on adding in remaining functionality
      - Add delete book functionality
      - Add search functionality
      - Set it up to use file system for storage - maybe

      - Add no image when writng new book to file
      - Add new image to file when image search finds one
      - Add alert dialog when delete image is pressed
      - Delete info from file when delete dialog is confirmed
*/

import 'package:flutter/material.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/price_compare_page.dart';

void main() {
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
  bool comparePrice = false;

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
                title: 'Personal Library',
                setScreen: (homeScreen, priceScreen, data) {
                  setState(() {
                    isHome = homeScreen;
                    comparePrice = priceScreen;
                    pricing = data;
                  });
                },
              ),
            ),
            if (comparePrice == true)
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
              comparePrice = false;
              isHome = true;
              pricing = {};
            }
            return isHome;
          }),
    );
  }
}
