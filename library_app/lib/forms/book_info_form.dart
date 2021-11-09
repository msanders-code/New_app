import 'package:flutter/material.dart';

// Book information entry form
class BookInfoForm extends StatefulWidget {
  const BookInfoForm({Key? key}) : super(key: key);
  @override
  State<BookInfoForm> createState() => _BookInfoFormState();
}

class _BookInfoFormState extends State<BookInfoForm> {
  final GlobalKey<FormFieldState<String>> _titleFormFieldKey = GlobalKey();
  final GlobalKey<FormFieldState<String>> _authorFormFieldKey = GlobalKey();

  // bool _notEmpty(String? value) => value != null && value.isNotEmpty;

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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // Submit button - prints the entered values to console for now
                OutlinedButton(
                    onPressed: () {
                      if (_titleFormFieldKey.currentState!.validate() &&
                          _authorFormFieldKey.currentState!.validate()) {
                        print(_value);
                      }
                    },
                    child: const Center(
                        child: Text('Submit',
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold)))),
                // Reset button - resets the form fields to empty
                OutlinedButton(
                    onPressed: () => Form.of(context)?.reset(), // Resets form
                    child: Center(
                        child: Text('Reset',
                            style: TextStyle(
                                color: Colors.pink[700],
                                fontWeight: FontWeight.bold)))),
                // Cancel button - exits the form and resets the values
                OutlinedButton(
                    onPressed: () {
                      Form.of(context)?.reset(); // Resets the form fields
                      Navigator.pop(context); // Exits the form
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
