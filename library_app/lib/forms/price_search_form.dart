import 'package:flutter/material.dart';

class BookInfoForm extends StatefulWidget {
  @override
  State<BookInfoForm> createState() => _BookInfoFormState();
}

class _BookInfoFormState extends State<BookInfoForm> {
  final GlobalKey<FormFieldState<String>> _titleFormFieldKey = GlobalKey();
  final GlobalKey<FormFieldState<String>> _authorFormFieldKey = GlobalKey();

  _notEmpty(String value) => value != null && value.isNotEmpty;

  get _value => ({
        'title': _titleFormFieldKey.currentState?.value,
        'author': _authorFormFieldKey.currentState?.value
      });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: <Widget>[
        TextFormField(
          key: _titleFormFieldKey,
          decoration: const InputDecoration(
            labelText: 'Title',
          ),
          validator: (value) => !_notEmpty(_value) ? 'Title is required' : null,
        ),
        TextFormField(
          key: _authorFormFieldKey,
          decoration: const InputDecoration(labelText: 'Author'),
          validator: (value) =>
              !_notEmpty(_value) ? 'Author is required' : null,
        ),
      ],
    ));
  }
}
