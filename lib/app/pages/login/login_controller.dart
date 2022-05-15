import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final _http = CustomHttp();
  @observable
  TextEditingController email = new TextEditingController();
  @observable
  TextEditingController password = new TextEditingController();
  @observable
  AuthController auth = Modular.get<AuthController>();

  @action
  doLogin(BuildContext context) async {
    UtilsModalMessage().showLoading(context);
    try {
      final map = {'email': email.text, 'password': password.text};
      Response resp =
          await _http.client.post('/v1/loginUser', data: json.encode(map));
      if (resp.statusCode == 200) {
        if (resp.data['STATUS'] == 'SUCCESS') {
          var resultId = resp.data['DATA']['userLoged']['user']['uid'];
          var tokens =
              resp.data['DATA']['userLoged']['user']['stsTokenManager'];
          var shared = await SharedPreferences.getInstance();
          shared.setString('token', tokens['accessToken']);
          shared.setString('refreshToken', tokens['refreshToken']);
          shared.setString('idUser', resultId);

          auth.id = resultId;
          // return Modular.to.pushNamed('/navigation');
          return auth.getUser();
        } else {
          return UtilsModalMessage()
              .generalToast(title: 'Erro ao efetuar o login.');
        }
      }

      UtilsModalMessage().generalToast(title: 'Erro ao efetuar o login.');
      return null;
    } catch (e) {
      await UtilsModalMessage().closeLoading();
      UtilsModalMessage().generalToast(title: 'Erro ao efetuar o login.');
      return null;
    }
  }
}
