import 'package:election/app/pages/create_team/create_team_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({Key? key}) : super(key: key);

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  CreateTeamController controller = Modular.get<CreateTeamController>();

  updateState() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.func = updateState;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height * .05,
          ),
          Center(
            child: Text('Cadastre novas turmas.',
                style: TextStyle(color: Colors.black, fontFamily: 'Poppins')),
          ),
          SizedBox(
            height: size.height * .05,
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
                // controller: controller.matricula,
                controller: controller.name,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Informe o nome da turma *',
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
                // controller: controller.matricula,
                controller: controller.periodo,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Informe o período da turma *',
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
                // controller: controller.matricula,
                controller: controller.curso,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Informe o curso da turma *',
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
                controller: controller.disciplina,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Informe a disciplina da turma *',
                    border: InputBorder.none,
                    hintStyle: TextStyle(fontFamily: 'Poppins')),
              ),
            ),
          ),
          SizedBox(
            height: size.height * .08,
          ),
          GestureDetector(
            onTap: () {
              controller.createTeam();
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
    ));
  }
}
