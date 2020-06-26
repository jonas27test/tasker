import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/mainPage/pSide.dart';
import 'package:tasker/recurringPage/recurringModel.dart';

class RecurringDialog extends StatefulWidget {
  const RecurringDialog({
    Key key,
  }) : super(key: key);

  @override
  _RecurringDialogState createState() => _RecurringDialogState();
}

class _RecurringDialogState extends State<RecurringDialog> {
  bool mon = false;
  bool tue = false;
  bool wed = false;
  bool thu = false;
  bool fri = false;
  bool sat = false;
  bool sun = false;
  final nameController = TextEditingController();

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
                    controller: nameController,
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
                      Column(
                        children: [
                          StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return Checkbox(
                                    value: mon,
                                    onChanged: (bool value) {
                                      mon = value;
                                      setState(() {
                                      });
                                    });
                              }),
                          Text('Mon'),
                        ],
                      ),
                      Column(
                        children: [
                          StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return Checkbox(
                                    value: tue,
                                    onChanged: (bool value) {
                                      tue = value;
                                      setState(() {
                                      });
                                    });
                              }),
                          Text('Tue'),
                        ],
                      ),
                      Column(
                        children: [
                          StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return Checkbox(
                                    value: wed,
                                    onChanged: (bool value) {
                                      wed = value;
                                      setState(() {
                                      });
                                    });
                              }),
                          Text('Wed'),
                        ],
                      ),
                      Column(
                        children: [
                          StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return Checkbox(
                                    value: thu,
                                    onChanged: (bool value) {
                                      thu = value;
                                      setState(() {
                                      });
                                    });
                              }),
                          Text('Thu'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return Checkbox(
                                    value: fri,
                                    onChanged: (bool value) {
                                      fri = value;
                                      setState(() {
                                      });
                                    });
                              }),
                          Text('Fri'),
                        ],
                      ),
                      Column(
                        children: [
                          StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return Checkbox(
                                    value: sat,
                                    onChanged: (bool value) {
                                      sat = value;
                                      setState(() {
                                      });
                                    });
                              }),
                          Text('Sat'),
                        ],
                      ),
                      Column(
                        children: [
                          StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return Checkbox(
                                    value: sun,
                                    onChanged: (bool value) {
                                      sun = value;
                                      setState(() {
                                      });
                                    });
                              }),
                          Text('Sun'),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[
                FlatButton(
                  child: Text('Purpose'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Provider.of<RecurringModel>(context, listen: false).addPurpose(nameController.text, mon, tue, wed, thu, fri, sat, sun);
                    reset();
                  },
                ),
                FlatButton(
                  child: Text('Pleasure'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Provider.of<RecurringModel>(context, listen: false).addPleasure(nameController.text, mon, tue, wed, thu, fri, sat, sun);
                    reset();
                  },
                ),
            ],
          );
        });
  }

  reset(){
    nameController.text = "";
    mon = false;
    tue = false;
    wed = false;
    thu = false;
    fri = false;
    sat = false;
    sun = false;
  }

}
