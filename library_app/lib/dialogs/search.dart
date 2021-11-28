import 'package:flutter/material.dart';
import 'package:library_app/forms/book_form.dart';

// Dialog to search current library for specified book
class BookSearchDialog extends StatelessWidget {
  const BookSearchDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SimpleDialog(
      title: Text('Enter A Title And Author To Search Library'),
      children: <Widget>[
        SimpleDialogOption(
          child: BookForm(),
        )
      ],
    );
  }
}
