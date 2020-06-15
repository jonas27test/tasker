import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pSide.dart';

class TaskList extends StatefulWidget {
  const TaskList({
    Key key,
  }) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool minimized;
  bool splitView = true;
  int flexSize;

  _loadSplitView() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool splitView = prefs.getBool('splitView');
    if (splitView!=null){
      this.splitView = splitView;
    }
  }

  _buildPage(int index) {
    if (index == 0) {
      return Row(
        children: [
          Expanded(
              flex: 100,
              child: Column(
                children: [
                  PSide(
                    title: "Purpose",
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,80,0,40),
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 20,
            child: RotatedBox(
              quarterTurns: 3,
              child: const Text(
                "Pleasure",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 46,
                    fontFamily: 'DancingScript'),
              ),
            ),
          ),
        ],
      );
    } else if (index == 1) {
      return Row(
        children: [
          Expanded(
            flex: 20,
            child: RotatedBox(
              quarterTurns: 3,
              child: const Text(
                "Purpose",
                textDirection: TextDirection.ltr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 46,
                    fontFamily: 'DancingScript'),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,80,0,40),
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
              flex: 100,
              child: Column(
                children: [
                  PSide(
                    title: "Pleasure",
                  ),
                ],
              )),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadSplitView();
    print(splitView);
    if (splitView) {
      return PageView.builder(
        itemBuilder: (context, position) {
          return _buildPage(position);
        },
        itemCount: 2,
      );
    } else {
      return Row(children: <Widget>[
        Expanded(
          flex: 50,
          child: Column(children: <Widget>[
            PSide(title: "Purpose"),
          ]),
//                    ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
            child: Container(
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          flex: 50,
          child: Column(children: <Widget>[
            PSide(
              title: "Pleasure",
            ),
          ]),
        )
      ]);
    }
  }
}
