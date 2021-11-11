import 'package:flutter/material.dart';
import 'list_separator.dart';
import 'price_tile.dart';

// Retailer list with prices.
class PriceList extends StatefulWidget {
  const PriceList({Key? key}) : super(key: key);
  @override
  // Initializes the price list
  State<PriceList> createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  // Watches for the text input and records it
  /*
  final TextEditingController _controller = TextEditingController(
    text: '',
  );
  */
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
  List<double> prices = [0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00];

  @override
  Widget build(BuildContext context) {
    // Builds the list of retailers on the page
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return PriceListTile(
          storeTitle: stores[index],
          bookPrice: prices[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const ListSeparator();
      },
      itemCount: stores.length,
    );
  }
}
