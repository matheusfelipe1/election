// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'dart:ui';

import 'package:election/app/pages/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Modular.get<LoginController>();
  bool showPas = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/icon_splash.png',
                  width: size.width * 0.4,
                  height: size.height * 0.4,
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(top: 15),
                      height: size.height * 0.07,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextFormField(
                          controller: controller.email,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Digite seu e-mail',
                              hintStyle: TextStyle(fontFamily: 'Poppins')),
                        ),
                      ),
                    ),
                    Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(top: 15),
                      height: size.height * 0.07,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          controller: controller.password,
                          obscureText: showPas ? false : true,
                          decoration: InputDecoration(
                              hintText: 'Digite sua senha',
                              border: InputBorder.none,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showPas = !showPas;
                                  });
                                },
                                child: Icon(
                                  !showPas
                                      ? FontAwesomeIcons.eyeSlash
                                      : Icons.remove_red_eye_sharp,
                                  size: 24,
                                  color: Colors.black,
                                ),
                              ),
                              hintStyle: TextStyle(fontFamily: 'Poppins')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 39),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Modular.to.pushNamed('/navigation');
                        controller.doLogin(context);
                      },
                      child: Container(
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.only(top: 15),
                        height: size.height * 0.07,
                        child: Center(
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Modular.to.pushNamed('/register');
                      },
                      child: Container(
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.only(top: 15),
                        height: size.height * 0.07,
                        child: Center(
                          child: Text(
                            'Cadastre-se',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
