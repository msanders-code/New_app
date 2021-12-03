import 'package:flutter/material.dart';

// Dialog to print message to user if no valid image url is found
class NoCover extends StatelessWidget {
  const NoCover({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('No Cover Found!'),

      // Displays title and author of book to delete in dialog
      content: const Text('No cover art was found for this book.',
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
