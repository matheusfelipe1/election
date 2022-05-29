import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'create_team_controller.g.dart';

class CreateTeamController = _CreateTeamControllerBase
    with _$CreateTeamController;

abstract class _CreateTeamControllerBase with Store {
  final _http = CustomHttp();
  @observable
  TextEditingController name = new TextEditingController();
  @observable
  TextEditingController periodo = new TextEditingController();
  @observable
  TextEditingController curso = new TextEditingController();
  @observable
  TextEditingController disciplina = new TextEditingController();
  @observable
  late VoidCallback func;

  @action
  createTeam() async {
    UtilsModalMessage().loading(1);
    try {
      final map = {
        'turma': 'Turma ' + name.text,
        'age': periodo.text,
        'curso': curso.text,
        'disciplina': disciplina.text,
      };
      Response response =
          await _http.client.post('/v1/create-team', data: json.encode(map));
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['STATUS'] == 'SUCCESS') {
          UtilsModalMessage().loading(0);
          UtilsModalMessage()
              .generalToast(title: 'Turma cadastrada com sucesso');
          name.text = '';
          periodo.text = '';
          curso.text = '';
          disciplina.text = '';
          func.call();
        }
      }
    } catch (e) {
      UtilsModalMessage().loading(0);
      UtilsModalMessage().generalToast(title: 'Erro ao cadastrar turma');
    }
  }
}
