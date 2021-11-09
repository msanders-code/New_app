import 'package:flutter/material.dart';
import 'book_list_item.dart';
import 'list_separator.dart';

// List of books for the home page
class BookList extends StatefulWidget {
  final int numItems;
  const BookList({Key? key, required this.numItems}) : super(key: key);

  @override
  // Initializes the state of the book list
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  // Temp title list
  List<String> titleList = [
    'The Hobbit',
    'Harry Potter and The Chanber Of Secrets',
    'My Antonia',
    'Atlas Shrugged',
    'Hood'
  ];
  // Temp author list
  List<String> authorList = [
    'J.R.R. Tolkein',
    'J.K. Rowling',
    'Willa Cather',
    'Ayn Rand',
    'Stephen R. Lawhead'
  ];
  @override
  Widget build(BuildContext context) {
    // Renders the list of books on the home page
    return ListView.separated(
      itemCount: widget.numItems,
      // Adds each list item to the list
      itemBuilder: (BuildContext context, int index) {
        return BookListItem(title: titleList[index], author: authorList[index]);
      },
      // Adds a separator line between each list item
      separatorBuilder: (BuildContext context, int index) {
        return const ListSeparator();
      },
    );
  }
}
