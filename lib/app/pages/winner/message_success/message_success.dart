import 'dart:async';

import 'package:election/app/pages/winner/winner_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sucess extends StatefulWidget {
  const Sucess({Key? key}) : super(key: key);

  @override
  State<Sucess> createState() => _SucessState();
}

class _SucessState extends State<Sucess> with SingleTickerProviderStateMixin {
  late Animation sizeAnimation;
  late Animation colorAnimation;
  late AnimationController controller;
  late Timer timer;
  WinnerController _controller = Modular.get<WinnerController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    sizeAnimation = Tween(begin: 0.0, end: 300.0).animate(controller);

    colorAnimation = ColorTween(begin: Colors.red, end: Colors.blue).animate(
        CurvedAnimation(parent: controller, curve: Interval(0.5, 1.0)));
    Future.delayed(Duration(seconds: 1), () {
      if (mounted)
        setState(() {
          sizeAnimation =
              Tween(begin: 0.0, end: MediaQuery.of(context).size.height)
                  .animate(controller);
        });
    });
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) setState(() {});
    });
    Future.delayed(Duration(seconds: 7), () {
      _controller.finishVotation();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.forward();
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 3),
          height: sizeAnimation.value,
          width: sizeAnimation.value,
          color: Colors.green,
          child: !controller.isCompleted
              ? Container()
              : Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.06,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Votação encerrada com sucesso!',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 20)),
                        ),
                        SizedBox(
                          height: size.height * 0.06,
                        ),
                        Container(
                          height: 170,
                          width: 170,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(200)),
                          child: Center(
                            child: Icon(
                              Icons.check,
                              color: Colors.green,
                              size: 95,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Padding(
                              padding: const EdgeInsets.only(right: 23.0),
                              child: GestureDetector(
                                onTap: () {
                                  Modular.to.pushNamed('/navigation');
                                },
                                child: Container(
                                  height: 60,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(200)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.arrowLeft,
                                          color: Colors.green,
                                          size: 40,
                                        ),
                                        Text('Voltar',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                color: Colors.green,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.15,
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
