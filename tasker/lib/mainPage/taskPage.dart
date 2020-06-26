import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:tasker/settingsPage/settingsModel.dart';
import 'taskList.dart';
import 'package:tasker/components/taskbar/drawerList.dart';
import 'bottomBar.dart';
import 'package:tasker/recurringPage/recurringDialog.dart';
import 'package:tasker/staticVariables.dart';
import 'package:tasker/mainPage/dayModel.dart';

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
        .initDay(DateFormat('yyyy-MM-dd').format(DateTime.now()), context);
//    Provider.of<DayModel>(context, listen: false)
//        .fetchDay(DateFormat('yyyy-MM-dd').format(DateTime.now()));
//    Provider.of<DayModel>(context, listen: false).addRecurring(Provider.of<RecurringModel>(context, listen: false).fetchRecurring());
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
          title: Center(child: Container(
            child: Consumer<DayModel>(builder: (context, day, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,
                        color: Colors.white70, size: 20),
                    color: Colors.white,
                    onPressed: () => day.initDay(day.getNewDate(-1), context),
                  ),
                  Text(DateFormat('EEEE').format(day.date)),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        color: Colors.white70, size: 20),
                    color: Colors.white,
                    onPressed: () => day.initDay(day.getNewDate(1), context),
                  ),
                ],
              );
            }),
          )),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Center(
                child: Consumer<DayModel>(builder: (context, day, child) {
                  return Text(
                    DateFormat('dd.MM.yyyy').format(day.date),
                  );
                }),
              ),
            ),
          ]),
      drawer: Padding(
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
        child: Container(
          width: 250,
          child: Drawer(
            child: DrawerList(),
          ),
        ),
      ),
      body: WillPopScope(
        child: Center(
          child: Container(
              constraints: BoxConstraints(maxWidth: Statics.MAX_WIDTH),
              child: Column(
                  children: <Widget>[
              Expanded(
              child: TaskList(date: DateFormat('yyyy-MM-dd').format(date)),
        ),
        Consumer<SettingsModel>(builder: (context, settings, child) {
          return settings.health
              ? Container(child: BottomBar(), height: 50)
              : Container();
        }),
          ],
        ),
      ),
    ),onWillPop
    :
    _onWillPop
    ,
    )
    ,
    );
  }
}
