import 'dart:async';

import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/pages/passport/widgets_passport/widget_reproved.dart';
import 'package:election/app/pages/passport/widgets_passport/widget_waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Passport extends StatefulWidget {
  const Passport({Key? key}) : super(key: key);

  @override
  State<Passport> createState() => _PassportState();
}

class _PassportState extends State<Passport> {
  bool selected = false;
  String text = '';
  AuthController auth = Modular.get<AuthController>();
  @override
  void initState() {
    // TODO: implement initState
    switchState();
    auth.saveDeviceToken();
    super.initState();
  }

  switchState() {
    Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (mounted)
        setState(() {
          selected = !selected;
          if (selected) {
            text = '..';
          } else {
            text = '...';
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
            ),
          ),
          centerTitle: false,
          leading: GestureDetector(
            onTap: () => Modular.to.pop(),
            child: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.grey,
          title: const Text(
            'Aprovação de cadastro',
            style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
          ),
        ),
        floatingActionButton: !auth.user.blocked
            ? Container()
            : FloatingActionButton.extended(
                icon: Icon(Icons.chat),
                onPressed: () {
                  Modular.to.pushNamed('/list-chat');
                },
                label: Text('Mensagens')),
        body: auth.user.blocked ? Reproved() : Waiting());
  }
}
