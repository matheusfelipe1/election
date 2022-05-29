import 'package:age_calculator/age_calculator.dart';
import 'package:dio/dio.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'accept_admin_controller.g.dart';

class AcceptAdminController = _AcceptAdminControllerBase
    with _$AcceptAdminController;

abstract class _AcceptAdminControllerBase with Store {
  final _http = CustomHttp();

  @observable
  List users = [];

  @observable
  late VoidCallback func;

  @observable
  getAllUsers() async {
    UtilsModalMessage().loading(1);
    try {
      Response resp = await _http.client.get('/v1/get-all-admin');
      if (resp.statusCode == 200) {
        if (resp.data['STATUS'] == 'SUCCESS') {
          var result = resp.data['DATA'];
          if (result is List) {
            for (var item in result) {
              if (item is Map && item['aproved'] == false) {
                var age;
                var date =
                    item['datNasc'].toString().split('/').reversed.join('-');
                DateTime newAge = DateTime.parse(date);
                DateDuration duration;
                duration = AgeCalculator.age(newAge);
                age = duration.years;

                users.add({
                  'name': item['name'],
                  'age': age,
                  'turma': item['idTurma'].toString().replaceAll('Turma ', ''),
                  'e-mail': item['userEmail'],
                  'id': item['userId'],
                  'foto': item['urlFoto']
                });
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
