import 'package:flutter/material.dart';
import 'dart:math';
import 'package:expressions/expressions.dart';

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
  String rownanie = '';
  bool _wyswietlaWynik = false;

  void _dodajDoRownania(String value) {
    //jesli wyswietla wynik i nacisnieta jest cyfra to wyzeruj rownanie
    if (_wyswietlaWynik && (value == '0' || value == '1' || value == '2' || value == '3' || value == '4' || value == '5' || value == '6' || value == '7' || value == '8' || value == '9')) {
      setState(() {
        rownanie = '';
        _wyswietlaWynik = false;
      });
    }
    _wyswietlaWynik = false;

    // sprawdz czy nie jest to znak równa się
    if (value == '=') {
      _oblicz();
      return;
    }
    // sprawdz czy nie jest to znak C
    if (value == 'C') {
      setState(() {
        rownanie = '';
      });
      return;
    }

    // sprawdz czy uzyto przycisku Num, jesli tak to uzyj pow do obliczenia
    if (value == 'Num') {
      setState(() {
        rownanie += 'pow(';
      });
      return;
    }

    //sprawdz czy ostatnim znakiem nie jest . lub znak działania matematycznego
    if (rownanie != '' && (value == '.' || value == '+' || value == '-' || value == '*' || value == '/')) {
      String ostatniZnak = rownanie.substring(rownanie.length - 1);
      if (ostatniZnak == '.' || ostatniZnak == '+' || ostatniZnak == '-' || ostatniZnak == '*' || ostatniZnak == '/') {
        return;
      }
    }

    setState(() {
      rownanie += value;
    });
  }

  void _oblicz() {
    setState(() {
      try {
        setState(() {
          rownanie = eval(rownanie).toString();
          _wyswietlaWynik = true;
        });
        // rownanie = eval(rownanie).toString();
      } catch (e) {
        rownanie = 'Error';
      //  display e in console
        print(e);
      }
    });
  }

  num eval(String expression) {
    Expression exp = Expression.parse(expression);

    var context = {
      "x": pi / 5,
      "cos": cos,
      "sin": sin,
      "Num": pow
    };

// Evaluate expression
    final evaluator = const ExpressionEvaluator();
    var r = evaluator.eval(exp, context);
    // print(r);
    return r;
  }

  Widget _buildButton(String text) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 5),
      height: (MediaQuery.of(context).size.width / 5),
      child: ElevatedButton(
        onPressed: () {_dodajDoRownania(text);},
        style: ElevatedButton.styleFrom(
          primary: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90), // zaokrąglenie ro/ dodanie obramowania
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 22
          ),
        ),
      ),
    );
  }

  Widget _buildBigButton(String text) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 5),
      height: (MediaQuery.of(context).size.width / 5) * 2,
      child: ElevatedButton(
        onPressed: () {_dodajDoRownania(text);},
        style: ElevatedButton.styleFrom(
          primary: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60), // zaokrąglenie ro/ dodanie obramowania
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22
          ),
        ),
      ),
    );
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
    double szerokoscInterfejsu = (MediaQuery.of(context).size.width - 20);
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
            SizedBox(
              width: szerokoscInterfejsu,
              child: Center(
                child: TextField(
                  controller: TextEditingController(text: rownanie),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Wprowadź równanie',
                      contentPadding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      )
                    )
                  ),
                ),
              )
            ),
          SizedBox(
            width: szerokoscInterfejsu,
            child: Row(
              children: [
                SizedBox(
                  width: (szerokoscInterfejsu/4) * 3,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          _buildButton('Num'),
                          Spacer(),
                          _buildButton('/'),
                          Spacer(),
                          _buildButton('*'),
                          Spacer(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          _buildButton('7'),
                          Spacer(),
                          _buildButton('8'),
                          Spacer(),
                          _buildButton('9'),
                          Spacer(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          _buildButton('4'),
                          Spacer(),
                          _buildButton('5'),
                          Spacer(),
                          _buildButton('6'),
                          Spacer(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          _buildButton('1'),
                          Spacer(),
                          _buildButton('2'),
                          Spacer(),
                          _buildButton('3'),
                          Spacer(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Spacer(),
                          _buildButton('C'),
                          Spacer(),
                          _buildButton('0'),
                          Spacer(),
                          _buildButton('.'),
                          Spacer(),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: (szerokoscInterfejsu/4),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildButton('-')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBigButton('+')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBigButton('=')
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
