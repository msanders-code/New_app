import 'package:flutter/material.dart';
import 'book_list_item.dart';
import 'list_separator.dart';
import 'package:library_app/models/book.dart';

// Create list from file read

// List of books for the home page
class BookList extends StatefulWidget {
  //final int numItems;
  //, required this.numItems
  const BookList({Key? key}) : super(key: key);

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
    'The Call Of The Wild'
  ];
  // Temp author list
  List<String> authorList = [
    'J.R.R. Tolkein',
    'J.K. Rowling',
    'Willa Cather',
    'Ayn Rand',
    'Jack London'
  ];
  @override
  Widget build(BuildContext context) {
    // Renders the list of books on the home page
    return ListView.separated(
      itemCount: titleList.length,
      // Adds each list item to the list
      itemBuilder: (BuildContext context, int index) {
        return BookListItem(
            book: List.generate(
                titleList.length,
                (index) =>
                    Book(title: titleList[index], author: authorList[index])),
            index: index);
      },
      // Adds a separator line between each list item
      separatorBuilder: (BuildContext context, int index) {
        return const ListSeparator();
      },
    );
  }
}
