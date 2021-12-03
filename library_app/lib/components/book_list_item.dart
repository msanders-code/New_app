import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:library_app/dialogs/delete_book.dart';
import 'package:library_app/dialogs/image_search_alert.dart';
import 'package:library_app/dialogs/no_cover_found.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstore/localstore.dart';

// Each home page list item
class BookListItem extends StatefulWidget {
  final List<Map<String, dynamic>> book;
  final List<dynamic> auxilary; // extra parameters
  final Localstore storage;

  const BookListItem({
    Key? key,
    required this.book,
    required this.auxilary,
    required this.storage,
  }) : super(key: key);
  @override
  // Initializes the state of the widget
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  Map<String, String> pricing = {};
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          // Distributes space evenly between widgets in the row
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            //Cover image placement
            SizedBox(
              child: FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                  widget.book[widget.auxilary[0]]['cover'],
                  width: 125,
                  height: 130,
                  scale: 0.8,
                ),
              ),
              width: 120,
              height: 125,
            ),
            // Box for title and author text in row
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 50, maxWidth: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.book[widget.auxilary[0]]['title'],
                      maxLines: 1,
                      // How to handle text overflow - want to change to scroll element
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.book[widget.auxilary[0]]['author'],
                      maxLines: 1,
                      // How to handle text overflow - want to change to scroll element
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  // Picture icon to request image from image service
                  child: IconButton(
                      onPressed: () async {
                        // Creates an object with data to turn into JSON string for searching
                        String choice = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ImageSearchAlert(
                              bookInfo: [
                                widget.book[widget.auxilary[0]]['title'],
                                widget.book[widget.auxilary[0]]['author'],
                              ],
                            );
                          },
                        );
                        // Replaces the current book cover image
                        if (choice == 'REPLACE') {
                          Map<String, String> data = {
                            'words': 'book, '
                                '${widget.book[widget.auxilary[0]]['title'].toLowerCase()}, '
                                'by ${widget.book[widget.auxilary[0]]['author'].toLowerCase()}',
                          };
                          // Turns data into JSON string
                          String searchTerms = jsonEncode(data);

                          // Makes a POST request to the image service
                          Uri url =
                              Uri.parse('http://10.0.2.2:5000/postmethod');
                          var response = await http.post(url,
                              body: jsonEncode(searchTerms),
                              headers: {'content-type': 'application/json'});
                          String newImage = response.body;
                          List<String> urlParts = newImage.split('/');

                          if (urlParts[urlParts.length - 1] ==
                              'Flag_Feedback.png') {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const NoCover();
                                });
                          } else {
                            widget.book[widget.auxilary[0]]['cover'] = newImage;

                            // Stores the new image with the selected book in database
                            widget.storage
                                .collection('books')
                                .doc(widget.book[widget.auxilary[0]]['id'])
                                .set(widget.book[widget.auxilary[0]]);

                            // Re-renders the list of books with updated cover
                            setState(() {
                              widget.auxilary[1](true, pricing);
                            });
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.photo_rounded,
                        color: Colors.pinkAccent,
                        size: 25,
                      )),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  // Trash icon to delete a book from the library
                  child: IconButton(
                      onPressed: () async {
                        String choice = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DeleteAlert(
                                bookInfo: [
                                  widget.book[widget.auxilary[0]]['title'],
                                  widget.book[widget.auxilary[0]]['author'],
                                ],
                              );
                            });
                        if (choice == 'DELETE') {
                          widget.storage
                              .collection('books')
                              .doc(widget.book[widget.auxilary[0]]['id'])
                              .delete();

                          setState(() {
                            widget.auxilary[1](true, pricing);
                          });
                        }
                      },
                      icon: const Icon(Icons.delete_rounded,
                          color: Colors.pinkAccent, size: 25)),
                ),
              ],
            ),
          ],
        ));
  }
}
