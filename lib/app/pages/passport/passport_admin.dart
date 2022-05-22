import 'dart:async';

import 'package:election/app/auth/auth_controller.dart';
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.06,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Por motivos de seguranças e por você ser um usuário administrador, precisamos aprovar primeiramente seu cadastro para que você consiga acessar os recursos do aplicativo.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 17),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              Container(
                  // ignore: prefer_const_constructors
                  child: ListTile(
                // ignore: prefer_const_constructors
                leading: CircleAvatar(
                  maxRadius: 15,
                  backgroundColor: Colors.green,
                ),
                title: Text(
                  'Cadastro finalizado com sucesso.',
                  style: const TextStyle(
                      fontFamily: 'Poppins', color: Colors.black, fontSize: 16),
                ),
              )),
              Container(
                  child: ListTile(
                leading: CircleAvatar(
                  maxRadius: 15,
                  child: AnimatedContainer(
                    width: 100.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                        color: selected ? Colors.green : Colors.yellow,
                        borderRadius: BorderRadius.circular(50)),
                    alignment: selected
                        ? Alignment.center
                        : AlignmentDirectional.topCenter,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: '',
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                          text: 'Aguardando aprovação',
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 16)),
                      TextSpan(
                          text: text,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 24)),
                    ],
                  ),
                ),
              )),
              SizedBox(
                height: size.height * 0.06,
              ),
              GestureDetector(
                onTap: () async {
                  auth.verifyAproveRegister();
                },
                child: Container(
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.only(top: 40),
                    height: size.height * 0.07,
                    child: Center(
                      child: Text(
                        'Tentar novamente',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: size.height * 0.02),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
