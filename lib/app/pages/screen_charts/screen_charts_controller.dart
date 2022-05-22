// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:dio/dio.dart';
import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/pages/screen_charts/screen_charts.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:charts_flutter/flutter.dart' as charts;

part 'screen_charts_controller.g.dart';

class ScreenChartsController = _ScreenChartsControllerBase
    with _$ScreenChartsController;

abstract class _ScreenChartsControllerBase with Store {
  final _http = CustomHttp();
  @observable
  AuthController auth = Modular.get<AuthController>();
  late VoidCallback func;
  @observable
  List values = [];
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
  // @observable
  final List<SubscriberSeries> data = [];
  @action
  organizerData() {
    dataCandidates.sort((a, b) {
      if (b['qttVotes'] < a['qttVotes']) return -1;
      if (b['qttVotes'] > a['qttVotes']) return 1;
      return 0;
    });
  }

  @observable
  getValuesCharts() async {
    UtilsModalMessage().loading(1);
    dataCandidates.clear();
    try {
      Response resp =
          await _http.client.get('/v1/get-charts/${auth.user.idTurma}');
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
                // ignore: curly_braces_in_flow_control_structures

                dataCandidates.add({
                  'name': item['name'],
                  'age': age,
                  'turma': item['idTurma'].toString().replaceAll('Turma ', ''),
                  'qttVotes': 0.0,
                  'e-mail': item['userEmail'],
                  'id': item['userId'],
                });

                if (values.length > 0) {
                  values.forEach((element) {
                    dataCandidates.forEach((element2) {
                      if (element['id'] == element2['id']) {
                        element2['qttVotes'] =
                            double.tryParse(element['ctt'].toString());
                      }
                    });
                  });
                }

                await organizerData();
                renderDataInChart();

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
      dataCandidates.clear();
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
            dataCandidates.forEach((element2) {
              if (element2['id'] == element['id']) {
                element2['qttVotes'] =
                    double.tryParse(element['ctt'].toString());
              }
            });
          });
        });
        await organizerData();
        renderDataInChart();
        func.call();
      }
    });
  }

  renderDataInChart() {
    data.clear();
    int ctt = 0;
    for (var item in dataCandidates) {
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
}
