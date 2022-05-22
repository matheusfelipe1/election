import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AuthController auth = Modular.get<AuthController>();

  @override
  Widget build(BuildContext context) {
    String age = '';
    DateTime agr = DateTime.now();
    var newQuery = auth.user.datNasc.toString().split('/').reversed.join('-');
    DateTime query = DateTime.parse(newQuery);
    var v = (agr.year + agr.month);
    var z = (query.year + query.month);
    age = (v - z).toString();
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.071, top: 17, bottom: 10),
                    child: Text('Editar perfil',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Poppins')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed('/profile-edit');
                  },
                  child: Center(
                    child: Material(
                      elevation: 5,
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(35),
                      child: Container(
                        width: size.width * 0.87,
                        height: size.height * 0.2,
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: CircleAvatar(
                                  maxRadius: 25,
                                  backgroundColor: Colors.white,
                                  child: auth.user.urlFoto != ''
                                      ? Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      auth.user.urlFoto),
                                                  fit: BoxFit.fill)),
                                        )
                                      : Icon(
                                          Icons.person,
                                          color: Colors.black,
                                          size: size.height * 0.04,
                                        ),
                                ),
                              ),
                            ),
                            Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(auth.user.name.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins')),
                                    ),
                                    auth.user.admin
                                        ? Container()
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(auth.user.idTurma,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Poppins')),
                                          ),
                                    auth.user.admin
                                        ? Container()
                                        : Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: Text(age + ' Anos',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Poppins')),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(auth.user.email,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Poppins')),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.071,
                      top: size.height * 0.05,
                      bottom: 10,
                    ),
                    child: Text('Sair do app',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Poppins')),
                  ),
                ),
                Center(
                  child: Material(
                    elevation: 5,
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(35),
                    child: Container(
                        width: size.width * 0.87,
                        height: size.height * 0.088,
                        child: GestureDetector(
                          onTap: () async {
                            await UtilsModalMessage().showMessageModal(
                                title: 'Deseja realmente sair?',
                                func: () {
                                  auth.loggout();
                                },
                                colorButton: Colors.green,
                                context: context);
                          },
                          child: Container(
                            width: size.width * 0.02,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(35)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('SAIR',
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.071,
                      top: size.height * 0.05,
                      bottom: 10,
                    ),
                    child: Text('Excluir conta',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'Poppins')),
                  ),
                ),
                Center(
                  child: Material(
                    elevation: 5,
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(35),
                    child: Container(
                        width: size.width * 0.87,
                        height: size.height * 0.088,
                        child: GestureDetector(
                          onTap: () async {
                            await UtilsModalMessage().showMessageModal(
                                title: 'Deseja realmente excluir sua conta?',
                                func: () {
                                  auth.deleteProfile();
                                },
                                colorButton: Colors.red,
                                context: context);
                          },
                          child: Container(
                            width: size.width * 0.02,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(35)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('EXCLUIR',
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
