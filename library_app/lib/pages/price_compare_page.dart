import 'package:flutter/material.dart';
import 'package:library_app/components/price_list.dart';

// Price Comparisson Page
class PriceComparisson extends StatefulWidget {
  final String title;
  final Map<String, String> priceData;
  const PriceComparisson(
      {Key? key, required this.title, required this.priceData})
      : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: PriceList(priceData: widget.priceData),
      ),
    );
  }
}
