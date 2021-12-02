import 'package:flutter/material.dart';
import 'book_list_item.dart';
import 'list_separator.dart';
import 'package:localstore/localstore.dart';

Localstore db = Localstore.instance;

// Future list of books for the home page
class BookList extends StatelessWidget {
  final Function screen;
  BookList({Key? key, required this.screen}) : super(key: key);

  final Future<List<Map<String, dynamic>>> _future = Future.sync(() async {
    final dbData = await db.collection('books').get();
    List<Map<String, dynamic>> bookData = [];
    if (dbData != null) {
      Iterable values = dbData.values;
      for (Map<String, dynamic> book in values) {
        bookData.add(book);
      }
    }
    return bookData;
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        List<Map<String, dynamic>>? data = snapshot.data;
        if (data != null && data.isEmpty) {
          return Center(
            child: Text(
                'There are no books in your library!\nUse the add icon above to add some.',
                style: TextStyle(fontSize: 18, color: Colors.indigo[700])),
          );
        } else if (data != null && data.isNotEmpty) {
          // Renders the list of books on the home page
          return ListView.separated(
            itemCount: data.length,
            // Adds each list item to the list
            itemBuilder: (BuildContext context, int index) {
              return BookListItem(
                book: data,
                index: index,
                storage: db,
                screen: screen,
              );
            },
            // Adds a separator line between each list item
            separatorBuilder: (BuildContext context, int index) {
              return const ListSeparator();
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
