import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingsModel extends ChangeNotifier {
  bool _splitView = false;
  String user;
  TextEditingController userController = new TextEditingController();

  SettingsModel();

  void setUser(String user) {
    this.user = user;
    userController.text = user;
    notifyListeners();
  }

  String getUser(String user) {
    return this.user;
  }

  void setSplitView(bool splitView) {
    this._splitView = splitView;
    notifyListeners();
  }

  bool getSplitView() {
    return this._splitView;
  }

  SettingsModel.fromJson(Map<String, dynamic> json)
      : _splitView = json['splitView'];

  Map<String, dynamic> toJson() => {
        'splitView': _splitView,
      };
}

class DayModel extends ChangeNotifier {
  String date = DateFormat('dd.MM.yyyy').format(DateTime.now());
  double weightEvening;
  double weightMorning;
  double sleep;
  List<TaskModel> purposeList = [];
  List<TaskModel> pleasureList = [];

  DayModel();

  void setDay(DayModel d) {
    date = d.date;
    weightEvening = d.weightEvening;
    weightMorning = d.weightMorning;
    sleep = d.sleep;
    purposeList = d.purposeList;
    pleasureList = d.pleasureList;
    notifyListeners();
  }

  void setPurposeTaskName(int index, String name) {
    if (index + 1 > purposeList.length){
      purposeList.add(new TaskModel(name, false));
    } else {
      purposeList[index].name = name;
    }
    purposeList = listDeleteEmpty(purposeList);
    notifyListeners();
  }

  void setPleasureTaskName(int index, String name) {
    if (index + 1 > pleasureList.length){
      pleasureList.add(new TaskModel(name, false));
    } else {
      pleasureList[index].name = name;
    }
    pleasureList = listDeleteEmpty(pleasureList);
    notifyListeners();
  }

  List<TaskModel> getPurposeList() {
    List<TaskModel> list = this.purposeList.toList();
    list.add(new TaskModel("", false));
    return list;
  }

  List<TaskModel> getPleasureList() {
    List<TaskModel> list = this.pleasureList.toList();
    list.add(new TaskModel("", false));
    return list;
  }

  List<TaskModel> listDeleteEmpty(List<TaskModel> tasks){
    for (var n = 0; n < tasks.length; n++) {
      tasks[n].name = tasks[n].controller.text;
      if (tasks[n].name == "") {
        tasks.remove(tasks[n]);
        n--;
      }
    }
    return tasks;
  }

  Future<DayModel> fetchDay() async {

  }

  DayModel.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        sleep = json['sleep'],
        weightMorning = json['morningWeight'],
        purposeList = json['puposeList'],
        pleasureList = json['pleasureList'],
        weightEvening = json['eveningWeight'];

  Map<String, dynamic> toJson() => {
        'date': date,
        'eveningWeight': weightEvening,
        'morningWeight': weightMorning,
        'sleep': sleep,
        'purposeList': purposeList,
        'pleasureList': pleasureList,
      };
}

class TaskModel extends ChangeNotifier {
  String name;
  bool done;
  TextEditingController controller;

  TaskModel(String name, bool done) {
    this.name = name;
    this.done = done;
    this.controller = new TextEditingController(text: name);
  }

  void setName(String name) {
    this.name = name;
  }

  String getName() {
    return this.name;
  }

  void setDone(bool done) {
    this.done = done;
  }

  bool getDone() {
    return done;
  }

  TaskModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        done = json['done'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'done': done,
      };
}
//
//Future<http.Response> postTask(String title) {
//  return http.post(
//    'https://jsonplaceholder.typicode.com/albums',
//    headers: <String, String>{
//      'Content-Type': 'application/json; charset=UTF-8',
//    },
//    body: jsonEncode(<String, String>{
//      'title': title,
//    }),
//  );
//}
//
//Future<http.Response> fetchDay(String date) {
//  return http.post(
//    'https://jsonplaceholder.typicode.com/albums',
//    headers: <String, String>{
//      'Content-Type': 'application/json; charset=UTF-8',
//    },
//    body: jsonEncode(<String, String>{
//      'date': date,
//    }),
//  );
//}
