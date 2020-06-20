import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'taskList.dart';
import '../components/taskbar/drawerList.dart';
import 'bottomBar.dart';
import 'package:tasker/state.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({
    Key key,
  }) : super(key: key);

  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  DateTime currentBackPressTime;

  static DateTime date = DateTime.now();

  @override
  initState() {
    Provider.of<DayModel>(context, listen: false)
        .fetchDay(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  Future<bool> _onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Center(child: Consumer<DayModel>(builder: (context, day, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white70),
                  color: Colors.white,
                  onPressed: () => day.fetchDay(day.getNewDate(-1)),
                ),
                Text(DateFormat('EEEE').format(day.date)),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white70),
                  color: Colors.white,
                  onPressed: () => day.fetchDay(day.getNewDate(1)),
                ),
              ],
            );
          })),
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
          child: DrawerList(
            reload: this.setState,
          ),
//          child: DrawerList(reload: this.setState,),
        ),
      ),
      body: WillPopScope(
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TaskList(date: DateFormat('yyyy-MM-dd').format(date)),
              ),
//              Expanded(
//                flex: 1,
//                child: Container(child: BottomBar()),
//              ),
              Container(child: BottomBar(), height: 50),
            ],
          ),
        ),
        onWillPop: _onWillPop,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(8,8,8.0,40),
        child: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: Text('Add'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.redAccent,
        ),
      ),
    );
  }
}
