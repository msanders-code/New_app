import 'package:flutter/material.dart';
import 'list_separator.dart';
import 'price_tile.dart';

// Retailer list with prices.
class PriceList extends StatefulWidget {
  final Map<String, String> priceData;
  const PriceList({Key? key, required this.priceData}) : super(key: key);
  @override
  // Initializes the price list
  State<PriceList> createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  List<String> stores = [
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

  @override
  Widget build(BuildContext context) {
    // Builds the list of retailers on the page
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return PriceListTile(
          storeTitle: stores[index],

          // Casting map value explicitly to string
          bookPrice: '${widget.priceData[stores[index]]}',
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const ListSeparator();
      },
      itemCount: widget.priceData.length,
    );
  }
}
