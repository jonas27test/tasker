import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasker/mainPage/dayModel.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tasker/staticVariables.dart';

class SettingsModel extends ChangeNotifier {
  bool _splitView = false;
  TextEditingController userController = new TextEditingController();

  SettingsModel();

  void setUser(String user) {
    userController.text = user;
    notifyListeners();
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