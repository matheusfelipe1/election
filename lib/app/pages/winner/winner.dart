// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:election/app/pages/winner/winner_controller.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Winner extends StatefulWidget {
  const Winner({Key? key}) : super(key: key);

  @override
  State<Winner> createState() => _WinnerState();
}

class _WinnerState extends State<Winner> {
  double percent = 0;
  late Timer timer;
  bool segurado = false;
  bool prog = false;
  var radius = 93.0;
  var iconSize = 45.0;
  WinnerController controller = Modular.get<WinnerController>();

  @override
  void initState() {
    // TODO: implement initState
    if (mounted) controller.func = updateState;
    init();
    super.initState();
  }

  init() async {
    bool inStart = await controller.getDataInRealtime();
    print(inStart);
    if (inStart) {
      setState(() {});
      start(controller.dateToday);
    }
    setState(() {});
  }

  updateTime() {
    final reduceSecondsBy = 1;
    if (mounted)
      setState(() {
        final seconds = controller.myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          timer.cancel();
        } else {
          controller.myDuration = Duration(seconds: seconds);
        }
      });
  }

  start(DateTime req) {
    if (mounted)
      setState(() {
        var difference = req.difference(controller.date).inDays;
        controller.myDuration = Duration(days: difference);
      });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  updateState() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final seconds = controller.myDuration.inSeconds.remainder(60);
    final days = controller.myDuration.inDays;
    // Step 7
    final hours = controller.myDuration.inHours.remainder(24);
    final minutes = controller.myDuration.inMinutes.remainder(60);
    Size size = MediaQuery.of(context).size;

    return Container(
      child: controller.counting
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * .1,
                  ),
                  Center(
                    child: Text('Tempo restante para o anúncio dos vencedores.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 15)),
                  ),
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
                    margin: EdgeInsets.only(bottom: 25),
                    child: HoldTimeoutDetector(
                      onTimeout: () {
                        percent = 1;
                        print('end2');
                        setState(() {
                          segurado = true;
                        });
                        Future.delayed(Duration(milliseconds: 1500), () async {
                          await controller.finishVotation();
                          Modular.to.pushNamed('/success');
                        });
                      },
                      onTimerInitiated: () async {
                        // percent = 0.93;
                        print('end3');
                        setState(() {
                          radius = 150;
                          iconSize = 90;
                        });
                        setState(() {});
                        await UtilsModalMessage()
                            .generalToast(title: 'Continue segurando o botão');
                      },
                      onCancel: () {
                        if (!segurado) percent = 0.0;
                        print('end4');
                        setState(() {
                          radius = 93.0;
                          iconSize = 45;
                        });
                      },
                      holdTimeout: Duration(milliseconds: 3000),
                      enableHapticFeedback: true,
                      child: CircularPercentIndicator(
                        radius: radius,
                        animation: true,
                        reverse: true,
                        animationDuration: 1000,
                        progressColor: Colors.green,
                        percent: percent,
                        center: Icon(
                          Icons.check,
                          size: iconSize,
                          color: segurado ? Colors.green : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .04,
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
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
                      initialDate: controller.dateToday,
                      firstDate: controller.dateFirst,
                      lastDate: controller.dateLast,
                      onDateChanged: (date) {
                        setState(() {
                          controller.dateToday = date;
                          print(controller.dateToday);
                        });
                      }),
                  SizedBox(
                    height: size.height * .07,
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
                              bool valid =
                                  await controller.setDateValidInRealtime(
                                      controller.dateToday.toIso8601String());
                              if (valid) {
                                start(controller.dateToday);
                                setState(() {
                                  controller.counting = true;
                                });
                                setState(() {});
                              }
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
                  SizedBox(
                    height: size.height * .02,
                  )
                ],
              ),
            ),
    );
  }
}
