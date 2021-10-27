import 'dart:ui';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Enabled page routing by refactoring app to have state
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

// App state to enable navigation
class _MyAppState extends State<MyApp> {
  bool isHome = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Navigator(
          pages: [
            MaterialPage(
              child: MyHomePage(
                title: 'Personal Library',
                setHomeScreen: (screenValue) {
                  setState(() {
                    isHome = screenValue;
                  });
                },
              ),
            ),
            if (isHome == false) const MaterialPage(child: PriceComparisson())
          ],
          onPopPage: (route, result) {
            bool popStatus = route.didPop(result);
            if (popStatus == true) {
              isHome = true;
            }
            return isHome;
          }),
    );
  }
}

// The home page of the application.
class MyHomePage extends StatefulWidget {
  final String title;
  final Function setHomeScreen;

  const MyHomePage({Key? key, required this.title, required this.setHomeScreen})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // Returns the home page
    return Scaffold(
      appBar: AppBar(
        primary: true,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.library_add),
            iconSize: 25,
          ),
          // Route to price comparisson page
          IconButton(
            onPressed: () => setState(() {
              _PriceComparissonState;
              widget.setHomeScreen(false);
            }),
            icon: const Icon(Icons.attach_money),
            iconSize: 25,
          ),
          // Opens a search bar on current screen to search book list
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            iconSize: 25,
          )
        ],
      ),
      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  const Placeholder(
                    color: Colors.orange,
                    fallbackHeight: 120,
                    fallbackWidth: 120,
                  ),
                  Container(
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Book Title #${index + 1}',
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              'Author #${index + 1}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400),
                            ),
                          ]),
                    ),
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(18),
                  ),
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.photo_rounded,
                              color: Colors.pinkAccent,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete_rounded,
                                color: Colors.pinkAccent, size: 30)),
                      ],
                    ),
                  ),
                ],
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.indigo,
            thickness: 2,
          );
        },
      ),
    );
  }
}

// Price Comparisson Page
class PriceComparisson extends StatefulWidget {
  const PriceComparisson({Key? key}) : super(key: key);

  @override
  State<PriceComparisson> createState() => _PriceComparissonState();
}

class _PriceComparissonState extends State<PriceComparisson> {
  @override
  Widget build(BuildContext context) {
    // Returns the price comparisson page
    return Scaffold(
        appBar: AppBar(
          primary: true,
          title: const Text('Price Comparisson Page'),
        ),
        body: const TextInputCompare());
  }
}

//Text input and retailer list.
class TextInputCompare extends StatefulWidget {
  const TextInputCompare({Key? key}) : super(key: key);
  @override
  _TextInputCompare createState() => _TextInputCompare();
}

class _TextInputCompare extends State<TextInputCompare> {
  final TextEditingController _controller = TextEditingController(
    text: '',
  );
  String _value = ''; // Used to store value from user input

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: _controller,
                      decoration: InputDecoration(
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
                  onPressed: () {
                    setState(() {
                      _value = _controller.text;
                    });
                  },
                  child: const Text('Compare Prices'),
                ),
              ],
            ),
            padding: const EdgeInsets.all(3)),
        const ListTile(
          title: Text(
            'AMAZON.COM',
            style: TextStyle(color: Colors.black54, fontSize: 20),
          ),
          subtitle: Text(
            '\$ -',
            style: TextStyle(
                color: Colors.black54,
                fontStyle: FontStyle.italic,
                fontSize: 18),
          ),
          leading:
              Icon(LineAwesomeIcons.amazon, color: Colors.black87, size: 40),
          selected: true,
        ),
        const Divider(color: Colors.indigo, thickness: 2),
        const ListTile(
          title: Text(
            'AUDIBLE.COM',
            style: TextStyle(color: Colors.black54, fontSize: 20),
          ),
          subtitle: Text(
            '\$ -',
            style: TextStyle(
                color: Colors.black54,
                fontStyle: FontStyle.italic,
                fontSize: 18),
          ),
          leading: Icon(
            LineAwesomeIcons.audible,
            color: Colors.black87,
            size: 40,
          ),
          selected: true,
        ),
        const Divider(color: Colors.indigo, thickness: 2),
      ],
    );
  }
}
