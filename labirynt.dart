import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<List<int>> labirynt = [
    [10, 8, 10, 9],
    [28, 1, 0, 12],
    [12, 10, 9, 13],
    [6, 5, 6, 5]
  ];

  bool punkt_startowy_znaleziony = false;

  void odnajdzPozycjeStartowa() {
    for (int i = 0; i < labirynt.length; i++) {
      for (int j = 0; j < labirynt[i].length; j++) {
        if (labirynt[i][j] >= 16) {
          aktualnaPozycja[0] = i;
          aktualnaPozycja[1] = j;
          break;
        }
      }
    }

    print("Pozycja startowa to: [" +
        aktualnaPozycja[0].toString() +
        ", " +
        aktualnaPozycja[1].toString() +
        "]");

    labirynt[aktualnaPozycja[0]][aktualnaPozycja[1]] -= 16;
    punkt_startowy_znaleziony = true;
  }

  void wypiszAktualnaPozycja(){
    print(aktualnaPozycja[0].toString() + "," + aktualnaPozycja[1].toString());
  }

  bool isUpEnabled = false;
  bool isLeftEnabled = false;
  bool isRightEnabled = false;
  bool isDownEnabled = false;

  void sprawdzMozliweRuchy(){

    int aktualnaKomnata = labirynt[aktualnaPozycja[0]][aktualnaPozycja[1]];
    print("aktualna komnata to:" + aktualnaKomnata.toString());

    isUpEnabled = false;
    isLeftEnabled = false;
    isRightEnabled = false;
    isDownEnabled = false;

    if(aktualnaKomnata == 0){
      print("Wygrałeś!");
    }

    if(aktualnaKomnata >= 8){
      isDownEnabled = true;
      aktualnaKomnata -= 8;
    }
    if(aktualnaKomnata >= 4){
      isUpEnabled = true;
      aktualnaKomnata -= 4;
    }
    if(aktualnaKomnata >= 2){
      isRightEnabled = true;
      aktualnaKomnata -= 4;
    }
    if(aktualnaKomnata >= 1){
      isLeftEnabled = true;
      aktualnaKomnata -= 1;
    }
  }

  void moveUp(){
    if(aktualnaPozycja[0] > 0){
      setState(() {
        aktualnaPozycja[0] -= 1;
      });
      wypiszAktualnaPozycja();
      sprawdzMozliweRuchy();
    }
  }
  void moveDown(){
    if((labirynt.length - 1)> aktualnaPozycja[0]){
      setState(() {
        aktualnaPozycja[0] += 1;
      });
      wypiszAktualnaPozycja();
      sprawdzMozliweRuchy();
    }
  }
  void moveLeft(){
    if(aktualnaPozycja[1] > 0){
      setState(() {
        aktualnaPozycja[1] -= 1;
      });
      wypiszAktualnaPozycja();
      sprawdzMozliweRuchy();
    }
  }
  void moveRight(){
    if((labirynt[1].length - 1) > aktualnaPozycja[1]){
      setState(() {
        aktualnaPozycja[1] += 1;
      });
      wypiszAktualnaPozycja();
      sprawdzMozliweRuchy();
    }
  }

  List<int> aktualnaPozycja = [0, 0];

  void _pustaFunkcja() {
    // Pusta funkcja, nic nie robi
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!punkt_startowy_znaleziony){
      odnajdzPozycjeStartowa();
      sprawdzMozliweRuchy();
    }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(),
                      ElevatedButton(onPressed: null, child: Text("")),
                      ElevatedButton(onPressed: null, child: Text("")),
                      ElevatedButton(onPressed: null, child: Text("")),
                      ElevatedButton(onPressed: null, child: Text(""))
                    ],

                  ),
                  Row(

                  ),
                  Row(

                  ),
                  Row(

                  ),
                ],
              ),
            ),
            Text(
                "Znajdujesz się w: [" +
                    aktualnaPozycja[0].toString() +
                    ", " +
                    aktualnaPozycja[1].toString() +
                    "]"
            ),
            ElevatedButton(onPressed: isUpEnabled ? () => moveUp() : null, child: Icon(Icons.arrow_upward)),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(onPressed: isLeftEnabled ? () => moveLeft() : null, child: Icon(Icons.arrow_back)),
                  SizedBox(width: 10), // add a 20px space
                  ElevatedButton(onPressed: null, child: Icon(Icons.circle)),
                  SizedBox(width: 10), // add a 20px space
                  ElevatedButton(onPressed: isRightEnabled ? () => moveRight() : null, child: Icon(Icons.arrow_forward))
                ]
            ),
            ElevatedButton(onPressed: isDownEnabled ? () => moveDown() : null, child: Icon(Icons.arrow_downward)),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}