import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileDetails extends StatefulWidget {
  final dynamic data;
  const ProfileDetails({Key? key, this.data}) : super(key: key);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.data);
    super.initState();
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
          'Detalhamento do perfil',
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nome: ' + widget.data['name'],
                              style: const TextStyle(
                                  fontFamily: 'Poppins', color: Colors.black)),
                          Text('Idade: ' + widget.data['age'].toString(),
                              style: const TextStyle(
                                  fontFamily: 'Poppins', color: Colors.black)),
                          Text('E-mail: ' + widget.data['e-mail'],
                              style: const TextStyle(
                                  fontFamily: 'Poppins', color: Colors.black)),
                          Text('Turma: ' + widget.data['turma'].toString(),
                              style: const TextStyle(
                                  fontFamily: 'Poppins', color: Colors.black)),
                          Text(
                              'Quantidade de votos: ' +
                                  widget.data['qttVotes'].toString(),
                              style: const TextStyle(
                                  fontFamily: 'Poppins', color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: CircleAvatar(
                      maxRadius: 50,
                      backgroundColor: Colors.white,
                      child: Container(
                        width: size.width * 0.9,
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.black)),
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: size.height * 0.08,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.07),
                child: GestureDetector(
                    onTap: () async {
                      await UtilsModalMessage().showMessageModal(
                          title:
                              'Deseja realmente votar no candidato(a) ${widget.data['name']}?',
                          func: () {
                            Modular.to.pop();
                          },
                          colorButton: Colors.green,
                          context: context);
                    },
                    child: Container(
                      width: size.width * 0.57,
                      height: size.height * 0.05,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(35)),
                      child: Center(
                        child: Text(
                          'Votar neste candidato',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
