import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasker/settingsPage/settingsModel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key key,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<SettingsModel>(builder: (context, settings, child) {
          return ListView(
            children: <Widget>[
              CheckboxListTile(
                  title: const Text('Split View'),
                  value: settings.getSplitView(),
                  onChanged: (bool splitView) {
                    setState(() {
                      settings.setSplitView(splitView);
                    });
                  }),
              TextField(
                controller: settings.userController,
                textAlign: TextAlign.center,
                onSubmitted: (name) {
                  settings.setUser(name);
                },
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'user name'),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
