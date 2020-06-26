import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/signinPage/signinPage.dart';
import 'package:tasker/mainPage/dayModel.dart';
import 'package:tasker/staticVariables.dart';
import 'package:tasker/settingsPage/settingsModel.dart';
import 'package:tasker/recurringPage/recurringModel.dart';

void main() {
  print('Auth is at: ' + Statics.AUTH_URL);
  print('Backend is at: ' + Statics.TASKER_URL);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsModel()),
        ChangeNotifierProvider(create: (context) => DayModel()),
        ChangeNotifierProvider(create: (context) => RecurringModel()),
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
      home: SigninPage(),
//      home: TaskPage(),
    );
  }
}
