import 'package:flutter/material.dart';

class Day {
  final String date;
  final double eveningWeight;
  final double morningWeight;
  final double sleep;
  List<Task> purposeList;
  List<Task> pleasureList;

  Day(this.date, this.eveningWeight, this.morningWeight, this.sleep, this.pleasureList, this.purposeList);
}

class Task {
  Task(String name, bool done) {
    this.name = name;
    this.done = done;
    this.controller = new TextEditingController(text: name);
  }

  String name;
  bool done;
  TextEditingController controller;
}