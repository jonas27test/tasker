import 'package:flutter/material.dart';

class PSide extends StatefulWidget {
  const PSide({
    Key key,
    this.title = "P",
  }) : super(key: key);

  final String title;

  @override
  _PSideState createState() => _PSideState();
}

class _PSideState extends State<PSide> {
  String text = "text";

  @override
  Widget build(BuildContext context) {
    List<String> s = ["Jougle", "Parkour", "Swimming", ""];
    List<TextEditingController> txt = new List();
    for (var item in s) {
      txt.add(TextEditingController(text: item));
    }
    return Expanded(
      flex: 1,
      child: Column(children: <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(2, 5, 2, 5)),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              widget.title,
              textDirection: TextDirection.ltr,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 46,
                  fontFamily: 'DancingScript'),
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: ListView.builder(
            itemCount: txt.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
//                  padding: EdgeInsets.all(0),
                padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
                child: Center(
                  child: TextField(
                    controller: txt[index],
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Enter a  new task'),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                        fontFamily: 'DancingScript'),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
