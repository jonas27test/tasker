import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tasker/signinPage/userModel.dart';
import 'package:tasker/mainPage/taskPage.dart';
import 'package:tasker/staticVariables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninInputs extends StatefulWidget {
  const SigninInputs({
    Key key,
  }) : super(key: key);

  @override
  SigninInputsState createState() => SigninInputsState();
}

class SigninInputsState extends State<SigninInputs> {
  TextEditingController emailController;
  TextEditingController passController;
  FocusNode passwordFocus;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  initState() {
    emailController = TextEditingController();
    passController = TextEditingController();
    passwordFocus = FocusNode();
  }

  void _gotoTaskPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TaskPage()),
    );
  }

  Future<void> _signup() async {
    if (emailController.text == "" || passController.text == "") {
      return _showDialog("Set Email and Password");
    }
    User u = new User(emailController.text, passController.text);
    final http.Response response = await http.post(
      Statics.AUTH_URL + '/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(u.toJson()),
    );
    if (response.statusCode == 201) {
      _showDialog("User created!");
    } else {
      _showDialog("Something went wrong.");
    }
  }

  Future<void> _signin() async {
    print(Statics.AUTH_URL + '/signin');
    if (emailController.text == "" || passController.text == "") {
      return _showDialog("Set Email and Password");
    }
    User u = new User(emailController.text, passController.text);
    final http.Response response = await http.post(
      Statics.AUTH_URL + '/signin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(u.toJson()),
    );
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('bearer', json.decode(response.body)['bearer']);
      _gotoTaskPage();
    } else {
      _showDialog("Something went wrong during login.");
    }
  }

  Future<void> _showDialog(String msg) async {
    return showDialog<void>(
      context: context,
//      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  TextField _textField(
      TextEditingController c, String hint, IconData icon, bool obscure) {
    return TextField(
      controller: c,
      obscureText: obscure,
      onSubmitted: (e) => {
        if (!obscure) {
          print('email field'),
          passwordFocus.requestFocus(),
        }
      },
      focusNode: obscure? passwordFocus : null,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        border: InputBorder.none,
        hintText: hint,
        filled: true,
        fillColor: Color(0xFFCFD8DC),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(200.0)),
          borderSide: BorderSide(color: Colors.transparent, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(200.0)),
          borderSide: BorderSide(color: Colors.transparent, width: 2),
        ),
      ),
      style: TextStyle(
        fontSize: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Color(0xFF90CAF9),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: _textField(
                emailController, "Enter Your Email...", Icons.email, false),

          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20.0),
            child: _textField(passController, "And Password", Icons.lock, true),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200.0),
                  side: BorderSide(color: Colors.transparent)),
              color: Color(0xFF42A5F5),
              textColor: Color(0xFF424242),
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.fromLTRB(30, 12, 30, 12.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                _signin();
              },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20.0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200.0),
                  side: BorderSide(color: Colors.transparent)),
              color: Colors.transparent,
              textColor: Color(0xFF42A5F5),
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(12.0),
              splashColor: Colors.blueAccent,
              onPressed: () {
                _signup();
              },
              child: Text(
                "Signup",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
