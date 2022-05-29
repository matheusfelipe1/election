import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/pages/winners/winners_controller.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Winners extends StatefulWidget {
  const Winners({Key? key}) : super(key: key);

  @override
  State<Winners> createState() => _WinnersState();
}

class _WinnersState extends State<Winners> {
  WinnersController controller = Modular.get<WinnersController>();
  AuthController auth = Modular.get<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.data.clear();
    controller.dataCandidates.clear();
    controller.teams.clear();
    controller.values.clear();
    controller.dataUsers.clear();
    controller.func = updateState;
    _init();
  }

  _init() async {
    await controller.getDataInRealtime();
    await controller.getTeams();
    await controller.getAllCandidates();
  }

  updateState() {
    if (mounted) setState(() {});
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
            'Vencedores',
            style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: GestureDetector(
                  onTap: () {
                    UtilsModalMessage().showMessageModal(
                        title: 'Deseja fazer outra votação?',
                        func: () {
                          Modular.to.pushNamed('/votation-new');
                        },
                        colorButton: Colors.green,
                        context: context);
                  },
                  child: Icon(Icons.restart_alt)),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: size.height * 0.05,
            ),
            Center(
                child: Text('Veja os resultados da candidatura',
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontSize: 18))),
            SizedBox(
              height: size.height * 0.07,
            ),
            Container(
              height: size.height * 0.6,
              child: ListView.builder(
                  itemCount: controller.dataUsers.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
                      child: Column(
                        children: [
                          Text(controller.dataUsers[i]['turma'],
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: 18)),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Card(
                            elevation: 2,
                            child: ListTile(
                              leading: controller.dataUsers[i]['foto'] != ''
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: size.width * 0.12,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            image: DecorationImage(
                                                image: NetworkImage(controller
                                                    .dataUsers[i]['foto']),
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
                                    controller.dataUsers[i]['name'],
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black),
                                  ),
                                  Text(
                                    controller.dataUsers[i]['age'].toString() +
                                        ' anos',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              trailing: Text(controller.dataUsers[i]['qttVotes']
                                  .toString()
                                  .split('.')
                                  .first),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        )),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: !auth.user.admin ? Colors.grey : Colors.green,
          onPressed: !auth.user.admin
              ? null
              : () {
                  controller.callNotification();
                },
          label: Row(
            children: [
              Text('Notificar os vencedores',
                  style: const TextStyle(
                      fontFamily: 'Poppins', color: Colors.white)),
              Icon(Icons.notification_add)
            ],
          ),
        ));
  }
}
