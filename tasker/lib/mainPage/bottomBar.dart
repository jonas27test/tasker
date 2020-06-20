import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../state.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key key,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
//    sleepController.dispose();
//    wMorningController.dispose();
//    wEveningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double FONT_SIZE = 20;
    const String FONT_NAME = 'DancingScript';
    return Consumer<DayModel>(builder: (context, day, child) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: TextField(
                    controller: day.wMorningController,
                    onEditingComplete: (){day.setVariable('/setWeightMorning',day.wMorningController);},
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
                    controller: day.sleepController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Sleep',
                    ),
                    onEditingComplete: (){day.setVariable('/setSleep',day.sleepController);},
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
                      controller: day.wEveningController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onEditingComplete: (){day.setVariable('/setWeightEvning',day.wEveningController);},
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
    );});
  }
}
