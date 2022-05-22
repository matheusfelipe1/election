import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/pages/vote/vote_page_controller.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class VotePage extends StatefulWidget {
  const VotePage({Key? key}) : super(key: key);

  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  VotePageController controller = Modular.get<VotePageController>();
  AuthController auth = Modular.get<AuthController>();
  @override
  void initState() {
    // TODO: implement initState
    controller.dataCandidates.clear();
    controller.organizerData();
    controller.func = updateState;
    controller.getValuesCharts();
    super.initState();
  }

  updateState() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Vote no candidato da sua turma',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontSize: size.height * 0.025)),
              Container(
                height: size.height * 0.6,
                margin: EdgeInsets.only(top: size.height * 0.025),
                child: ListView.builder(
                    itemCount: controller.dataCandidates.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        child: Card(
                          elevation: 4,
                          child: auth.user.admin ||
                                  auth.user.candidate ||
                                  auth.user.alredyVoted
                              ? ListTile(
                                  onTap: () {
                                    Modular.to.pushNamed('/profile-details',
                                        arguments:
                                            controller.dataCandidates[i]);
                                  },
                                  leading: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: controller.dataCandidates[i]
                                                ['foto'] !=
                                            ''
                                        ? Container(
                                            width: size.width * 0.11,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        controller
                                                                .dataCandidates[
                                                            i]['foto']),
                                                    fit: BoxFit.fill)),
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
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.dataCandidates[i]['name'],
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black),
                                      ),
                                      Text(
                                        controller.dataCandidates[i]['age']
                                                .toString() +
                                            ' anos',
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                )
                              : ListTile(
                                  onTap: () {
                                    Modular.to.pushNamed('/profile-details',
                                        arguments:
                                            controller.dataCandidates[i]);
                                  },
                                  leading: CircleAvatar(
                                    maxRadius: 25,
                                    backgroundColor: Colors.white,
                                    child: controller.dataCandidates[i]
                                                ['foto'] !=
                                            ''
                                        ? Container(
                                            width: size.width * 0.11,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        controller
                                                                .dataCandidates[
                                                            i]['foto']),
                                                    fit: BoxFit.fill)),
                                          )
                                        : Icon(
                                            Icons.person,
                                            color: Colors.black,
                                            size: size.height * 0.04,
                                          ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.dataCandidates[i]['name'],
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black),
                                      ),
                                      Text(
                                        controller.dataCandidates[i]['age']
                                                .toString() +
                                            ' anos',
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  trailing: GestureDetector(
                                    onTap: () async {
                                      await UtilsModalMessage().showMessageModal(
                                          title: 'Deseja realmente votar no candidato(a) ${controller.dataCandidates[i]['name']}?',
                                          func: () {
                                            controller.vote(controller
                                                .dataCandidates[i]['id']);
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
                                            child: Text('Votar',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Poppins',
                                                    fontSize:
                                                        size.height * 0.02)),
                                          ),
                                        )
                                        // Image.asset('assets/images/icon_ok.png', width: 10, height: 10),
                                        ),
                                  )),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
