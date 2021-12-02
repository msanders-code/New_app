import 'package:flutter/material.dart';
import 'package:library_app/components/book_list.dart';
import 'package:library_app/dialogs/price_search.dart';
import 'package:library_app/dialogs/add_book.dart';
import 'package:library_app/dialogs/search.dart';
import 'package:localstore/localstore.dart';

class MyHomePage extends StatefulWidget {
  final Function setScreen; // Variable used for navigating between pages
  final Localstore storage;

  const MyHomePage({Key? key, required this.setScreen, required this.storage})
      : super(key: key);

  @override
  // Initializes the state of the home page
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //List<Map<String, dynamic>> bookData = [];
  Map<String, String> data = {};
  // Adds any books already stored to list to initialize main page

  @override
  Widget build(BuildContext context) {
    // Returns the home page
    return Scaffold(
        appBar: AppBar(
          primary: true,
          title: const Text('Personal Library'),
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
                List<String> info = result.split(',');
                // Sets new id for stored item
                String id = widget.storage.collection('books').doc().id;

                // Saves new book in local database
                widget.storage.collection('books').doc(id).set({
                  'id': id,
                  'title': info[0],
                  'author': info[1],
                  'cover':
                      'https://th.bing.com/th/id/R.855e8ca01684f0d61e302ba09a177bfd?rik=TbKuqNR1U%2bV6Iw&riu=http%3a%2f%2ffremontgurdwara.org%2fwp-content%2fuploads%2f2020%2f06%2fno-image-icon-2.png&ehk=piUctuaeByVRg5s2YCzOsXApik4AfjUmmzMKA1cPKEs%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1'
                });
                setState(() {
                  widget.setScreen(true, data);
                });
              },
              icon: const Icon(Icons.library_add_rounded),
              iconSize: 25,
            ),

            IconButton(
              // Starts the dialog to search prices
              onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) {
                    // Route to price comparisson page
                    return PriceSearchDialog(
                      setScreen: widget.setScreen,
                    );
                  }),
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
        body: BookList(screen: widget.setScreen));
  }
}
