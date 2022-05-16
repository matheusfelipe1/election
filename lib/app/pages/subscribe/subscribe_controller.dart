import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'subscribe_controller.g.dart';

class SubscribeController = _SubscribeControllerBase with _$SubscribeController;

abstract class _SubscribeControllerBase with Store {
  final _http = CustomHttp();

  @observable
  AuthController auth = Modular.get<AuthController>();

  @action
  subscribe() async {
    UtilsModalMessage().loading(1);
    try {
      final map = {'userId': auth.user.userId};
      Response resp =
          await _http.client.post('/v1/subscribe', data: json.encode(map));
      if (resp.statusCode == 200) {
        var result = resp.data;
        if (result['STATUS'] == 'SUCCESS') {
          UtilsModalMessage().generalToast(
              title: 'Parabéns, agora você também é um candidato');
          UtilsModalMessage().loading(0);
          await auth.getUser();
        }
      }
      UtilsModalMessage().loading(0);
    } catch (e) {
      print(e);
      UtilsModalMessage().loading(0);
    }
  }
}
