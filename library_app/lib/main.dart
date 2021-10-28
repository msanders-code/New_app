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
  bool comparePrice = false;
  bool selectCover = false;

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
                setScreen: (homeScreen, priceScreen, imageScreen) {
                  setState(() {
                    isHome = homeScreen;
                    comparePrice = priceScreen;
                    selectCover = imageScreen;
                  });
                },
              ),
            ),
            if (comparePrice == true)
              const MaterialPage(
                  child: PriceComparisson(
                title: 'Compare Book Prices',
              )),
            if (selectCover == true)
              const MaterialPage(
                  child: BookCovers(title: 'Select A Book Cover')),
          ],
          onPopPage: (route, result) {
            bool popStatus = route.didPop(result);
            if (popStatus == true) {
              comparePrice = false;
              selectCover = false;
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
  final Function setScreen;

  const MyHomePage({Key? key, required this.title, required this.setScreen})
      : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> titles = [
    'The Hobbit',
    '1984',
    'My Antonia',
    'Atlas Shrugged',
    'Hood'
  ];
  List<String> authors = [
    'J.R.R. Tolkein',
    'George Orwell',
    'Willa Cather',
    'Ayn Rand',
    'Stephen R. Lawhead'
  ];
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
              widget.setScreen(false, true, false);
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
                  const Card(
                    child: Image(
                      image: AssetImage('images/noImage.jpg'),
                      width: 120,
                      height: 120,
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(titles[index],
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text(
                              authors[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ]),
                    ),
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(12),
                  ),
                  Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                            onPressed: () => setState(() {
                                  _BookCoversState;
                                  widget.setScreen(false, false, true);
                                }),
                            icon: const Icon(
                              Icons.photo_rounded,
                              color: Colors.pinkAccent,
                              size: 25,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete_rounded,
                                color: Colors.pinkAccent, size: 25)),
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
  final String title;

  const PriceComparisson({Key? key, required this.title}) : super(key: key);

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
        title: Text(widget.title),
      ),
      body: const TextInputCompare(),
    );
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
  String _firstValue = '0.00'; // Used to store value from user input
  String _secondValue = '0.00';

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
                      enableInteractiveSelection: true,
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
                      if (_controller.text ==
                          'Harry Potter and The Sorcerer\'s Stone') {
                        _firstValue = '14.99';
                        _secondValue = '0.00  with a subscription';
                      } else {
                        _firstValue = '0.00';
                        _secondValue = '0.00';
                      }
                    });
                  },
                  child: const Text('Compare Prices'),
                ),
              ],
            ),
            padding: const EdgeInsets.all(3)),
        ListTile(
          title: const Text(
            'AMAZON.COM',
            style: TextStyle(color: Colors.black54, fontSize: 20),
          ),
          subtitle: Text(
            '\$$_firstValue',
            style: const TextStyle(
                color: Colors.black54,
                fontStyle: FontStyle.italic,
                fontSize: 18),
          ),
          leading: const Icon(LineAwesomeIcons.amazon,
              color: Colors.black87, size: 40),
          selected: true,
        ),
        const Divider(color: Colors.indigo, thickness: 2),
        ListTile(
          title: const Text(
            'AUDIBLE.COM',
            style: TextStyle(color: Colors.black54, fontSize: 20),
          ),
          subtitle: Text(
            '\$$_secondValue',
            style: const TextStyle(
                color: Colors.black54,
                fontStyle: FontStyle.italic,
                fontSize: 18),
          ),
          leading: const Icon(
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

// Widget to see a grid of book cover selections

class BookCovers extends StatefulWidget {
  final String title;
  const BookCovers({Key? key, required this.title}) : super(key: key);

  @override
  _BookCoversState createState() => _BookCoversState();
}

class _BookCoversState extends State<BookCovers> {
  List<Widget> image = const [
    Image(
        image: AssetImage('images/The_Hobbit_1.jpg'), width: 100, height: 100),
    Image(
        image: AssetImage('images/The-Hobbit_2.jpg'), width: 100, height: 100),
    Image(
        image: AssetImage('images/The_Hobbit_3.jpg'), width: 100, height: 100),
    Image(
        image: AssetImage('images/The_Hobbit_4.jpg'), width: 100, height: 100),
    Image(
        image: AssetImage('images/The-Hobbit_5.jpg'), width: 100, height: 100),
    Image(
        image: AssetImage('images/The_Hobbit_6.jpg'), width: 100, height: 100),
    Image(
        image: AssetImage('images/The_Hobbit_7.jpg'), width: 100, height: 100),
    Image(
        image: AssetImage('images/The_Hobbit_8.jpg'), width: 100, height: 100),
    Image(image: AssetImage('images/The_Hobbit_9.jpg'), width: 100, height: 100)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        primary: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: GridView.count(
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          crossAxisCount: 3,
          children: List.generate(image.length, (int index) {
            return Card(child: image[index]);
          }),
        ),
      ),
    );
  }
}
