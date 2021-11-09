import 'package:flutter/material.dart';
import 'package:library_app/components/book_list.dart';

// The home page of the application.
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
              onPressed: () {},
              icon: const Icon(Icons.library_add_rounded),
              iconSize: 25,
            ),
            // Route to price comparisson page
            IconButton(
              onPressed: () => setState(() {
                widget.setScreen(false, true);
              }),
              icon: const Icon(Icons.attach_money),
              iconSize: 25,
            ),
            // Opens a search bar on current screen to search book list
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              iconSize: 25,
            )
          ],
        ),
        // Renders the list of books on the home page
        body: const BookList(numItems: 5));
  }
}
