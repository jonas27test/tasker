import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state.dart';

class PSide extends StatefulWidget {
  const PSide({
    Key key,
    this.title = "",
  }) : super(key: key);

  final String title;

  @override
  _PSideState createState() => _PSideState();
}

class _PSideState extends State<PSide> {
  List<TaskModel> tasks;

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
