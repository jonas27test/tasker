import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasker/state.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tasker/staticVariables.dart';

class DayModel extends ChangeNotifier {
  String dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime date = DateTime.now();
  num weightEvening;
  num weightMorning;
  num sleep;
  TextEditingController sleepController = new TextEditingController();
  TextEditingController wMorningController = new TextEditingController();
  TextEditingController wEveningController = new TextEditingController();
  List<TaskModel> purposeList = [];
  List<TaskModel> pleasureList = [];

  DayModel();

  void setVariable(String endpoint, TextEditingController c) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http.get(
        Statics.TASKER_URL +
            endpoint +
            '?date=' +
            dateString +
            '&value=' +
            c.text,
        headers: <String, String>{
          HttpHeaders.authorizationHeader:
              'bearer: ' + prefs.getString('bearer'),
        });
    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Failed to load' + endpoint);
    }
  }

  String getNewDate(int i) {
    DateTime current = DateTime.parse(dateString);
    date = current.add(Duration(days: i));
    return DateFormat('yyyy-MM-dd').format(date);
//    DateFormat('yyyy-MM-dd').format(
  }

  void setPurposeTaskName(int index, String name) {
    purposeList = listDeleteEmpty(purposeList);
    if (index + 1 > purposeList.length) {
      purposeList.add(new TaskModel(name, false));
    } else {
      purposeList[index].name = name;
    }
    postList(purposeList, "/setPurposeList");
    notifyListeners();
  }

  void setPleasureTaskName(int index, String name) {
    pleasureList = listDeleteEmpty(pleasureList);
    if (index + 1 > pleasureList.length) {
      pleasureList.add(new TaskModel(name, false));
    } else {
      pleasureList[index].name = name;
    }
    postList(pleasureList, "/setPleasureList");
    notifyListeners();
  }

  Future<http.Response> postList(List<TaskModel> list, String endpoint) async {
    String s = jsonEncode(list.map((e) => e.toJson()).toList());
    final prefs = await SharedPreferences.getInstance();
    return http.post(
      Statics.TASKER_URL + endpoint + '?date=' + dateString,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'bearer: ' + prefs.getString('bearer'),
      },
      body: s,
    );
  }


  void setPurposeTaskDone(int index) {
    purposeList[index].done = !purposeList[index].done;
    postList(purposeList, "/setPurposeList");
    notifyListeners();
  }

  void setPleasureTaskDone(int index) {
    pleasureList[index].done = !pleasureList[index].done;
    postList(pleasureList, "/setPleasureList");
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

  List<TaskModel> listDeleteEmpty(List<TaskModel> tasks) {
    for (var n = 0; n < tasks.length; n++) {
      if (tasks[n].name == "" || tasks[n].name == null) {
        tasks.remove(tasks[n]);
        n--;
      }
    }
    return tasks;
  }

  void setDay(DayModel d) {
    dateString = d.dateString;
    if (d.weightMorning != 0) {
      wMorningController.text = d.weightMorning.toString();
    }
    if (d.weightEvening != 0) {
      wEveningController.text = d.weightEvening.toString();
    }
    if (d.sleep != 0) {
      sleepController.text = d.sleep.toString();
    }
    if (d.purposeList != null) {
      purposeList = d.purposeList;
      d.purposeList.forEach((element) {
        element.controller.text = element.name;
      });
      listDeleteEmpty(purposeList);
    }
    if (d.pleasureList != null) {
      pleasureList = d.pleasureList;
      d.pleasureList.forEach((element) {
        element.controller.text = element.name;
      });
      listDeleteEmpty(pleasureList);
    }
    notifyListeners();
  }

  fetchDay(String date) async {
    final prefs = await SharedPreferences.getInstance();
    String bearer = prefs.getString('bearer');
    print(bearer);
    final response = await http
        .get(Statics.TASKER_URL + '/getDay?date=' + date, headers: {
      HttpHeaders.authorizationHeader: 'bearer: ' + prefs.getString('bearer')
    });
    if (response.statusCode == 200) {
      setDay(DayModel.fromJson(json.decode(response.body)));
      notifyListeners();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load day');
    }
  }

  void reset() {
    this.sleepController = new TextEditingController();
    this.sleep = 0;
    this.wEveningController = new TextEditingController();
    this.weightEvening = 0;
    this.wMorningController = new TextEditingController();
    this.weightMorning = 0;
    this.pleasureList = [];
    this.purposeList = [];
    this.dateString = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  DayModel.fromJson(Map<String, dynamic> json)
      : dateString = json['date'],
        sleep = json['sleep'],
        weightMorning = json['weightMorning'],
        weightEvening = json['weightEvening'],
        purposeList = new List<dynamic>.from(json['purposeList'])
            .map((i) => TaskModel.fromJson(i))
            .toList(),
        pleasureList = new List<dynamic>.from(json['pleasureList'])
            .map((i) => TaskModel.fromJson(i))
            .toList();

  Map<String, dynamic> toJson() => {
        'date': dateString,
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
  TextEditingController controller = new TextEditingController();

  TaskModel(String name, bool done) {
    this.name = name;
    this.done = done;
    this.controller.text = name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getName() {
    return this.name;
  }

  void setDone() {
    this.done = !this.done;
    notifyListeners();
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
