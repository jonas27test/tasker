import 'package:flutter/material.dart';
import './taskPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Tasker',
//      theme: new ThemeData(
//        primarySwatch: Colors.blue,
//      ),
      home: TaskPage(),
    );
  }
}
