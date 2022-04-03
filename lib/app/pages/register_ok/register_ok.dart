// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RegisterOk extends StatefulWidget {
  const RegisterOk({Key? key}) : super(key: key);

  @override
  State<RegisterOk> createState() => _RegisterOkState();
}

class _RegisterOkState extends State<RegisterOk> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Text('Seu cadastro foi realizado com sucesso!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: size.height * 0.045,
                          fontWeight: FontWeight.w500))),
            ),
            Container(
                margin: EdgeInsets.only(top: size.height * 0.12),
                child: CircleAvatar(
                    maxRadius: size.height * 0.15,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: size.height * 0.2,
                    ))
                // Image.asset('assets/images/icon_ok.png', width: 10, height: 10),
                ),
            GestureDetector(
              onTap: () {
                Modular.to.pushNamed('/login');
              },
              child: Container(
                  width: size.width * 0.45,
                  margin: EdgeInsets.only(top: size.height * 0.12),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(35)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('OK',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: size.height * 0.025)),
                      ),
                    ),
                  )
                  // Image.asset('assets/images/icon_ok.png', width: 10, height: 10),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
