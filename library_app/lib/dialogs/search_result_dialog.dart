import 'package:flutter/material.dart';
//import 'package:library_app/forms/book_form.dart';

// Dialog to search current library for specified book
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
                      fontSize: 12)),
              OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Clear')),
            ],
          ),
        )
      ],
    );
  }
}
