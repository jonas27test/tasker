import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import './pSide.dart';
import './bottomBar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  static DateTime date = DateTime.now();
  static bool overwrite = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Tasker',
      home: Scaffold(
        appBar: AppBar(
            title: Center(child: Text(DateFormat('EEEE').format(date))),
            backgroundColor: Colors.redAccent,
            centerTitle: true,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
//                  '1.1.1111'
                    DateFormat('dd.MM.yyyy').format(date),
                ),
              ),
            ]),
        drawer: Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
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
              Expanded(
                flex: 10,
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
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
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
//              Expanded(
//                flex: 1,
//                child: Container(child: BottomBar()),
//              ),
              Container(child: BottomBar(), height: 50),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.fromLTRB(0,0,0,40.0),
          child: FloatingActionButton.extended(
            onPressed: () {
              overwrite = true;
            },
            label: Text('Done'),
            icon: Icon(Icons.edit),

            backgroundColor: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}