import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/mainPage/pSide.dart';
import 'package:tasker/settingsPage/settingsModel.dart';

class TaskList extends StatefulWidget {
  const TaskList({
    Key key,
    this.date,
  }) : super(key: key);

  final String date;

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  String date;

  @override
  initState() {
    date = widget.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(builder: (context, settings, child) {
      if (!settings.getSplitView()) {
        return PageView.builder(
          itemBuilder: (context, position) {
            return _buildPagedView(position);
          },
          itemCount: 2,
        );
      } else {
        return Row(children: <Widget>[
          Expanded(
            flex: 50,
            child: Column(children: <Widget>[
              PSide(title: "Purpose",id: 'pp',),
            ]),
//                    ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
              child: Container(
                constraints: BoxConstraints(maxWidth: 1),
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 50,
            child: Column(children: <Widget>[
              PSide(
                title: "Pleasure", id: 'pl',
              ),
            ]),
          )
        ]);
      }
    });
  }

  _buildPagedView(int index) {
    if (index == 0) {
      return Row(
        children: [
          Expanded(
              flex: 100,
              child: Column(
                children: [
                  PSide(
                    title: "Purpose", id: 'pp',
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 40),
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
              padding: const EdgeInsets.fromLTRB(0, 80, 0, 40),
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
                    title: "Pleasure", id: 'pl',
                  ),
                ],
              )),
        ],
      );
    }
  }
}
