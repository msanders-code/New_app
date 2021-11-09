import 'package:flutter/material.dart';

// Used to add an icon from an outside library
class CustomIcon extends StatelessWidget {
  final IconData namedIcon; // Variable to hold the input icon to render

  const CustomIcon({Key? key, required this.namedIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      namedIcon,
      color: Colors.black87,
      size: 40,
    );
  }
}
