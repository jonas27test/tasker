import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key key,
    this.title = "P",
  }) : super(key: key);

  final String title;

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  String text = "text";

  @override
  Widget build(BuildContext context) {
    List<String> s = ["Jougle", "Parkour", "Swimming"];
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
//          child: Container(
//            color: Colors.red,
          child: ListView.builder(
            itemCount: txt.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
//                  padding: EdgeInsets.all(0),
                padding: EdgeInsets.fromLTRB(8, 0, 5, 0),

//                  child: Text(
//                    item,
//                    textAlign: TextAlign.center,
////                      overflow: TextOverflow.ellipsis,
//                    style: TextStyle(
//                        fontWeight: FontWeight.w900,
//                        fontSize: 26,
//                        fontFamily: 'DancingScript'),
//                  ),
                child: Center(
                  child: TextField(
                    controller: txt[index],
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Enter a  term'),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 26,
                        fontFamily: 'DancingScript'),
                  ),
                ),
              );
            },
          ),

//              for (var item in s)
//                Padding(
//                  padding: EdgeInsets.all(0),
////                  padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
//
////                  child: Text(
////                    item,
////                    textAlign: TextAlign.center,
//////                      overflow: TextOverflow.ellipsis,
////                    style: TextStyle(
////                        fontWeight: FontWeight.w900,
////                        fontSize: 26,
////                        fontFamily: 'DancingScript'),
////                  ),
//                  child: Center(
//                    child: TextField(
//                      decoration: InputDecoration(
//                          border: InputBorder.none, hintText: 'Enter a  term', te),
//                      style: TextStyle(
//                          fontWeight: FontWeight.w900,
//                          fontSize: 26,
//                          fontFamily: 'DancingScript'),
//                    ),
//                  ),
//                ),
        ),
      ]),
    );
  }
}
