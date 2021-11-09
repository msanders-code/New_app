import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Each home page list item
class BookListItem extends StatefulWidget {
  final String title, author;

  const BookListItem({Key? key, required this.title, required this.author})
      : super(key: key);
  @override
  // Initializes the state of the widget
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem> {
  String setImage = 'images/noImage.jpg'; // no-image placeholder image
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
                child: Image(
                  image: AssetImage(setImage),
                  width: 125,
                  height: 130,
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
                      widget.title,
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
                      widget.author,
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
                      onPressed: () => setState(() {
                            setImage = 'images/The_Hobbit_1.jpg';
                          }),
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
