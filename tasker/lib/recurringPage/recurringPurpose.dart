import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tasker/components/taskbar/drawerList.dart';
import 'package:tasker/recurringPage/recurringDialog.dart';
import 'package:tasker/recurringPage/recurringModel.dart';

class RecurringPurpose extends StatefulWidget {
  const RecurringPurpose({
    Key key,
  }) : super(key: key);

  @override
  _RecurringPurposeState createState() => _RecurringPurposeState();
}

class _RecurringPurposeState extends State<RecurringPurpose> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'Purpose',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 46,
                fontFamily: 'DancingScript'),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
          child: Consumer<RecurringModel>(builder: (context, rec, child) {
            return ListView.builder(
              itemCount: rec.recurringPurpose.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
//                  padding: EdgeInsets.all(0),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Card(
                    child: Column(
//                          mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onDoubleTap: () {
//                            rec.deletePurpose(index);
                                  WidgetsBinding.instance.focusManager.primaryFocus
                                      .unfocus();
                                },
                                child: Text(
                                  rec.recurringPurpose[index].name,
//                            rec.PurposeList[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 26,
                                    fontFamily: 'DancingScript',
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8,8,20,8.0),
                              child: IconButton(
                                onPressed:() => {
                                  rec.deletePurpose(index),
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 8, 30, 8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Container(
                              width: 20,
                              height: 2,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  RecurringTask t = rec.recurringPurpose[index];
                                  t.mon = !t.mon;
                                  rec.setPurpose(index,t);
                                  setState(() {});
                                },
                                child: Opacity(
                                    opacity: rec.recurringPurpose[index].mon
                                        ? 1.0
                                        : 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 2.0,
                                      ),
                                      child: new Text(
                                        'Mon',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  RecurringTask t = rec.recurringPurpose[index];
                                  t.tue = !t.tue;
                                  rec.setPurpose(index,t);
                                  setState(() {});
                                },
                                child: Opacity(
                                    opacity: rec.recurringPurpose[index].tue
                                        ? 1.0
                                        : 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 2.0,
                                      ),
                                      child: new Text(
                                        'Tue',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  RecurringTask t = rec.recurringPurpose[index];
                                  t.wed = !t.wed;
                                  rec.setPurpose(index,t);
                                  setState(() {});
                                },
                                child: Opacity(
                                    opacity: rec.recurringPurpose[index].wed
                                        ? 1.0
                                        : 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 2.0,
                                      ),
                                      child: new Text(
                                        'Wed',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  RecurringTask t = rec.recurringPurpose[index];
                                  t.thu = !t.thu;
                                  rec.setPurpose(index,t);
                                  setState(() {});
                                },
                                child: Opacity(
                                    opacity: rec.recurringPurpose[index].thu
                                        ? 1.0
                                        : 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 2.0,
                                      ),
                                      child: new Text(
                                        'Thu',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  RecurringTask t = rec.recurringPurpose[index];
                                  t.fri = !t.fri;
                                  rec.setPurpose(index,t);
                                  setState(() {});
                                },
                                child: Opacity(
                                    opacity: rec.recurringPurpose[index].fri
                                        ? 1.0
                                        : 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 2.0,
                                      ),
                                      child: new Text(
                                        'Fri',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  RecurringTask t = rec.recurringPurpose[index];
                                  t.sat = !t.sat;
                                  rec.setPurpose(index,t);
                                  setState(() {});
                                },
                                child: Opacity(
                                    opacity: rec.recurringPurpose[index].sat
                                        ? 1.0
                                        : 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 2.0,
                                      ),
                                      child: new Text(
                                        'Sat',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  RecurringTask t = rec.recurringPurpose[index];
                                  t.sun = !t.sun;
                                  rec.setPurpose(index,t);
                                  setState(() {});
                                },
                                child: Opacity(
                                    opacity: rec.recurringPurpose[index].sun
                                        ? 1.0
                                        : 0.2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 2.0,
                                      ),
                                      child: new Text(
                                        'Sun',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    ]);

  }
}
