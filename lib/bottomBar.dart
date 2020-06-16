import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import './state.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  static double sleep = 0;
  static double weightMorning = 0;
  static double weightEvening = 0;
//  static String user =
//  static DateTime date = DateTime.now();
  TextEditingController sController =
      new TextEditingController(text: sleep.toString());
  TextEditingController wMorningController =
      new TextEditingController(text: weightMorning.toString());
  TextEditingController wEveningController =
      new TextEditingController(text: weightEvening.toString());


//  _BottomBarState

  @override
  void initState() {
    super.initState();
  }

  setSleep(double data) async {
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final response = await http.get('http://10.0.2.2:8080/setSleep?date=2020-01-01&user=joe&sleep=8.0');
    if (response.statusCode == 200) {
      throw Exception('Failed to load album');
    }
  }

  setWeightEvening(double data) async {
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final response = await http.get('http://10.0.2.2:8080/setEveningSleep?date=2020-01-01&user=joe&sleep=8.0');
    if (response.statusCode == 200) {
      throw Exception('Failed to load album');
    }
  }

//  Future<Day> postData(String api, Body body) async {
//    final response = await http.post(
//      'http://0.0.0.0:8080/setWeightEvening',
//      headers: <String, String>{
//        'Content-Type': 'application/json; charset=UTF-8',
//      },
//      body: jsonEncode(<String, String>{
//        'body': jsonEncode(body)
//      }),
//    );
//    if (response.statusCode == 200) {
//      // If the server did return a 200 OK response,
//      // then parse the JSON.
//      return Day.fromJson(json.decode(response.body));
//    } else {
//      // If the server did not return a 200 OK response,
//      // then throw an exception.
//      throw Exception('Failed to load album');
//    }
//  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    sController.dispose();
    wMorningController.dispose();
    wEveningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double FONT_SIZE = 20;
    const String FONT_NAME = 'DancingScript';
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: TextField(
//                      controller: sController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Weight Morning'),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: FONT_SIZE,
                        fontFamily: FONT_NAME),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: TextField(
                    textAlign: TextAlign.center,
//                      controller: sController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sleep',
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: FONT_SIZE,
                        fontFamily: FONT_NAME),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: TextField(
//                      controller: sController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onSubmitted: (weightEvening) {
                      setWeightEvening(double.parse(weightEvening));
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Weight Evening'),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: FONT_SIZE,
                        fontFamily: FONT_NAME),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
