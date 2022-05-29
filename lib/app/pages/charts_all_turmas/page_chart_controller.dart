import 'package:dio/dio.dart';
import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/pages/charts_all_turmas/page_chart_turma.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:charts_flutter/flutter.dart' as charts;
part 'page_chart_controller.g.dart';

class PageChartController = _PageChartControllerBase with _$PageChartController;

abstract class _PageChartControllerBase with Store {
  final _http = CustomHttp();
  VoidCallback? func;
  @observable
  String turmaText = '';
  @observable
  List<String> turmas = [
    'Selecione uma turma',
  ];
  @observable
  List values = [];
  @observable
  List candidatesFilter = [];
  @observable
  List dataCandidates = [];
  @observable
  AuthController auth = Modular.get<AuthController>();
  final List<SubscriberSeries> data = [];
  @action
  organizerData() {
    dataCandidates.sort((a, b) {
      if (b['qttVotes'] < a['qttVotes']) return -1;
      if (b['qttVotes'] > a['qttVotes']) return 1;
      return 0;
    });
  }

  @action
  filter(String query) {
    var newQuery = query.toString().split(' ').last;
    var param = int.tryParse(newQuery);

    candidatesFilter = dataCandidates
        .where((element) => int.tryParse(element['turma']) == param)
        .toList();
    print(candidatesFilter);
  }

  renderChart() {
    int ctt = 0;
    for (var item in candidatesFilter) {
      data.add(SubscriberSeries(
        year: item['name'].toString(),
        subscribers: item['qttVotes'],
        barColor: ctt == 0
            ? charts.ColorUtil.fromDartColor(Colors.blue)
            : ctt == 1
                ? charts.ColorUtil.fromDartColor(Colors.green)
                : ctt == 2
                    ? charts.ColorUtil.fromDartColor(Colors.yellow)
                    : charts.ColorUtil.fromDartColor(Colors.red),
      ));
      ctt++;
    }
  }

  @observable
  getAllCandidates() async {
    UtilsModalMessage().loading(1);
    try {
      Response resp = await _http.client.get('/v1/get-all-users');
      if (resp.statusCode == 200) {
        if (resp.data['STATUS'] == 'SUCCESS') {
          var result = resp.data['DATA'];
          if (result is List) {
            for (var item in result) {
              if (item is Map && item['candidate'] == true) {
                var date =
                    item['datNasc'].toString().split('/').reversed.join('-');
                DateTime newAge = DateTime.parse(date);
                DateTime now = DateTime.now();
                var v = (now.year + now.month);
                var z = (newAge.year + newAge.month);
                var age = v - z;

                dataCandidates.add({
                  'name': item['name'],
                  'age': age,
                  'turma': item['idTurma'].toString().replaceAll('Turma ', ''),
                  'qttVotes': 0.0,
                  'e-mail': item['userEmail'],
                  'id': item['userId'],
                  'foto': item['urlFoto'],
                });
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
                await organizerData();
                func!.call();
                print(item);
                UtilsModalMessage().loading(0);
              }
            }
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
    if (data.value != null) {
      var result = data.value;
      result.forEach((k, v) {
        values.add({'id': k, 'ctt': v['ctt']});
      });
    }
  }

  @action
  getTeams() async {
    UtilsModalMessage().loading(1);
    try {
      Response response = await _http.client.get('/v1/get-teams');
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['STATUS'] == 'SUCCESS') {
          print(result['DATA']);
          var finalResult = result['DATA'];
          finalResult.forEach((element) {
            turmas.add(element['turma']);
          });
          UtilsModalMessage().loading(0);
          print(turmas);
          func!.call();
        }
      }
    } catch (e) {
      print(e);
      UtilsModalMessage().loading(0);
    }
  }

  listenValues() {
    FirebaseDatabase.instance
        .reference()
        .child('votation')
        .onValue
        .listen((event) async {
      var result = event.snapshot.value;
      if (result != null) {
        values.clear();
        result.forEach((k, v) {
          values.add({'id': k, 'ctt': v['ctt']});
          values.forEach((element) {
            candidatesFilter.forEach((element2) {
              if (element2['id'] == element['id']) {
                element2['qttVotes'] =
                    double.tryParse(element['ctt'].toString());
              }
            });
          });
        });
        await organizerData();
        renderDataInChart();
        func!.call();
      }
    });
  }

  renderDataInChart() {
    data.clear();
    int ctt = 0;
    for (var item in candidatesFilter) {
      data.add(SubscriberSeries(
        year: item['userId'] == auth.user.userId
            ? 'Você'
            : item['name'].toString(),
        subscribers: item['qttVotes'],
        barColor: ctt == 0
            ? charts.ColorUtil.fromDartColor(Colors.blue)
            : ctt == 1
                ? charts.ColorUtil.fromDartColor(Colors.green)
                : ctt == 2
                    ? charts.ColorUtil.fromDartColor(Colors.yellow)
                    : charts.ColorUtil.fromDartColor(Colors.red),
      ));
      ctt++;
    }
  }
}
