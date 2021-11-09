import 'package:flutter/material.dart';
import 'package:library_app/components/text_input_price_list.dart';

// Price Comparisson Page
class PriceComparisson extends StatefulWidget {
  final String title;

  const PriceComparisson({Key? key, required this.title}) : super(key: key);

  @override
  // Initializes state of the price comparisson page
  State<PriceComparisson> createState() => _PriceComparissonState();
}

class _PriceComparissonState extends State<PriceComparisson> {
  @override
  Widget build(BuildContext context) {
    // Returns the price comparisson page
    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Text(widget.title),
      ),
      // Will be just list of prices and the searched book info.
      body: const TextInputCompare(),
    );
  }
}
