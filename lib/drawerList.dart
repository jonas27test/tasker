import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './taskPage.dart';

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

  _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool splitView = prefs.getBool('splitView');
    if (splitView != null) {
      this.splitView = splitView;
    }
  }

  _saveSplitView(bool splitView) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('splitView', splitView);
    widget.reload(() {

    });
  }

  _buildSplitView() {
    if (this.splitView) {
      return ListTile(
        title: Text("Split View"),
        trailing: Icon(Icons.check_box),
      );
    }
    return ListTile(
      title: Text("Split View"),
      trailing: Icon(Icons.check_box_outline_blank),
    );
  }

  _SecondRoute() {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _SecondRoute()),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _loadSettings();
    return Container(
      color: Colors.white70,
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              splitView ? splitView = false : splitView = true;
              _saveSplitView(splitView);
              setState(() {});
            },
            child: _buildSplitView(),
          ),
          FlatButton(
            onPressed: () {
              _saveSplitView(false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => _SecondRoute()),
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
