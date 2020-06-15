import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import './taskList.dart';
import './drawerList.dart';
import './bottomBar.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({
    Key key,
  }) : super(key: key);


  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {

  static DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text(DateFormat('EEEE').format(date))),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
//                  '1.1.1111'
                DateFormat('dd.MM.yyyy').format(date),
              ),
            ),
          ]),
      drawer: Padding(
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
        child: Drawer(
          child: DrawerList(reload: this.setState,),
//          child: DrawerList(reload: this.setState,),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: TaskList(),
            ),
//              Expanded(
//                flex: 1,
//                child: Container(child: BottomBar()),
//              ),
            Container(child: BottomBar(), height: 50),
          ],
        ),
      ),
    );
  }
}
