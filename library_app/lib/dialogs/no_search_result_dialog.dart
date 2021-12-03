import 'package:flutter/material.dart';

// Dialog to display a message when the search results in no book found
class NoSearchResultDialog extends StatelessWidget {
  const NoSearchResultDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Search Results'),
      children: <Widget>[
        SimpleDialogOption(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Text(
                  'Book Not Found',
                  style: TextStyle(
                      color: Colors.indigo[900],
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
