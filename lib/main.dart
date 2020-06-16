import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './taskPage.dart';
import './state.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsModel()),
//        ChangeNotifierProvider(create: (context) => DayModel()),
      ],
      child: MyApp(),
    ),
  );
}

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
