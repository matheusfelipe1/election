import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/pages/subscribe/subscribe_controller.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SubscribePage extends StatefulWidget {
  const SubscribePage({Key? key}) : super(key: key);

  @override
  State<SubscribePage> createState() => _SubscribePageState();
}

class _SubscribePageState extends State<SubscribePage> {
  SubscribeController controller = Modular.get<SubscribeController>();
  AuthController auth = Modular.get<AuthController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(35),
          child: Container(
            width: size.width * 0.85,
            height: size.height * 0.7,
            child: Center(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                            'Voce deseja se candidatar à representante de turma ?',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.02),
                        child: Text(
                            'O Representante de turma é o elo entre a turma e a Faculdade. É o responsável pelo diálogo ético e eficaz com a sua turma, administrando eventuais problemas, coletando informações e sugestões. Ele promove a integração do grupo, possibilitando a participação de todos nos assuntos de turma, mobilizando para participação em atividades como eventos institucionais, palestras, visitas técnicas, cursos dentre outras atividades pertinentes a tal tarefa.',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 12)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.0),
                        child: Text(
                            'O Representante é o multiplicador das informações institucionais, transmitidas pelos professores, diretores de curso e ou administradores da Faculdade. Tem papel fundamental na aproximação do Corpo Discente com a Direção do Curso e a Direção Geral da Faculdade permitindo assim a contribuição dos alunos no aprimoramento das propostas pedagógicas. Perfil Ideal do Representante é o aluno que:',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 12)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(top: size.height * 0.0),
                        child: Text(
                            '- Exerce a cidadania.\n- É responsável.\n- É criativo.\n- Tem espírito de liderança.\n- É bom moderador.\n- É comprometido com as atividades propostas.\n- É solidário, entusiasta e idealista.\n- Tem conduta adequada aos valores da faculdade.',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 12)),
                      ),
                    ),
                    auth.user.candidate
                        ? Container(
                            width: size.width * 0.45,
                            margin: EdgeInsets.only(top: size.height * 0.02),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(35)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Você já se candidatou',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Poppins',
                                          fontSize: size.height * 0.02)),
                                ),
                              ),
                            )
                            // Image.asset('assets/images/icon_ok.png', width: 10, height: 10),
                            )
                        : GestureDetector(
                            onTap: () async {
                              // Modular.to.pushNamed('/login');
                              await UtilsModalMessage().showMessageModal(
                                  title:
                                      'Deseja realmente se candidatar a representante de turma?',
                                  func: () {
                                    controller.subscribe();
                                  },
                                  colorButton: Colors.green,
                                  context: context);
                            },
                            child: Container(
                                width: size.width * 0.45,
                                margin:
                                    EdgeInsets.only(top: size.height * 0.02),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green[700],
                                      borderRadius: BorderRadius.circular(35)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text('Candidatar',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              fontSize: size.height * 0.02)),
                                    ),
                                  ),
                                )
                                // Image.asset('assets/images/icon_ok.png', width: 10, height: 10),
                                ),
                          )
                  ],
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
