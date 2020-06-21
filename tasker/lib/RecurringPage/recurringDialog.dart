import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/mainPage/pSide.dart';
import 'package:tasker/settingsPage/settingsModel.dart';

class RecurringDialog {
  static Future<void> recurringDialog(BuildContext ctx) async {
    return showDialog<void>(
      context: ctx,
      barrierDismissible: false, // user must tap button!
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
//
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter the task name'),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                    fontFamily: 'DancingScript',
                  ),
                ),
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
      },
    );
  }
}
