import 'package:dio/dio.dart';
import 'package:election/app/pages/charts_all_turmas/page_chart_turma.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:charts_flutter/flutter.dart' as charts;
part 'page_chart_controller.g.dart';

class PageChartController = _PageChartControllerBase with _$PageChartController;

abstract class _PageChartControllerBase with Store {
  final _http = CustomHttp();
  late VoidCallback func;
  @observable
  String turmaText = '';
  @observable
  List<String> turmas = [
    'Selecione uma turma',
    'Turma 26',
    'Turma 36',
    'Turma 25',
    'Turma 19',
    'Turma 15',
    'Turma 10',
  ];
  @observable
  List candidatesFilter = [];
  @observable
  List dataCandidates = [
    // {
    //   'name': 'Marcus',
    //   'age': 21,
    //   'qttVotes': 95.0,
    //   'turma': 26,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Marcus',
    //   'age': 21,
    //   'qttVotes': 95.0,
    //   'turma': 36,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Marcus',
    //   'age': 21,
    //   'qttVotes': 95.0,
    //   'turma': 25,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Ana Carolina',
    //   'age': 22,
    //   'qttVotes': 56.0,
    //   'turma': 19,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Carlos',
    //   'age': 20,
    //   'qttVotes': 47.0,
    //   'turma': 15,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 10,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 26,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 36,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 25,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 19,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 15,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 10,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 26,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 36,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Austim',
    //   'age': 21,
    //   'qttVotes': 84.0,
    //   'turma': 25,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 19,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 15,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 10,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 26,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 36,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Jhon',
    //   'age': 21,
    //   'qttVotes': 86.0,
    //   'turma': 25,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 19,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 15,
    //   'e-mail': 'teste@gmail.com'
    // },
    // {
    //   'name': 'Edgar',
    //   'age': 21,
    //   'qttVotes': 85.0,
    //   'turma': 10,
    //   'e-mail': 'teste@gmail.com'
    // },
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
                if (item['name'] == 'Juliana')
                  dataCandidates.add({
                    'name': item['name'],
                    'age': age,
                    'turma':
                        item['idTurma'].toString().replaceAll('Turma ', ''),
                    'qttVotes': 40.0,
                    'e-mail': item['userEmail']
                  });
                else
                  dataCandidates.add({
                    'name': item['name'],
                    'age': age,
                    'turma':
                        item['idTurma'].toString().replaceAll('Turma ', ''),
                    'qttVotes': 80.0,
                    'e-mail': item['userEmail']
                  });
                organizerData();
                func.call();
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
}
