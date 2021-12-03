import 'package:flutter/material.dart';

// Dialog to display results of a found book in the library
class SearchResultDialog extends StatelessWidget {
  final Map<String, dynamic> displayInfo;
  const SearchResultDialog({Key? key, required this.displayInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Search Results'),
      children: <Widget>[
        SimpleDialogOption(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Displays current cover art
              Image.network(
                displayInfo['cover'],
                height: 130,
                width: 125,
                scale: 0.8,
              ),
              Text(
                displayInfo['title'],
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              Text(displayInfo['author'],
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Clear',
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
