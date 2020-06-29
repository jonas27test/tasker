import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dayModel.dart';

class PSide extends StatefulWidget {
  const PSide({
    Key key,
    this.title = "",
    this.id,
  }) : super(key: key);

  final String title;
  final String id;

  @override
  _PSideState createState() => _PSideState();
}

class _PSideState extends State<PSide> {
  List<TaskModel> tasks;
  ScrollController _scrollController;
  List<String> options = ['Next Day', "Delete"];
  bool clicked = false;
  Function move;

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
              } else {
                Provider.of<DayModel>(context, listen: false)
                    .movePleasureItemNextDay(index);
              }
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
  void initState() {
    _scrollController = ScrollController();
    super.initState();
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
              return ReorderableListView(
                  scrollController: _scrollController,
                  onReorder: (oldIndex, newIndex) => {
                        setState(
                          () {
                            if (widget.id == 'pp') {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              final TaskModel item =
                                  day.purposeList.removeAt(oldIndex);
                              day.purposeList.insert(newIndex, item);
                              Provider.of<DayModel>(context, listen: false)
                                  .postList(day.purposeList, '/setPurposeList');
                            } else {
                              if (newIndex > oldIndex) {
                                newIndex -= 1;
                              }
                              final TaskModel item =
                                  day.pleasureList.removeAt(oldIndex);
                              day.pleasureList.insert(newIndex, item);
                              Provider.of<DayModel>(context, listen: false)
                                  .postList(
                                      day.pleasureList, '/setPleasureList');
                            }
                          },
                        ),
                      },
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                  children: List.generate(
                    tasks.length,
                    (index) {
                      return Row(
                        key: Key(tasks[index].name),
                          children: [
                            Expanded(
                              flex: 15,
                              child: GestureDetector(
                                onDoubleTap: () {
                                  if (widget.title == "Purpose") {
                                    day.setPurposeTaskDone(index);
                                  } else {
                                    day.setPleasureTaskDone(index);
                                  }
                                  WidgetsBinding
                                      .instance.focusManager.primaryFocus
                                      .unfocus();
                                },
                                child: TextField(
                                  onEditingComplete: () {
                                    WidgetsBinding
                                        .instance.focusManager.primaryFocus
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

//                            Container(
//                              width: 30,
//                              child: Center(
//                                child: GestureDetector(
//                                  onLongPress:() => {
//                                    null
//                                  },
//                                  onTapDown: (TapDownDetails details) {
//                                    _showPopupMenu(details.globalPosition);
//                                  },
//                                  child: IconButton(
//                                    icon: Icon(Icons.more_vert),
//                                  ),
//                                ),
//                              ),
//                            ),

                            Expanded(
                              flex: 4,
                              child: DropdownButton<String>(
                                elevation: 16,
                                isDense: true,
                                isExpanded: true,
                                underline: Text(''),
                                items: options.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Container(
                                      child: Text(item),
                                    ),
                                    onTap: () => {
                                      if (widget.id == 'pp')
                                        {
                                          if (item == 'Next Day')
                                            {
                                              day.movePurposeItemNextDay(index),
                                            },
                                          if (item == 'Delete') {
                                            day.purposeList.removeAt(index),
                                            day.postList(day.purposeList, '/setPurposeList'),
                                            setState((){})
                                          }
                                        },
                                      if (widget.id == 'pl')
                                        {
                                          if (item == 'Next Day')
                                            {
                                              day.movePleasureItemNextDay(
                                                  index),
                                            },
                                          if (item == 'Delete') {
                                            day.pleasureList.removeAt(index),
                                            day.postList(day.pleasureList, '/setPleasureList'),
                                            setState((){})
                                          }
                                        }
                                    },
                                  );
                                }).toList(),
                                onChanged: (_) {},
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                      );
                    },
                  ));
            }),
          ),
        ),
      ]),
    );
  }

//  _showPopupMenu(Offset position) async {
//    print(position.dx);
//    await showMenu(
//        context: context,
//        position: RelativeRect.fromLTRB(position.dx, position.dy, 100000, 0),
//        items: [
//          PopupMenuItem(child: Text('hallo')),
//        ]);
//  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final TaskModel item = tasks.removeAt(oldIndex);
        tasks.insert(newIndex, item);
      },
    );
    if (widget.id == 'pp') {
      Provider.of<DayModel>(context, listen: false)
          .postList(tasks, '/setPurposeList');
    } else {
      Provider.of<DayModel>(context, listen: false)
          .postList(tasks, '/setPleasureList');
    }
  }
}
