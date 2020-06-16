import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/taskPage.dart';
import 'package:tasker/settingsPage.dart';
import 'package:tasker/state.dart';

class DrawerList extends StatefulWidget {
  const DrawerList({
    Key key,
    this.reload,
  }) : super(key: key);

  final Function reload;

  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  TaskPage taskPage;
  bool splitView = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: ListView(
        children: <Widget>[
          Consumer<SettingsModel>(builder: (context, settings, child) {
            return CheckboxListTile(
                title: const Text('Split View'),
                value: settings.getSplitView(),
                onChanged: (bool splitView) {
                  setState(() {
                    settings.setSplitView(splitView);
                  });
                });
          }),
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            child: Container(
              child: Text(
                'Settings',
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                style: TextStyle(
//                  fontWeight: FontWeight.bold,
                  fontSize: 16,
//                  fontFamily: 'DancingScript'
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
