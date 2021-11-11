import 'package:flutter/material.dart';
import 'dart:ui';

// Price list items
class PriceListTile extends StatefulWidget {
  final String storeTitle;
  final double bookPrice;

  const PriceListTile({
    Key? key,
    required this.storeTitle,
    required this.bookPrice,
  }) : super(key: key);

  @override
  // Initializes the state of each list tile on the price page
  State<PriceListTile> createState() => _PriceListTileState();
}

class _PriceListTileState extends State<PriceListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // Evenly distributes space between each widget and before and after
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.ltr,
      children: <Widget>[
        Text(
          widget.storeTitle,
          style: const TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Text(
          // Renders the price with dollars and cents
          widget.bookPrice.toStringAsFixed(2),
          style: const TextStyle(
              color: Colors.black, fontStyle: FontStyle.italic, fontSize: 25),
        ),
      ],
    );
  }
}
