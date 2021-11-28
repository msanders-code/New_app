import 'package:flutter/material.dart';
import 'package:library_app/forms/book_form.dart';

// Dialog to add a book to the library
class AddBookDialog extends StatelessWidget {
  const AddBookDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleDialog(
      title: Text('Enter A Title And Author To Add Book To Library'),
      children: <Widget>[
        SimpleDialogOption(
          child: BookForm(),
        )
      ],
    );
  }
}
