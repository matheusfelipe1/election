import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'profile_details_controller.g.dart';

class ProfileDetailsController = _ProfileDetailsControllerBase
    with _$ProfileDetailsController;

abstract class _ProfileDetailsControllerBase with Store {
  final _http = CustomHttp();
  @observable
  AuthController auth = Modular.get<AuthController>();

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
