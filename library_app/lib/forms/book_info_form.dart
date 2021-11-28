import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'dart:convert';

// Book information entry form
class BookInfoForm extends StatefulWidget {
  final Function setScreen; // Variable used for navigating between pages
  const BookInfoForm({Key? key, required this.setScreen}) : super(key: key);
  @override
  State<BookInfoForm> createState() => _BookInfoFormState();
}

class _BookInfoFormState extends State<BookInfoForm> {
  final GlobalKey<FormFieldState<String>> _titleFormFieldKey = GlobalKey();
  final GlobalKey<FormFieldState<String>> _authorFormFieldKey = GlobalKey();
  var client = http.Client();
  List<String> sellers = [
    'Amazon.com',
    'SecondSale',
    'Biblio.com',
    'AbeBooks',
    'eBay',
    'Alibris',
    'ValoreBooks.com',
    'Blackwell',
    'Booksrun'
  ];

  // Map variable to store price info from the HTTP request
  Map<String, String> info = {
    'Amazon.com': 'Not Found',
    'SecondSale': 'Not Found',
    'Biblio.com': 'Not Found',
    'AbeBooks': 'Not Found',
    'eBay': 'Not Found',
    'Alibris': 'Not Found',
    'ValoreBooks.com': 'Not Found',
    'Blackwell': 'Not Found',
    'Booksrun': 'Not Found'
  };

  // Saves the entered values from the form
  get _value => ({
        'title': _titleFormFieldKey.currentState?.value,
        'author': _authorFormFieldKey.currentState?.value
      });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: <Widget>[
        // Form field to enter the book's title
        TextFormField(
            autofocus: true,
            key: _titleFormFieldKey,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Title is required.';
              } else {
                return null;
              }
            }),
        // Form field to enter the book's author
        TextFormField(
            key: _authorFormFieldKey,
            decoration: const InputDecoration(labelText: 'Author'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Author is required.';
              } else {
                return null;
              }
            }),
        Builder(
          builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // Submit button - makes a network request for price info
                OutlinedButton(
                    onPressed: () async {
                      if (_titleFormFieldKey.currentState!.validate() &&
                          _authorFormFieldKey.currentState!.validate()) {
                        // Sends an HTTP request to the price finding service
                        try {
                          var url = Uri.parse(
                              'http://10.0.2.2:5000/?title=${_value['title']}&author=${_value['author']}');
                          var response = await client.get(url);

                          // Parses the HTML page and creates a dart object with the data
                          if (response.statusCode == 200) {
                            var document = parse(response.body);
                            dynamic data = jsonDecode(document
                                .getElementsByTagName('p')[0]
                                .innerHtml);

                            // Finds prices for every seller from the HTTP request
                            for (final seller in sellers) {
                              for (int index = 0;
                                  index < data.length;
                                  index++) {
                                if (seller == data[index]['seller'] &&
                                    info[seller] == 'Not Found') {
                                  info[seller] = data[index]['price'];
                                }
                              }
                            }
                          } else {
                            throw Exception();
                          }
                        } finally {
                          print(info); // Temp
                          client.close();

                          // Navigates to the price listing screen
                          setState(() {
                            widget.setScreen(false, true, info);
                          });

                          Navigator.pop(context, 'SUCESSFUL');
                        }
                      }
                    },
                    child: const Center(
                        child: Text('Submit',
                            style: TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold)))),
                // Cancel button - exits the form and resets the values
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, 'CANCEL');
                    },
                    child: Center(
                        child: Text('Cancel',
                            style: TextStyle(
                                color: Colors.red[900],
                                fontWeight: FontWeight.bold)))),
              ],
            );
          },
        )
      ],
    ));
  }
}
