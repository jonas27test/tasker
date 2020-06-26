import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tasker/components/taskbar/drawerList.dart';
import 'package:tasker/recurringPage/recurringDialog.dart';
import 'package:tasker/recurringPage/recurringModel.dart';
import 'package:tasker/recurringPage/recurringPleasure.dart';
import 'package:tasker/recurringPage/recurringPurpose.dart';

class RecurringPage extends StatefulWidget {
  const RecurringPage({
    Key key,
  }) : super(key: key);

  @override
  _RecurringPageState createState() => _RecurringPageState();
}

class _RecurringPageState extends State<RecurringPage> {

  @override
  void initState() {
    Provider.of<RecurringModel>(context, listen: false)
        .fetchRecurring();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          title: Text('Recurrings')),
      drawer: Padding(
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
        child: Container(
          width: 250,
          child: Drawer(
            child: DrawerList(),
          ),
        ),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 850),
          child: PageView.builder(
            itemBuilder: (context, position) {
              if (position==0) {
                return RecurringPurpose();
              } else{
                return RecurringPleasure();
              }
    },
    itemCount: 2,
    ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8.0, 40),
        child: RecurringDialog(),
      ),
    );
  }
}
