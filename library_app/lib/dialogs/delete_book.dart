import 'package:flutter/material.dart';

class DeleteAlert extends StatefulWidget {
  final String title;
  final String author;
  const DeleteAlert({Key? key, required this.title, required this.author})
      : super(key: key);
  @override
  State<DeleteAlert> createState() => _DeleteAlertState();
}

class _DeleteAlertState extends State<DeleteAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete This Book?'),

      // Displays title and author of book to delete in dialog
      content: Text('${widget.title}\n\nby:  ${widget.author}'),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () => Navigator.pop(context, 'CANCEL'),
          child: Center(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.red[900],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () => Navigator.pop(context, 'DELETED'),
          child: const Center(
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
