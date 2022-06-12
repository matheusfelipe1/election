import 'package:flutter/material.dart';

class Reproved extends StatefulWidget {
  const Reproved({Key? key}) : super(key: key);

  @override
  State<Reproved> createState() => _ReprovedState();
}

class _ReprovedState extends State<Reproved> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          CircleAvatar(
            child: Icon(
              Icons.error_outline,
              size: 50,
              color: Colors.white,
            ),
            backgroundColor: Colors.red,
            radius: 50,
          ),
          SizedBox(
            height: size.height * 0.08,
          ),
          SizedBox(
            width: size.width * 0.7,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Seu cadastro não foi aprovado, entre em contato com um de nossos administradores para que a regularização seja feita. Isso é para garantia da segurança do sistema.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Poppins', color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.08,
          ),
          SizedBox(
            width: size.width * 0.7,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Clique no botão verde abaixo e fale com um dos nossos administradores.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Poppins', color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
