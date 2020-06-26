import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dayModel.dart';

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

  Future<void> _dialog(context, String type, int index) async {
    return showDialog<void>(
      context: context,
//      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
          ),
//            title: Text('Move to next day'),
          content: FlatButton(
            child: Text(
              'Move to next day',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 26,
//                fontFamily: 'DancingScript',
              ),
            ),
            onPressed: () {
              print("move");
              Navigator.of(context).pop();
              if (type == 'pp') {
                Provider.of<DayModel>(context, listen: false)
                    .movePurposeItemNextDay(index);
              } else {}
            },
          ),
          actions: [
            FlatButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
            child: Consumer<DayModel>(builder: (context, day, child) {
              if (widget.title == "Purpose") {
                this.tasks = day.getPurposeList();
              } else {
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
                        onLongPress: () {
                          print('long-press');
                          if (widget.title == "Purpose") {
                            _dialog(context, 'pp', index);
                          } else {
                            _dialog(context, 'pl', index);
                          }
                        },
                        onDoubleTap: () {
                          print("double");
                          if (widget.title == "Purpose") {
                            day.setPurposeTaskDone(index);
                          } else {
                            day.setPleasureTaskDone(index);
                          }
//                          setState(() {});
                          WidgetsBinding.instance.focusManager.primaryFocus
                              .unfocus();
                        },
                        child: TextField(
//                          enabled: tasks[index].getDone() ? false : true,
                          onEditingComplete: () {
                            WidgetsBinding.instance.focusManager.primaryFocus
                                .unfocus();
                            if (widget.title == "Purpose") {
                              day.setPurposeTaskName(
                                  index, tasks[index].controller.text);
                            } else {
                              day.setPleasureTaskName(
                                  index, tasks[index].controller.text);
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
