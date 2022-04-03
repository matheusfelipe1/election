import 'package:election/app/pages/profile/profile_edit/profile_edit_controller.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  ProfileEditController controller = Modular.get<ProfileEditController>();
  updateState() {
    if (mounted) setState(() {});
  }

  Matrix4 matrix = Matrix4.identity();
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
          'Editar perfil',
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
      body: Container(
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    textAlign: TextAlign.start,
                    // controller: senha,
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
                    decoration: InputDecoration(
                        hintText: 'CPF *',
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
                    decoration: InputDecoration(
                        hintText: 'Confirmação de senha *',
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontFamily: 'Poppins')),
                  ),
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
                            'Editar foto\n(opcional)',
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
                  // Modular.to.pushNamed('/register-ok');
                  await UtilsModalMessage().showMessageModal(
                      title: 'Deseja realmente editar essas informações?',
                      func: () {
                        Modular.to.pop();
                      },
                      colorButton: Colors.green,
                      context: context);
                },
                child: Container(
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.only(top: 40, bottom: 40),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
