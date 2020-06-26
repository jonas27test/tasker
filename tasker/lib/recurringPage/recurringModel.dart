import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasker/mainPage/dayModel.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tasker/staticVariables.dart';

class RecurringModel extends ChangeNotifier {
  List<RecurringTask> recurringPleasure = [new RecurringTask("test", true, false, true, false, false, true,false)];
  List<RecurringTask> recurringPurpose = [];

  RecurringModel();

  addPurpose(String name, bool mon, bool tue, bool wed, bool thu, bool fri,
      bool sat, bool sun) {
    if (name != "" && !contains(recurringPurpose, name)) {
      recurringPurpose
          .add(new RecurringTask(name, mon, tue, wed, thu, fri, sat, sun));
    }
    postList(recurringPurpose, '/setRecurringPurpose');
    notifyListeners();
  }

  setPurpose(int index, RecurringTask t) {
    if (t.name == "") {
      recurringPurpose.removeAt(index);
    } else {
      recurringPurpose.replaceRange(index, index + 1, [t]);
    }
    postList(recurringPurpose, '/setRecurringPurpose');
    notifyListeners();
  }

  uploadPurpose() {
    postList(recurringPurpose, '/setRecurringPurpose');
  }

  void deletePurpose(int index) {
    recurringPurpose.removeAt(index);
    postList(recurringPurpose, '/setRecurringPurpose');
    notifyListeners();
  }

  addPleasure(String name, bool mon, bool tue, bool wed, bool thu, bool fri,
      bool sat, bool sun) {
    if (name != "" && !contains(recurringPleasure, name)) {
      recurringPleasure
          .add(new RecurringTask(name, mon, tue, wed, thu, fri, sat, sun));
    }
    postList(recurringPleasure, '/setRecurringPleasure');
    notifyListeners();
  }

  setPleasure(int index, RecurringTask t) {
    if (t.name == "") {
      recurringPleasure.removeAt(index);
    } else {
      recurringPleasure.replaceRange(index, index + 1, [t]);
    }
    postList(recurringPleasure, '/setRecurringPleasure');
    notifyListeners();
  }

  uploadPleasure() {
    postList(recurringPleasure, '/setRecurringPleasure');
  }

  void deletePleasure(int index) {
    recurringPleasure.removeAt(index);
    postList(recurringPleasure, '/setRecurringPleasure');
    notifyListeners();
  }

  bool contains(List<RecurringTask> list, String name) {
    list.forEach((element) {
      if (element.name == name) {
        return true;
      }
    });
    return false;
  }

  reset() {
    recurringPleasure = [];
    recurringPurpose = [];
  }

  Future<http.Response> postList(
      List<RecurringTask> list, String endpoint) async {
    String s = jsonEncode(list.map((e) => e.toJson()).toList());
    final prefs = await SharedPreferences.getInstance();
    return http.post(
      Statics.TASKER_URL + endpoint,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'bearer: ' + prefs.getString('bearer'),
      },
      body: s,
    );
  }

  Future<RecurringModel> fetchRecurring() async {
    final prefs = await SharedPreferences.getInstance();
    final response = await http
        .get(Statics.TASKER_URL + '/getRecurring', headers: {
      HttpHeaders.authorizationHeader: 'bearer: ' + prefs.getString('bearer')
    });
    if (response.statusCode == 200) {
      RecurringModel m = RecurringModel.fromJson(json.decode(response.body));
      this.recurringPurpose = m.recurringPurpose;
      this.recurringPleasure = m.recurringPleasure;
      notifyListeners();
      return m;
    } else {
      print(response.statusCode);
      throw Exception('Failed to fetch recurring');
    }
  }

  RecurringModel.fromJson(Map<String, dynamic> json)
      : recurringPurpose = new List<dynamic>.from(json['recurringPurpose'])
            .map((i) => RecurringTask.fromJson(i))
            .toList(),
        recurringPleasure = new List<dynamic>.from(json['recurringPleasure'])
            .map((i) => RecurringTask.fromJson(i))
            .toList();

  Map<String, dynamic> toJson() => {
        'recurringPurpose': recurringPurpose,
        'recurringPleasure': recurringPleasure,
      };
}

class RecurringTask extends ChangeNotifier {
  String name;
  bool mon = false;
  bool tue = false;
  bool wed = false;
  bool thu = false;
  bool fri = false;
  bool sat = false;
  bool sun = false;

  RecurringTask(this.name, this.mon, this.tue, this.wed, this.thu, this.fri,
      this.sat, this.sun);

  setMon(bool b) {
    this.mon = b;
    notifyListeners();
  }

  setTue(bool b) {
    this.tue = b;
    notifyListeners();
  }

  setWed(bool b) {
    this.wed = b;
    notifyListeners();
  }

  setThu(bool b) {
    this.thu = b;
    notifyListeners();
  }

  setFri(bool b) {
    this.fri = b;
    notifyListeners();
  }

  setSat(bool b) {
    this.sat = b;
    notifyListeners();
  }

  setSun(bool b) {
    this.sun = b;
    notifyListeners();
  }

  RecurringTask.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        mon = json['mon'],
        tue = json['tue'],
        wed = json['wed'],
        thu = json['thu'],
        fri = json['fri'],
        sat = json['sat'],
        sun = json['sun'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'mon': mon,
        'tue': tue,
        'wed': wed,
        'thu': thu,
        'fri': fri,
        'sat': sat,
        'sun': sun,
      };
}
