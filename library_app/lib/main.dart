/*
TO DO:

2.) Change app layout to integrate services
      - Set up form for searching for prices
      - Refactor book pricing page to just show list of prices
      - Set the book list item photo to change based on service response
      - Add items to book pricing page based on service response

2.5.) Integrate Services
      - Learn how to do HTTP requests and use data
      - Learn how to set up to use localhost server

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
