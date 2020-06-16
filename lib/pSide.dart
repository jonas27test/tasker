import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import './state.dart';
import 'package:provider/provider.dart';

class PSide extends StatefulWidget {
  const PSide({
    Key key,
    this.title = "",
    this.tasks,
//    this.overwrite = false,
  }) : super(key: key);

  final String title;
  final List<TaskModel> tasks;

  @override
  _PSideState createState() => _PSideState();
}

class _PSideState extends State<PSide> {
  List<TaskModel> tasks;

//  @override
//  initState(){
//    tasks = widget.tasks;
//    super.initState();
//  }

  prepareList() {
    if (tasks == null) {
      tasks = [];
    }
    for (var n = 0; n < tasks.length; n++) {
      tasks[n].name = tasks[n].controller.text;
//      print(this.tasks[n].name);
      if (tasks[n].name == "") {
        tasks.remove(tasks[n]);
        n--;
      }
    }
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
            child: Consumer<DayModel>(builder: (context, day, child) {
              if (widget.title == "Purpose" ){
                this.tasks = day.getPurposeList();
              }else {
                this.tasks = day.getPleasureList();
              }
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
//                  padding: EdgeInsets.all(0),
                    padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
                    child: Center(
                      child: GestureDetector(
                        onDoubleTap: () {
                          tasks[index].getDone()
                              ? tasks[index].setDone(false)
                              : tasks[index].setDone(true);
                        },
                        child: TextField(
                          enabled: tasks[index].getDone() ? false : true,
                          onEditingComplete: () {
                            WidgetsBinding.instance.focusManager.primaryFocus
                                ?.unfocus();
                            if(widget.title == "Purpose"){
                              day.setPurposeTaskName(index, tasks[index].controller.text);
                            }else {
                              day.setPleasureTaskName(index, tasks[index].controller.text);
                            }
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
              );
            }),
          ),
        ),
      ]),
    );
  }
}
