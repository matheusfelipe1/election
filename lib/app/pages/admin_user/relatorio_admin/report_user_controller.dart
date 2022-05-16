import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

part 'report_user_controller.g.dart';

class ReportUserController = _ReportUserControllerBase
    with _$ReportUserController;

abstract class _ReportUserControllerBase with Store {
  final _http = CustomHttp();
  var fileN;
  late VoidCallback func;
  @observable
  List<dynamic> dataCandidates = [
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
  @observable
  List<dynamic> data = [];

  @action
  organizerData() {
    dataCandidates.sort((a, b) {
      if (b['qttVotes'] < a['qttVotes']) return -1;
      if (b['qttVotes'] > a['qttVotes']) return 1;
      return 0;
    });
  }

  @action
  dynamic filterDatas(String turma) {
    var newQuery = turma.toString().split(' ').last;
    data = dataCandidates
        .where((element) => element['turma'].toString() == newQuery)
        .toList();
  }

  @observable
  createFileXlsx(VoidCallback func) async {
    try {
      if (data.length == 0)
        UtilsModalMessage().generalToast(
            title:
                'Selecione uma turma que contenha candidatos a representante de turma');
      else {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }

        String outputFile = "/storage/emulated/0/Download";

        final pw.Document pdf = pw.Document(deflate: zlib.encode);

        var arrayN = [];
        for (var item in data) {
          var newData = item
              .toString()
              .replaceAll('name', 'Nome')
              .replaceAll('age', 'Idade')
              .replaceAll('turma', 'Turma')
              .replaceAll('qttVotes', 'Votos')
              .replaceAll('e-mail', 'E-mail');
          arrayN.add(newData);
        }
        arrayN.clear();
        for (var item in data) {
          item.forEach((k, v) => arrayN.add(v));
        }
        var length = (arrayN.length / 5).toInt();
        arrayN[length - 1];

        pdf.addPage(pw.MultiPage(build: (context) => buildContent(context)));
        var vwluee = DateTime.now().microsecondsSinceEpoch.toString();

        Future<Uint8List> fileBytes = pdf.save();
        final String path = '$outputFile/$vwluee.pdf';
        final File file = File(path);
        file.writeAsBytesSync(await pdf.save());
        String url = 'http://docs.google.com/viewer?url=$path';
        print(path);
        await OpenFile.open(path);
      }
    } catch (e) {
      print(e);
      print('erro');
      UtilsModalMessage().generalToast(title: 'Erro ao visualizar PDF.');
    }
  }

  @action
  List<pw.Widget> buildContent(pw.Context context) {
    return [
      pw.Padding(
          padding: pw.EdgeInsets.all(0),
          child: pw.Container(
              child: pw.Column(children: [
            pw.Padding(
              padding: const pw.EdgeInsets.all(16.0),
              child: pw.Text('Relatório da turma ',
                  style: pw.TextStyle(fontSize: 25.0)),
            ),
            pw.Table(
                defaultColumnWidth: pw.FixedColumnWidth(120.0),
                border:
                    pw.TableBorder.all(style: pw.BorderStyle.solid, width: 2),
                children: [
                  pw.TableRow(children: [
                    pw.Column(children: [
                      pw.Text('Nome', style: pw.TextStyle(fontSize: 20.0))
                    ]),
                    pw.Column(children: [
                      pw.Text('Idade', style: pw.TextStyle(fontSize: 20.0))
                    ]),
                    pw.Column(children: [
                      pw.Text('Votos', style: pw.TextStyle(fontSize: 20.0))
                    ]),
                    pw.Column(children: [
                      pw.Text('Turma', style: pw.TextStyle(fontSize: 20.0))
                    ]),
                    pw.Column(children: [
                      pw.Text('E-mail', style: pw.TextStyle(fontSize: 20.0))
                    ]),
                  ])
                ]),
            pw.ListView.builder(
                itemBuilder: (pw.Context context, int i) {
                  return pw.Container(
                      child: pw.Table(
                          defaultColumnWidth: pw.FixedColumnWidth(120.0),
                          border: pw.TableBorder.all(
                              style: pw.BorderStyle.solid, width: 2),
                          children: [
                        pw.TableRow(children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Column(children: [
                              pw.Text(data[i]['name'].toString(),
                                  style: pw.TextStyle(fontSize: 15.0))
                            ]),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Column(children: [
                              pw.Text(data[i]['age'].toString(),
                                  style: pw.TextStyle(fontSize: 15.0))
                            ]),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Column(children: [
                              pw.Text(data[i]['qttVotes'].toString(),
                                  style: pw.TextStyle(fontSize: 15.0))
                            ]),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Column(children: [
                              pw.Text(data[i]['turma'].toString(),
                                  style: pw.TextStyle(fontSize: 15.0))
                            ]),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Column(children: [
                              pw.Text(data[i]['e-mail'].toString(),
                                  style: pw.TextStyle(fontSize: 15.0))
                            ]),
                          ),
                        ])
                      ]));
                },
                itemCount: data.length)
          ])))
    ];
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
