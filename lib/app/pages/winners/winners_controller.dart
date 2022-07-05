import 'dart:convert';
import 'dart:ui';

import 'package:age_calculator/age_calculator.dart';
import 'package:dio/dio.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mobx/mobx.dart';

part 'winners_controller.g.dart';

class WinnersController = _WinnersControllerBase with _$WinnersController;

abstract class _WinnersControllerBase with Store {
  final _http = CustomHttp();
  @observable
  List dataCandidates = [];
  @observable
  List data = [];
  VoidCallback? func;
  @observable
  List values = [];
  @observable
  List teams = [];
  @observable
  dynamic valuesRender;
  @observable
  List dataUsers = [];

  @action
  organizerData() {
    dataCandidates.sort((a, b) {
      if (b['qttVotes'] < a['qttVotes']) return -1;
      if (b['qttVotes'] > a['qttVotes']) return 1;
      return 0;
    });
    data = dataCandidates;
  }

  @observable
  getAllCandidates() async {
    dataCandidates.clear();
    dataUsers.clear();
    UtilsModalMessage().loading(1);
    try {
      Response resp = await _http.client.get('/v1/get-all-users');
      if (resp.statusCode == 200) {
        if (resp.data['STATUS'] == 'SUCCESS') {
          var result = resp.data['DATA'];
          if (result is List) {
            for (var item in result) {
              if (item is Map && item['candidate'] == true) {
                var age;
                var date =
                    item['datNasc'].toString().split('/').reversed.join('-');
                DateTime newAge = DateTime.parse(date);
                DateDuration duration;
                duration = AgeCalculator.age(newAge);
                age = duration.years;
                var obj = {
                  'name': item['name'],
                  'age': age,
                  'turma': item['idTurma'].toString(),
                  'qttVotes': 0.0,
                  'e-mail': item['userEmail'],
                  'id': item['userId'],
                  'foto': item['urlFoto']
                };
                dataCandidates.add(obj);

                UtilsModalMessage().loading(0);
              }
            }
            if (values.length > 0) {
              values.forEach((element) {
                dataCandidates.forEach((element2) {
                  if (element2['id'] == element['id']) {
                    element2['qttVotes'] =
                        double.tryParse(element['ctt'].toString());
                  }
                });
              });
            }
            print(teams);
            teams.forEach((element) async {
              await renderValues(element);
            });
            func!.call();
          }
        }
      }
      UtilsModalMessage().loading(0);
    } catch (e) {
      print(e);
      UtilsModalMessage().loading(0);
    }
  }

  @action
  getDataInRealtime() async {
    values.clear();
    DataSnapshot data =
        await FirebaseDatabase.instance.reference().child('votation').once();
    print(data.value);
    if (data.value != null) {
      Map result = data.value;
      result.forEach((k, v) {
        values.add({'id': k, 'ctt': v['ctt']});
      });
    }
    print(values);
  }

  @action
  getTeams() async {
    teams.clear();
    UtilsModalMessage().loading(1);
    try {
      Response response = await _http.client.get('/v1/get-teams');
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['STATUS'] == 'SUCCESS') {
          print(result['DATA']);
          List finalResult = result['DATA'];
          finalResult.forEach((element) {
            teams.add(element['turma']);
          });
          UtilsModalMessage().loading(0);
          print(teams);
        }
      }
    } catch (e) {
      print(e);
      UtilsModalMessage().loading(0);
    }
  }

  @action
  renderValues(String query) {
    print(query);
    var valuesData = [];
    dataCandidates.forEach((element) {
      if (element['turma'] == query) {
        valuesData.add(element);
      }
    });
    valuesData.sort((a, b) {
      if (b['qttVotes'] < a['qttVotes']) return -1;
      if (b['qttVotes'] > a['qttVotes']) return 1;
      return 0;
    });
    if (valuesData.length > 0) {
      dataUsers.add(valuesData.first);
    }
    print(dataUsers);
  }

  @action
  callNotification() async {
    UtilsModalMessage().loading(1);
    try {
      for (var item in dataUsers) {
        final map = {
          'userId': item['id'],
          'title': 'Parabens!',
          'body': 'Você é o novo representante de turma da sua classe.',
        };
        Response response = await _http.client
            .post('/v1/call-notifications-service', data: json.encode(map));
      }
      UtilsModalMessage()
          .generalToast(title: 'Os vencedores foram informados.');
      UtilsModalMessage().loading(0);
    } catch (e) {
      UtilsModalMessage().loading(0);
      UtilsModalMessage()
          .generalToast(title: 'Erro ao enviar notificação aos vencedores.');
      print(e);
    }
  }

  resetVotation() {
    return FirebaseDatabase.instance.reference().child('votation').remove();
  }
}
