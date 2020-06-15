import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './day.dart';

class PSide extends StatefulWidget {
  const PSide({
    Key key,
    this.title = "",
//    this.overwrite = false,
  }) : super(key: key);

  final String title;


  @override
  _PSideState createState() => _PSideState();
}

class _PSideState extends State<PSide> {

  static DateTime date = DateTime.now();
  List<Task> tasks = [];

  Future<http.Response> postList(String title) {
    return http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
  }

  Future<http.Response> fetchDay(String date) {
    return http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'date': date,
      }),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(children: <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(2, 5, 2, 5)),
        Container(
          child: Center(
            child: Text(
              widget.title,
//              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 46,
                  fontFamily: 'DancingScript'),
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
//                  padding: EdgeInsets.all(0),
                  padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
                  child: Center(
                    child: GestureDetector(
                      onDoubleTap: () {
                        tasks[index].done
                            ? tasks[index].done = false
                            : tasks[index].done = true;
                        setState(() {
//                          TODO: send to db
                        });
                      },
                      child: TextField(
                        enabled: tasks[index].done ? false : true,
                        onEditingComplete: () {
                          WidgetsBinding.instance.focusManager.primaryFocus
                              ?.unfocus();
                          for (var n = 0; n < tasks.length; n++) {
                            tasks[n].name = tasks[n].controller.text;
                            print(tasks[n].name);
                            if (tasks[n].name == "") {
                              tasks.remove(tasks[n]);
                              n--;
                            }
                          }
                            tasks.add(new Task("", false));
                          setState(() {});
                          print(tasks.length);
                        },
                        controller: tasks[index].controller,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter a  new task'),
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 26,
                            fontFamily: 'DancingScript',
                            decorationThickness: 2,
                            decoration: tasks[index].done
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}


