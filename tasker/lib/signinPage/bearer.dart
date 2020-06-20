import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class Bearer  {
  String bearer;

  Bearer();

  void setBearer(String bearer) {
    this.bearer = bearer;
  }

  void getBearer() {
    this.bearer = bearer;
  }

  Bearer.fromJson(Map<String, dynamic> json)
      : bearer = json['bearer'];

  Map<String, dynamic> toJson() => {
    'bearer': bearer,
  };
}