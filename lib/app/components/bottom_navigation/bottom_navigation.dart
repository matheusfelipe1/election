// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:election/app/pages/home/home.dart';
import 'package:election/app/pages/screen_charts/screen_charts.dart';
import 'package:election/app/pages/settings/settings_page.dart';
import 'package:election/app/pages/subscribe/subscribe_page.dart';
import 'package:election/app/pages/vote/vote_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _selectedIndex = 0;
  String name = 'Matheus';
  List<Widget> _widgetOptions = [
    HomePage(),
    ScreenCharts(),
    SubscribePage(),
    VotePage(),
    SettingsPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            maxRadius: 50,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: size.height * 0.04,
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.grey,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chartColumn),
            label: 'Gráfico',
            backgroundColor: Colors.grey,
          ),
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
