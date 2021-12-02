import 'package:flutter/material.dart';

// Book information entry form
class BookForm extends StatefulWidget {
  const BookForm({Key? key}) : super(key: key);
  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final GlobalKey<FormFieldState<String>> _titleFormFieldKey = GlobalKey();
  final GlobalKey<FormFieldState<String>> _authorFormFieldKey = GlobalKey();

  // Saves the entered values from the form
  get _value => ({
        'title': _titleFormFieldKey.currentState?.value,
        'author': _authorFormFieldKey.currentState?.value
      });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: <Widget>[
        // Form field to enter the book's title
        TextFormField(
            autofocus: true,
            key: _titleFormFieldKey,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Title is required.';
              } else {
                return null;
              }
            }),
        // Form field to enter the book's author
        TextFormField(
            key: _authorFormFieldKey,
            decoration: const InputDecoration(labelText: 'Author'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Author is required.';
              } else {
                return null;
              }
            }),
        Builder(
          builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Submit button
                OutlinedButton(
                    onPressed: () {
                      if (_titleFormFieldKey.currentState!.validate() &&
                          _authorFormFieldKey.currentState!.validate()) {
                        Navigator.pop(
                            context, '${_value['title']},${_value['author']}');
                      }
                    },
                    child: const Center(
                        child: Text('Submit',
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold)))),
                // Cancel button - exits the form
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, 'CANCEL');
                    },
                    child: Center(
                        child: Text('Cancel',
                            style: TextStyle(
                                color: Colors.red[900],
                                fontWeight: FontWeight.bold)))),
              ],
            );
          },
        )
      ],
    ));
  }
}
