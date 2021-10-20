import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Your Personal Library'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of the application.

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Returns the home page and a navigation menu
    return Scaffold(
        appBar: AppBar(
          primary: true,
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.attach_money)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        ),
        body: const Center(
          child: Text('This is where the book list will be.'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.library_add),
          backgroundColor: Colors.pinkAccent,
        ));
  }
}
