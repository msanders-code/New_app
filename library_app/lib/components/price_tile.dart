import 'package:flutter/material.dart';
import 'custom_icon.dart';
import 'dart:ui';

// Price list items
class PriceListTile extends StatefulWidget {
  final String storeTitle;
  final double bookPrice;
  final IconData storeIcon;

  const PriceListTile(
      {Key? key,
      required this.storeTitle,
      required this.bookPrice,
      required this.storeIcon})
      : super(key: key);

  @override
  // Initializes the state of each list tile on the price page
  State<PriceListTile> createState() => _PriceListTileState();
}

class _PriceListTileState extends State<PriceListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // Evenly distributes space between each widget and before and after
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        // Renders the input icon with CustomIcon class
        CustomIcon(namedIcon: widget.storeIcon),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.storeTitle,
              style: const TextStyle(color: Colors.black54, fontSize: 20),
            ),
            Text(
              // Renders the price with dollars and cents
              widget.bookPrice.toStringAsFixed(2),
              style: const TextStyle(
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                  fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}
