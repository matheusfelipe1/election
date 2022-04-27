// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Winner extends StatefulWidget {
  const Winner({Key? key}) : super(key: key);

  @override
  State<Winner> createState() => _WinnerState();
}

class _WinnerState extends State<Winner> {
  DateTime dateToday = DateTime.now();
  DateTime date = DateTime.now();
  DateTime dateFirst = DateTime.parse('2022-01-01 00:00:00.000');
  DateTime dateLast = DateTime.parse('2022-12-31 00:00:00.000');
  DateTime dateCalc = DateTime.parse('2022-05-05T00:00:00Z');
  Duration myDuration = Duration(days: 5);
  double percent = 0;
  late Timer timer;
  bool counting = false;
  bool segurado = false;
  bool prog = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  updateTime() {
    final reduceSecondsBy = 1;
    if (mounted)
      setState(() {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          timer.cancel();
        } else {
          myDuration = Duration(seconds: seconds);
        }
      });
  }

  start(DateTime req) {
    if (mounted)
      setState(() {
        var difference = req.difference(date).inDays;
        myDuration = Duration(days: difference);
      });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seconds = myDuration.inSeconds.remainder(60);
    final days = myDuration.inDays;
    // Step 7
    final hours = myDuration.inHours.remainder(24);
    final minutes = myDuration.inMinutes.remainder(60);
    Size size = MediaQuery.of(context).size;
    return Container(
      child: counting
          ? Column(
              children: [
                SizedBox(
                  height: size.height * .1,
                ),
                Text('Tempo restante para o anúncio dos vencedores.',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 15)),
                SizedBox(
                  height: size.height * .05,
                ),
                Center(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.15,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text("$days",
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 30)),
                          ),
                        ),
                        Text("  dias e  ",
                            style: const TextStyle(
                                fontFamily: 'Poppins', color: Colors.black)),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.15,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text("$hours",
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 30)),
                          ),
                        ),
                        Text('  :  '),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.15,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text("$minutes",
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 30)),
                          ),
                        ),
                        Text('  :  '),
                        Container(
                          height: size.height * 0.08,
                          width: size.width * 0.15,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text("$seconds",
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 30)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .1,
                ),
                Divider(),
                SizedBox(
                  height: size.height * .1,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Anúncie agora mesmo os vencedores',
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 15)),
                      SizedBox(
                        width: size.width * .03,
                      ),
                      Icon(FontAwesomeIcons.arrowDown)
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .03,
                ),
                Container(
                  child: HoldTimeoutDetector(
                    onTimeout: () {
                      percent = 1;
                      print('end2');
                      setState(() {
                        segurado = true;
                      });
                    },
                    onTimerInitiated: () {
                      percent = 0.93;
                      print('end3');
                    },
                    onCancel: () {
                      if (!segurado) percent = 0.0;
                      print('end4');
                    },
                    holdTimeout: Duration(milliseconds: 3000),
                    enableHapticFeedback: true,
                    child: CircularPercentIndicator(
                      radius: 93,
                      animation: true,
                      reverse: true,
                      animationDuration: 1000,
                      progressColor: Colors.green,
                      percent: percent,
                      center: Icon(
                        Icons.check,
                        size: !segurado ? 30 : 45,
                        color: segurado ? Colors.green : Colors.grey,
                      ),
                    ),
                  ),
                )
              ],
            )
          : Column(
              children: [
                SizedBox(
                  height: size.height * .1,
                ),
                // counting
                //     ? Text("$days dias e $hours:$minutes:$seconds",
                //         style: const TextStyle(
                //             fontFamily: 'Poppins', color: Colors.black))
                //     : Container(),
                Text('Selecione uma data para o fim das votações.',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 15)),
                SizedBox(
                  height: size.height * .05,
                ),
                CalendarDatePicker(
                    initialDate: dateToday,
                    firstDate: dateFirst,
                    lastDate: dateLast,
                    onDateChanged: (date) {
                      setState(() {
                        dateToday = date;
                        print(dateToday);
                      });
                    }),
                SizedBox(
                  height: size.height * .1,
                ),
                Center(
                  child: Material(
                    elevation: 5,
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(35),
                    child: Container(
                        width: size.width * 0.87,
                        height: size.height * 0.06,
                        child: GestureDetector(
                          onTap: () async {
                            start(dateToday);
                            setState(() {
                              counting = true;
                            });
                          },
                          child: Container(
                            width: size.width * 0.02,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(35)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Cadastrar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                    )),
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
              ],
            ),
    );
  }
}
