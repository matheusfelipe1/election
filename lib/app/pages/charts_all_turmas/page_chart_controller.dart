import 'package:election/app/pages/charts_all_turmas/page_chart_turma.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:charts_flutter/flutter.dart' as charts;
part 'page_chart_controller.g.dart';

class PageChartController = _PageChartControllerBase with _$PageChartController;

abstract class _PageChartControllerBase with Store {
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
    {
      'name': 'Marcus',
      'age': 21,
      'qttVotes': 95.0,
      'turma': 26,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Marcus',
      'age': 21,
      'qttVotes': 95.0,
      'turma': 36,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Marcus',
      'age': 21,
      'qttVotes': 95.0,
      'turma': 25,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Ana Carolina',
      'age': 22,
      'qttVotes': 56.0,
      'turma': 19,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Carlos',
      'age': 20,
      'qttVotes': 47.0,
      'turma': 15,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 10,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 26,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 36,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 25,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 19,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 15,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 10,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 26,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 36,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Austim',
      'age': 21,
      'qttVotes': 84.0,
      'turma': 25,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 19,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 15,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 10,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 26,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 36,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Jhon',
      'age': 21,
      'qttVotes': 86.0,
      'turma': 25,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 19,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 15,
      'e-mail': 'teste@gmail.com'
    },
    {
      'name': 'Edgar',
      'age': 21,
      'qttVotes': 85.0,
      'turma': 10,
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

  @action
  filter(String query) {
    var newQuery = query.toString().split(' ').last;
    var param = int.tryParse(newQuery);

    candidatesFilter =
        dataCandidates.where((element) => element['turma'] == param).toList();
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
}
