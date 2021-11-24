import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:library_app/models/book.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// Each home page list item
class BookListItem extends StatefulWidget {
  final List<Book> book;
  final int index;

  const BookListItem({
    Key? key,
    required this.book,
    required this.index,
  }) : super(key: key);
  @override
  // Initializes the state of the widget
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  int stackIndex = 0;

  // Image variable initilized with a no-image placeholder
  String setImage =
      'https://th.bing.com/th/id/R.855e8ca01684f0d61e302ba09a177bfd?rik=TbKuqNR1U%2bV6Iw&riu=http%3a%2f%2ffremontgurdwara.org%2fwp-content%2fuploads%2f2020%2f06%2fno-image-icon-2.png&ehk=piUctuaeByVRg5s2YCzOsXApik4AfjUmmzMKA1cPKEs%3d&risl=&pid=ImgRaw&r=0&sres=1&sresct=1'; // no-image placeholder image

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
                  setImage,
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
                      widget.book[widget.index].title,
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
                      widget.book[widget.index].author,
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
                        Map<String, String> data = {
                          'words': 'book, '
                              '${widget.book[widget.index].title.toLowerCase()}, '
                              'by ${widget.book[widget.index].author.toLowerCase()}',
                        };
                        // Turns data into JSON string
                        var searchTerms = jsonEncode(data);
                        // Makes a POST request to the image service
                        Uri url = Uri.parse('http://10.0.2.2:5000/postmethod');
                        var response = await http.post(url,
                            body: jsonEncode(searchTerms),
                            headers: {'content-type': 'application/json'});
                        String newImage = response.body;

                        // If image url is not valid, resend request
                        if (newImage == '/sa/simg/Flag_Feedback.png') {
                          var response = await http.post(url,
                              body: jsonEncode(searchTerms),
                              headers: {'content-type': 'application/json'});
                          String newImage = response.body;
                          setState(() {
                            setImage = newImage;
                          });
                        } else {
                          setState(() {
                            setImage = newImage;
                          });
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
                      onPressed: () {},
                      icon: const Icon(Icons.delete_rounded,
                          color: Colors.pinkAccent, size: 25)),
                ),
              ],
            ),
          ],
        ));
  }
}
