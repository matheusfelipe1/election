import 'package:flutter/material.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({Key? key}) : super(key: key);

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [Text('Cadastre novas turmas.')],
    ));
  }
}
