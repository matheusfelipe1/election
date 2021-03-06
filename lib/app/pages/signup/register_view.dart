// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'package:election/app/pages/signup/register_view_controller.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

enum SingingCharacter { enable, unable }

class _RegisterViewState extends State<RegisterView> {
  RegisterViewController controller = Modular.get<RegisterViewController>();
  SingingCharacter? _character = SingingCharacter.unable;
  String dropdownValue = 'Selecione sua turma';
  MaskTextInputFormatter maskNasc =
      new MaskTextInputFormatter(mask: '##/##/####');
  MaskTextInputFormatter maskCPF =
      new MaskTextInputFormatter(mask: '###.###.###-##');
  List<String> turmas = [
    'Selecione sua turma',
    'Turma 26',
    'Turma 36',
    'Turma 25',
    'Turma 19',
    'Turma 15',
    'Turma 10',
  ];
  Matrix4 matrix = Matrix4.identity();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.teams.clear();
    controller.teams.add('Selecione sua turma');
    controller.getTeams();
    controller.func = updateState;
  }

  updateState() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Cadastro',
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: size.height * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                'assets/images/icon_register.png',
                height: size.height * 0.35,
                width: size.width * 0.35,
              )),
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
                    controller: controller.name,
                    decoration: InputDecoration(
                        hintText: 'Nome *',
                        border: InputBorder.none,
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
                    // controller: senha,
                    controller: controller.email,
                    decoration: InputDecoration(
                        hintText: 'E-mail *',
                        border: InputBorder.none,
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
                    // controller: senha,
                    controller: controller.datNasc,
                    inputFormatters: [maskNasc],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Data de Nascimento *',
                        border: InputBorder.none,
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
                    // controller: senha,
                    controller: controller.matricula,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Matr??cula *',
                        border: InputBorder.none,
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
                    // controller: senha,
                    controller: controller.password,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Senha *',
                        border: InputBorder.none,
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
                    // controller: senha,
                    controller: controller.confirmedPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Confirma????o de senha *',
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontFamily: 'Poppins')),
                  ),
                ),
              ),
              controller.isAdmin
                  ? Container()
                  : Container(
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.only(top: 15),
                      height: size.height * 0.07,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          // icon: const Icon(Icons.arrow_downward),
                          hint: Text('Selecione sua turma'),
                          dropdownColor: Colors.white,
                          isExpanded: true,
                          elevation: 16,
                          style: TextStyle(
                              color: dropdownValue == 'Selecione sua turma'
                                  ? Colors.grey
                                  : Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                              controller.idTurma = dropdownValue;
                            });
                          },
                          items: controller.teams
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Divider(
                  color: Colors.black26,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Voc?? ?? usu??rio administrativo?',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        )),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    CupertinoSwitch(
                      value: controller.isAdmin,
                      onChanged: (value) {
                        setState(() {
                          controller.isAdmin = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              // ListTile(
              //   title: Text('N??o',
              //       style: TextStyle(
              //           fontFamily: 'Poppins',
              //           color: Colors.black,
              //           fontSize: size.height * 0.025)),
              //   leading: Radio<SingingCharacter>(
              //     value: SingingCharacter.unable,
              //     groupValue: _character,
              //     onChanged: (SingingCharacter? value) {
              //       setState(() {
              //         _character = value;
              //       });
              //     },
              //   ),
              // ),

              // ListTile(
              //   title: Text('Sim',
              //       style: TextStyle(
              //           fontFamily: 'Poppins',
              //           color: Colors.black,
              //           fontSize: size.height * 0.025)),
              //   leading: Radio<SingingCharacter>(
              //     value: SingingCharacter.enable,
              //     groupValue: _character,
              //     onChanged: (SingingCharacter? value) {
              //       setState(() {
              //         _character = value;
              //       });
              //     },
              //   ),
              // ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Divider(
                  color: Colors.black26,
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.showModalGetPhoto(context, updateState);
                },
                child: Container(
                    alignment: Alignment.centerLeft,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.only(top: 30),
                    height: size.height * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          maxRadius: 50,
                          backgroundColor: Colors.white,
                          child: controller.pathImage != null
                              ? Transform(
                                  transform: matrix,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.memory(
                                      controller.pathImage,
                                      width: size.width * 0.9,
                                      height: size.height * 0.9,
                                      fit: BoxFit.fill,
                                      isAntiAlias: true,
                                    ),
                                  ),
                                )
                              : Container(
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
                        Container(
                          child: Text(
                            'Adicionar foto\n(opcional)',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: size.height * 0.02),
                          ),
                        ),
                        Container()
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () async {
                  if (controller.password.text !=
                      controller.confirmedPassword.text)
                    UtilsModalMessage()
                        .generalToast(title: 'Senhas n??o confere.');
                  else {
                    if (controller.isAdmin) {
                      await UtilsModalMessage().showMessageModal(
                          title: 'Voc?? ?? usu??rio administrativo do sistema?',
                          func: () async {
                            await controller.registerUser(context);
                          },
                          colorButton: Colors.green,
                          context: context);
                    } else
                      controller.registerUser(context);
                  }
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
                        'Salvar',
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
