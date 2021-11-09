import 'package:flutter/material.dart';
import 'list_separator.dart';
import 'price_tile.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

// Retailer list with prices.
class TextInputCompare extends StatefulWidget {
  const TextInputCompare({Key? key}) : super(key: key);
  @override
  // Initializes the price list
  State<TextInputCompare> createState() => _TextInputCompareState();
}

class _TextInputCompareState extends State<TextInputCompare> {
  // Watches for the text input and records it
  final TextEditingController _controller = TextEditingController(
    text: '',
  );
  List<String> stores = ['amazon.com', 'audible.com'];
  List<double> prices = [0.00, 0.00];
  List<IconData> packIcons = [
    LineAwesomeIcons.amazon,
    LineAwesomeIcons.audible
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            child: Row(
              // Evenly distributes the space around each widget in the row
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: TextField(
                      autofocus: true,
                      enableInteractiveSelection: true,
                      controller: _controller,
                      decoration: InputDecoration(

                          // Adds shopping cart icon in front of the input blank
                          prefixIcon: const Icon(Icons.shopping_cart_rounded,
                              color: Colors.pinkAccent),
                          hintText: 'Input title for prices',
                          enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(color: Colors.indigo),
                          )),
                    ),
                    flex: 2),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Compare Prices'),
                ),
              ],
            ),
            padding: const EdgeInsets.all(15)),

        // Builds the list of retailers on the page
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return PriceListTile(
                storeTitle: stores[index],
                bookPrice: prices[index],
                storeIcon: packIcons[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return const ListSeparator();
          },
          itemCount: stores.length,
        ),
      ],
    );
  }
}
