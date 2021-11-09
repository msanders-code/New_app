import 'package:flutter/material.dart';

// Line separator for list items
class ListSeparator extends StatelessWidget {
  const ListSeparator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.indigo,
      thickness: 2,
    );
  }
}
