import 'package:flutter/material.dart';
import 'package:library_app/components/book_list.dart';
import 'package:library_app/dialogs/price_search.dart';
import 'package:library_app/dialogs/add_book.dart';
import 'package:library_app/dialogs/search.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final Function setScreen; // Variable used for navigating between pages

  const MyHomePage({Key? key, required this.title, required this.setScreen})
      : super(key: key);

  @override
  // Initializes the state of the home page
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Returns the home page
    return Scaffold(
        appBar: AppBar(
          primary: true,
          title: Text(widget.title),
          actions: <Widget>[
            // Brings up a form to add a book to the library
            IconButton(
              // Write to file
              onPressed: () async {
                String result = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AddBookDialog();
                  },
                );
                print(result);
              },
              icon: const Icon(Icons.library_add_rounded),
              iconSize: 25,
            ),

            IconButton(
              // Starts the dialog to search prices
              onPressed: () async {
                String result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // Route to price comparisson page
                      return PriceSearchDialog(
                        setScreen: widget.setScreen,
                      );
                    });
                print(result); // Temporary
              },
              icon: const Icon(Icons.attach_money),
              iconSize: 25,
            ),
            // Opens a search bar on current screen to search book list
            IconButton(
              onPressed: () async {
                String result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const BookSearchDialog();
                    });
                // Read file for information, if found display info; else, print 'Not Found'
                print(result); // Temporary
              },
              icon: const Icon(Icons.search),
              iconSize: 25,
            )
          ],
        ),
        // Renders the list of books on the home page
        body: const BookList());
  }
}
