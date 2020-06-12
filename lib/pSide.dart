import 'package:flutter/material.dart';
import 'package:tasker/main.dart';

class PSide extends StatefulWidget {
  const PSide({
    Key key,
    this.title = "",
//    this.overwrite = false,
  }) : super(key: key);

  final String title;

//  final bool overwrite;

  @override
  _PSideState createState() => _PSideState();
}

class _PSideState extends State<PSide> {
  List<Task> tasks = [
    new Task("Jougle", false),
    new Task("Swim", false),
    new Task("Parkour", false),
    new Task("blaa", false),
    new Task("Flutter", true),
    new Task("", false),
  ];

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
              textDirection: TextDirection.ltr,
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

class Task {
  Task(String name, bool done) {
    this.name = name;
    this.done = done;
    this.controller = new TextEditingController(text: name);
  }

  String name;
  bool done;
  TextEditingController controller;
}
