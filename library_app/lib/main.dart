/*
TO DO:

3.) Work on adding in remaining functionality
      - Add book information form
      - Add delete book functionality
      - Add search functionality
      - Set it up to use file system for storage - maybe
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
                setScreen: (homeScreen, priceScreen) {
                  setState(() {
                    isHome = homeScreen;
                    comparePrice = priceScreen;
                  });
                },
              ),
            ),
            if (comparePrice == true)
              const MaterialPage(
                  child: PriceComparisson(
                title: 'Compare Book Prices',
              )),
          ],
          // Tell the app what page to go back to when back button pressed
          onPopPage: (route, result) {
            bool popStatus = route.didPop(result);
            if (popStatus == true) {
              comparePrice = false;
              isHome = true;
            }
            return isHome;
          }),
    );
  }
}
