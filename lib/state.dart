import 'package:flutter/material.dart';

class SettingsModel extends ChangeNotifier{
  bool _splitView = false;

  SettingsModel();

  void setSplitView(bool splitView) {
    this._splitView = splitView;
  }

  bool getSplitView() {
    return this._splitView;
  }

 SettingsModel.fromJson(Map<String, dynamic> json)
  : _splitView = json['splitView'];
}

class DayModel extends ChangeNotifier {
  final String date;
  final double eveningWeight;
  final double morningWeight;
  final double sleep;
  final List<TaskModel> purposeList;
  final List<TaskModel> pleasureList;

  DayModel(this.date, this.eveningWeight, this.morningWeight, this.sleep, this.pleasureList, this.purposeList);

  DayModel.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        sleep = json['sleep'],
        morningWeight = json['morningWeight'],
        purposeList = json['puposeList'],
        pleasureList = json['pleasureList'],
        eveningWeight = json['eveningWeight'];

  Map<String, dynamic> toJson() =>
      {
        'date': date,
        'eveningWeight': eveningWeight,
        'morningWeight': morningWeight,
        'sleep': sleep,
        'purposeList': purposeList,
        'pleasureList': pleasureList,
      };
}

class TaskModel {
  String name;
  bool done;
  TextEditingController controller;

  TaskModel(String name, bool done) {
    this.name = name;
    this.done = done;
    this.controller = new TextEditingController(text: name);
  }

  TaskModel.fromJson(Map < String, dynamic > json)
      : name = json['name'],
        done = json['done'];

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'done': done,
      };

}