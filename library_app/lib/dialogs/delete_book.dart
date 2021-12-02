import 'package:flutter/material.dart';

class DeleteAlert extends StatefulWidget {
  final List<String> bookInfo;
  const DeleteAlert({Key? key, required this.bookInfo}) : super(key: key);

  @override
  State<DeleteAlert> createState() => _DeleteAlertState();
}

class _DeleteAlertState extends State<DeleteAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete This Book?'),

      // Displays title and author of book to delete in dialog
      content: Text('${widget.bookInfo[0]}\n\nby:  ${widget.bookInfo[1]}'),
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
          onPressed: () => Navigator.pop(context, 'DELETE'),
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
