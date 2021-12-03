import 'package:flutter/material.dart';

// Dialog to print message to user if they try and search an empty library
class NoBooks extends StatelessWidget {
  const NoBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('No Books To Search Yet!'),

      // Displays title and author of book to delete in dialog
      content: const Text('You have not added any books to your library yet.',
          style: TextStyle(fontSize: 18)),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Center(
            child: Text(
              'Go Back',
              style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
