import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/mainPage/taskPage.dart';
import 'package:tasker/mainPage/dayModel.dart';
import 'package:tasker/signinPage/signinPage.dart';
import 'package:tasker/recurringPage/recurringPage.dart';
import 'package:tasker/recurringPage/recurringModel.dart';
import 'package:tasker/settingsPage/settingsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({
    Key key,
  }) : super(key: key);

  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  TaskPage taskPage;
  bool splitView = true;

  _logout() async {
    Provider.of<DayModel>(context, listen: false).reset();
    Provider.of<RecurringModel>(context, listen: false).reset();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('bearer', null);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SigninPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE0E0E0),
      child: ListView(
        children: <Widget>[
          Consumer<SettingsModel>(builder: (context, settings, child) {
            return CheckboxListTile(
                title: const Text('Split View', style: TextStyle(
                  fontSize: 18,
                ),),
                value: settings.getSplitView(),
                onChanged: (bool splitView) {
                  setState(() {
                    settings.setSplitView(splitView);
                  });
                });
          }),
          Consumer<SettingsModel>(builder: (context, settings, child) {
            return CheckboxListTile(
                title: const Text('Health Data', style: TextStyle(
                  fontSize: 18,
                ),),
                value: settings.health,
                onChanged: (bool health) {
                  setState(() {
                    settings.setHealth(health);
                  });
                });
          }),

          FlatButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TaskPage()),
              );
            },
            child: Container(
              child: Text(
                'Tasker',
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),


          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RecurringPage()),
              );
            },
            child: Container(
              child: Text(
                'Recurrings',
//                textDirection: TextDirection.ltr,
//                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          FlatButton(
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 18.0),
            ),
            onPressed: () {
              _logout();
            },
          ),
//          FlatButton(
//            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => SettingsPage()),
//              );
//            },
//            child: Container(
//              child: Text(
//                'Settings',
//                textDirection: TextDirection.ltr,
//                textAlign: TextAlign.left,
//                style: TextStyle(
////                  fontWeight: FontWeight.bold,
//                  fontSize: 16,
////                  fontFamily: 'DancingScript'
//                ),
//              ),
//            ),
//          ),
        ],
      ),
    );
  }
}
