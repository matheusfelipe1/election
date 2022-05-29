import 'package:election/app/pages/accept_admin/accept_admin_controller.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AcceptAdmin extends StatefulWidget {
  const AcceptAdmin({Key? key}) : super(key: key);

  @override
  State<AcceptAdmin> createState() => _AcceptAdminState();
}

class _AcceptAdminState extends State<AcceptAdmin> {
  updateState() {
    if (mounted) setState(() {});
  }

  AcceptAdminController controller = Modular.get<AcceptAdminController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.users.clear();
    controller.func = updateState;
    controller.getAllUsers();
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
          'Aprovação de usuários',
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Text(
              'Aceitar ou recusar usuários administrativos',
              style:
                  const TextStyle(fontFamily: 'Poppins', color: Colors.black),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Container(
              height: size.height * 0.6,
              child: ListView.builder(
                  itemCount: controller.users.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                        child: Card(
                            elevation: 4,
                            child: ListTile(
                              onTap: () {
                                Modular.to.pushNamed('/profile-details',
                                    arguments: controller.users[i]);
                              },
                              leading: controller.users[i]['foto'] != ''
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: size.width * 0.12,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            image: DecorationImage(
                                                image: NetworkImage(controller
                                                    .users[i]['foto']),
                                                fit: BoxFit.fill)),
                                      ),
                                    )
                                  : CircleAvatar(
                                      maxRadius: 25,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                        size: size.height * 0.04,
                                      ),
                                    ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.users[i]['name'],
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black),
                                  ),
                                  Text(
                                    controller.users[i]['age'].toString() +
                                        ' anos',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              trailing: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await UtilsModalMessage()
                                            .showMessageModal(
                                                title:
                                                    'Deseja aprovar este usuário como administrativo?',
                                                func: () {
                                                  // auth.loggout();
                                                },
                                                colorButton: Colors.green,
                                                context: context);
                                      },
                                      child: Container(
                                          width: size.width * 0.25,
                                          height: size.height * 0.03,
                                          margin: EdgeInsets.only(
                                              top: size.height * 0.00),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(35)),
                                            child: Center(
                                              child: Text('Aprovar',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Poppins',
                                                      fontSize:
                                                          size.height * 0.02)),
                                            ),
                                          )
                                          // Image.asset('assets/images/icon_ok.png', width: 10, height: 10),
                                          ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await UtilsModalMessage()
                                            .showMessageModal(
                                                title:
                                                    'Deseja recusar este usuário como administrativo?',
                                                func: () {
                                                  // auth.loggout();
                                                },
                                                colorButton: Colors.green,
                                                context: context);
                                      },
                                      child: Container(
                                          width: size.width * 0.25,
                                          height: size.height * 0.03,
                                          margin: EdgeInsets.only(
                                              top: size.height * 0.00),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(35)),
                                            child: Center(
                                              child: Text('Recusar',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Poppins',
                                                      fontSize:
                                                          size.height * 0.02)),
                                            ),
                                          )
                                          // Image.asset('assets/images/icon_ok.png', width: 10, height: 10),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            )));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
