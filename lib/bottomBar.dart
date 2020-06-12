import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  static double sleep = 0;
  static double weightMorning = 0;
  static double weightEvening = 0;
  TextEditingController sController =
      new TextEditingController(text: sleep.toString());
  TextEditingController wMorningController =
      new TextEditingController(text: weightMorning.toString());
  TextEditingController wEveningController =
      new TextEditingController(text: weightEvening.toString());

  @override
  void initState() {
    super.initState();

    sController.addListener(_svalue);
  }

  _svalue() {
    print("hallo");
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    sController.dispose();
    wMorningController.dispose();
    wEveningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double FONT_SIZE = 20;
    const String FONT_NAME = 'DancingScript';
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: TextField(
//                      controller: sController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Weight Morning'),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: FONT_SIZE,
                        fontFamily: FONT_NAME),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: TextField(
                    textAlign: TextAlign.center,
//                      controller: sController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sleep',
                    ),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: FONT_SIZE,
                        fontFamily: FONT_NAME),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: TextField(
//                      controller: sController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: 'Weight Evening'),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: FONT_SIZE,
                        fontFamily: FONT_NAME),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
