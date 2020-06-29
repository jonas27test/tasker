import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tasker/signinPage/userModel.dart';
import 'package:tasker/signinPage/signinInputs.dart';
import 'package:tasker/mainPage/taskPage.dart';
import 'package:tasker/mainPage/dayModel.dart';
import 'package:tasker/staticVariables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({
    Key key,
  }) : super(key: key);

  @override
  SigninPageState createState() => SigninPageState();
}

class SigninPageState extends State<SigninPage> {
  bool _visible = false;


  @override
  initState() {
    _retrieveToken();
  }

  _retrieveToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("bearer");
    if (token != null) {
      Provider.of<DayModel>(context, listen: false)
          .initDay(DateFormat('yyyy-MM-dd').format(DateTime.now()), context);
      if (Provider.of<DayModel>(context, listen: false) != null) {
        _gotoTaskPage();
      }
    } else {
      setState(() {
        _visible = true;
      });
    }
  }

  void _gotoTaskPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TaskPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: Statics.MAX_WIDTH),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24.0),
            child: Center(
              child: ListView(
//            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Container(
                      constraints: BoxConstraints(maxHeight: 520),
                      child: Image(image: AssetImage('assets/img/logo/logo.gif')),
//                          'assets/img/logo/tasker_logo_thick_trans.png')),
                    ),
                  ),
                  AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 1000),
                      child: SigninInputs()
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
