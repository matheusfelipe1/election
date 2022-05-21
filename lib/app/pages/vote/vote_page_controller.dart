import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'vote_page_controller.g.dart';

class VotePageController = _VotePageControllerBase with _$VotePageController;

abstract class _VotePageControllerBase with Store {
  @observable
  AuthController auth = Modular.get<AuthController>();
  final _http = CustomHttp();
  late VoidCallback func;

  @observable
  List dataCandidates = [
    {
      'name': 'Marcus',
      'age': 21,
      'qttVotes': 95.0,
      'turma': 26,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Ana Carolina',
      'age': 22,
      'qttVotes': 56.0,
      'turma': 26,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Carlos',
      'age': 20,
      'qttVotes': 47.0,
      'turma': 26,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 26,
      'e-mail': 'teste@gmail.com'
    },
  ];
  @action
  organizerData() {
    dataCandidates.sort((a, b) {
      if (b['qttVotes'] < a['qttVotes']) return -1;
      if (b['qttVotes'] > a['qttVotes']) return 1;
      return 0;
    });
  }

  @action
  vote(String id) {
    updateVoteInDatabase(id);
    Modular.to.pop();
  }

  @observable
  getValuesCharts() async {
    UtilsModalMessage().loading(1);
    try {
      Response resp =
          await _http.client.get('/v1/get-charts/${auth.user.idTurma}');
      if (resp.statusCode == 200) {
        if (resp.data['STATUS'] == 'SUCCESS') {
          var result = resp.data['DATA'];
          if (result is List) {
            for (var item in result) {
              if (item is Map && item['candidate'] == true) {
                print(item);
                var date =
                    item['datNasc'].toString().split('/').reversed.join('-');
                DateTime newAge = DateTime.parse(date);
                DateTime now = DateTime.now();
                var v = (now.year + now.month);
                var z = (newAge.year + newAge.month);
                var age = v - z;
                if (item['name'] == 'Juliana')
                  // ignore: curly_braces_in_flow_control_structures
                  dataCandidates.add({
                    'name': item['name'],
                    'age': age,
                    'turma':
                        item['idTurma'].toString().replaceAll('Turma ', ''),
                    'qttVotes': 40.0,
                    'e-mail': item['userEmail'],
                    'id': item['userId']
                  });
                else
                  dataCandidates.add({
                    'name': item['name'],
                    'age': age,
                    'turma':
                        item['idTurma'].toString().replaceAll('Turma ', ''),
                    'qttVotes': 80.0,
                    'e-mail': item['userEmail'],
                    'id': item['userId']
                  });
                organizerData();
                func.call();
                print(item);
                UtilsModalMessage().loading(0);
              }
            }
          }
        }
      } else {
        dataCandidates.clear();
      }
      UtilsModalMessage().loading(0);
    } catch (e) {
      print(e);
      dataCandidates.clear();
      UtilsModalMessage().loading(0);
    }
  }

  @action
  updateVoteInDatabase(String id) async {
    UtilsModalMessage().loading(1);
    try {
      final map = {'userId': auth.user.userId};
      Response response =
          await _http.client.post('/v1/voted', data: json.encode(map));
      if (response.statusCode == 200) {
        var _result = response.data;
        if (_result['STATUS'] == 'SUCCESS') {
          await voteCandidate(id);
          UtilsModalMessage().loading(0);
          UtilsModalMessage().generalToast(title: 'Voto enviado com sucesso!');
          await auth.getUser();
        } else {
          UtilsModalMessage().loading(0);
          UtilsModalMessage()
              .generalToast(title: 'Erro ao votar no candidato.');
        }
      } else {
        UtilsModalMessage().loading(0);
        UtilsModalMessage().generalToast(title: 'Erro ao votar no candidato.');
      }
    } catch (e) {
      UtilsModalMessage().loading(0);
      UtilsModalMessage().generalToast(title: 'Erro ao votar no candidato.');
      print(e);
    }
  }

  @action
  voteCandidate(String id) async {
    DataSnapshot data = await FirebaseDatabase.instance
        .reference()
        .child('votation')
        .child(id)
        .once();
    if (data.value != null) {
      var soma = data.value['ctt'] + 1;

      return FirebaseDatabase.instance
          .reference()
          .child('votation')
          .child(id)
          .set({'ctt': soma}).asStream();
    } else {
      return FirebaseDatabase.instance
          .reference()
          .child('votation')
          .child(id)
          .set({'ctt': 1}).asStream();
    }
  }
}
