import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './pSide.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flusdfsdftter',
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Center(child: Text('Monday')),
            backgroundColor: Colors.redAccent,
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "01.01.2020",
//                icon: const Icon(Icons.add_alert),
//                text: 'Show Snackbar',
                ),
              ),
            ]),
        drawer: Padding(
          padding: const EdgeInsets.fromLTRB(0,24,0,0),
          child: Drawer(
            child: Container(
              color: Colors.grey,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text("Ttem 1"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  ListTile(
                    title: Text("Item 2"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
//              Expanded(
//                flex: 1,
//                child: Container(
//                  child: Center(
//                    child: Padding(
//                      padding: const EdgeInsets.fromLTRB(0,15.0,0,0),
//                      child: Text(
//                        'hello katchi!',
//                        textDirection: TextDirection.ltr,
////                      textAlign: TextAlign.center,
//                        style: TextStyle(
//                          fontSize: 32,
//                          color: Colors.black,
//                        ),
//                      ),
//                    ),
//                  ),
//                  color: Colors.redAccent,
//                  constraints: BoxConstraints.expand(),
//                ),
//              ),
              Expanded(
                flex: 7,
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 50,
                    child: Column(children: <Widget>[
                      PSide(title: "Purpose"),
                    ]),
//                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 50,
                    child: Column(children: <Widget>[
                      PSide(
                        title: "Pleasure",
                      ),
                    ]),
                  ),
                ]),
              ),
              Text('Deliver featufres faster'),
              Text('Craft beautiful UIs'),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.contain, // otherwise the logo will be tiny
                  child: const FlutterLogo(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatefulWidget {
  @override
  MyButtonState createState() {
    return MyButtonState();
  }
}

class MyButtonState extends State<MyButton> {
  int counter = 0;
  List<String> strings = ['Flutter', 'is', 'cool', "and", "awesome!"];
  String displayedString = "Hello World!";

  void onPressOfButton() {
    setState(() {
      displayedString = strings[counter];
      counter = counter < 4 ? counter + 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful Widget"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(displayedString, style: TextStyle(fontSize: 40.0)),
              Padding(padding: EdgeInsets.all(10.0)),
              RaisedButton(
                child: Text(
                  "Press me",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
                onPressed: onPressOfButton,
              )
            ],
          ),
        ),
      ),
    );
  }
}
