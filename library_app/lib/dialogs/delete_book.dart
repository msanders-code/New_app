import 'package:flutter/material.dart';

// Alert to notify user of deleting a book
class DeleteAlert extends StatelessWidget {
  final List<String> bookInfo;
  const DeleteAlert({Key? key, required this.bookInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete This Book?'),

      // Displays title and author of book to delete in dialog
      content: Text('${bookInfo[0]}\n\nby:  ${bookInfo[1]}',
          style: const TextStyle(fontSize: 18)),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () => Navigator.pop(context, 'CANCEL'),
          child: Center(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.red[900],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () => Navigator.pop(context, 'DELETE'),
          child: const Center(
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
