import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/mainPage/pSide.dart';
import 'package:tasker/settingsPage/settingsModel.dart';

class RecurringDialog extends StatefulWidget {
  final Widget child;

  const RecurringDialog({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  _RecurringDialogState createState() => _RecurringDialogState();
}

class _RecurringDialogState extends State<RecurringDialog> {
  bool mon = false;
  bool _tue = false;
  bool _wed = false;
  bool _thu = false;
  bool _fri = false;
  bool _sat = false;
  bool _sun = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        _recurringDialog(setState);
      },
      label: Text('Add'),
      icon: Icon(Icons.add),
      backgroundColor: Colors.redAccent,
    );
  }

  Future<void> _recurringDialog(setState) async {
    return showDialog<void>(
        context: context,
//      barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
            ),
            title: Text(
              'New Recurring Task',
//            style: TextStyle(
//              fontWeight: FontWeight.w900,
//              fontSize: 26,
//              fontFamily: 'DancingScript',
//            ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter the task name'),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                      fontFamily: 'DancingScript',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dayCheck("Mon", setState),
                      _dayCheck("Tue", setState),
                      _dayCheck("Wed", setState),
                      _dayCheck("Thu", setState),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _dayCheck("Fri", setState),
                      _dayCheck("Sat", setState),
                      _dayCheck("Sun", setState),
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Create'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

//
  _dayCheck(String day, setState) {
    return Center(
      child: Column(
        children: [
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Checkbox(
                value: mon,
                onChanged: (bool value) {
                  setState(() {
                    mon = value;
                  });
                });
          }),
          Text(day),
        ],
      ),
    );
  }
}
