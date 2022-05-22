// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:async';

import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/pages/admin_user/relatorio_admin/report_user.dart';
import 'package:election/app/pages/charts_all_turmas/switch_turma/switch_turma.dart';
import 'package:election/app/pages/home/home.dart';
import 'package:election/app/pages/screen_charts/screen_charts.dart';
import 'package:election/app/pages/settings/settings_page.dart';
import 'package:election/app/pages/subscribe/subscribe_page.dart';
import 'package:election/app/pages/vote/vote_page.dart';
import 'package:election/app/pages/winner/winner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  AuthController auth = Modular.get<AuthController>();
  bool userAdmin = false;
  int _selectedIndex = 0;
  String name = '';

  List<Widget> _widgetOptions = [];
  @override
  void initState() {
    // TODO: implement initState
    userAdmin = auth.user.admin;
    name = auth.user.name;
    _widgetOptions = userAdmin
        ? [
            HomePage(),
            SwitchCharts(),
            // SubscribePage(),
            ReportUser(),
            Winner(),
            SettingsPage()
          ]
        : [
            // HomePage(),
            ScreenCharts(),
            SubscribePage(),
            VotePage(),
            SettingsPage()
          ];
    setAdminOrNot();
    print(auth.user.urlFoto);
    super.initState();
  }

  setAdminOrNot() async {
    var shared = await SharedPreferences.getInstance();
    shared.setBool('admin', userAdmin);
    await auth.saveDeviceToken();
  }

  void _onItemTapped(int index) {
    if (mounted)
      setState(() {
        _selectedIndex = index;
      });
  }

  callLegend() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            content: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text('Legenda dos gráficos',
                          style: const TextStyle(
                              fontFamily: 'Poppins', color: Colors.black)),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: CircleAvatar(
                                maxRadius: 10,
                                backgroundColor: Colors.blue,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: Text('Primeiro colocado'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: CircleAvatar(
                                maxRadius: 10,
                                backgroundColor: Colors.green,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: Text('Segundo colocado'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: CircleAvatar(
                                maxRadius: 10,
                                backgroundColor: Colors.yellow,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: Text('Terceiro colocado'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: CircleAvatar(
                                maxRadius: 10,
                                backgroundColor: Colors.red,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: Text('Demais colocados'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    int indice = 0;
    if (userAdmin) if (mounted)
      setState(() {
        indice = 1;
      });
    else if (mounted)
      setState(() {
        indice = 0;
      });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          _selectedIndex == indice
              ? Container(
                  margin: EdgeInsets.only(right: size.width * 0.08),
                  child: GestureDetector(
                      onTap: () {
                        callLegend();
                      },
                      child: Icon(Icons.info_outline)),
                )
              : Container()
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(_selectedIndex == 0 ? 50 : 50),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Modular.to.pushNamed('/profile-edit');
          },
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: auth.user.urlFoto != ''
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                            image: NetworkImage(auth.user.urlFoto),
                            fit: BoxFit.fill)),
                  )
                : CircleAvatar(
                    maxRadius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                      size: size.height * 0.04,
                    ),
                  ),
          ),
        ),
        backgroundColor: Colors.grey,
        centerTitle: false,
        title: Text(
          'Olá, ' + name,
          style: const TextStyle(fontFamily: 'Poppins', color: Colors.black),
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: userAdmin
            ? const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.grey,
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.chartColumn),
                  label: 'Gráficos',
                  backgroundColor: Colors.grey,
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.list),
                  label: 'Relatório',
                  backgroundColor: Colors.grey,
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.medal),
                  label: 'Votação',
                  backgroundColor: Colors.grey,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Configurações',
                  backgroundColor: Colors.grey,
                ),
              ]
            : const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.grey,
                ),
                //  BottomNavigationBarItem(
                //   icon: Icon(FontAwesomeIcons.chartColumn),
                //   label: 'Gráfico',
                //   backgroundColor: Colors.grey,
                // ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_add),
                  label: 'Inscreva-se',
                  backgroundColor: Colors.grey,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.how_to_vote_sharp),
                  label: 'Vote',
                  backgroundColor: Colors.grey,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Configurações',
                  backgroundColor: Colors.grey,
                ),
              ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
