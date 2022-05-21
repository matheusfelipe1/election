import 'package:dio/dio.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final _http = CustomHttp();
  @observable
  List dataCandidates = [];
  @observable
  List data = [];
  late VoidCallback func;
  @observable
  List values = [];

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
                var obj = {
                  'name': item['name'],
                  'age': age,
                  'turma': item['idTurma'].toString().replaceAll('Turma ', ''),
                  'qttVotes': 0.0,
                  'e-mail': item['userEmail'],
                  'id': item['userId'],
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
            await organizerData();
            organizerData();
            func.call();
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
}
