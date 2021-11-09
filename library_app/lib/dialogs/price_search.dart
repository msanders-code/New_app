import 'package:flutter/material.dart';
import 'package:library_app/forms/book_info_form.dart';

class PriceSearchDialog extends StatelessWidget {
  final Function setScreen;
  const PriceSearchDialog({Key? key, required this.setScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Enter A Title And Author To Find Prices'),
      children: <Widget>[
        SimpleDialogOption(
          child: BookInfoForm(setScreen: setScreen),
          // onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}
