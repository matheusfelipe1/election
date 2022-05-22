import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:election/app/models/user_model.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final _http = CustomHttp();

  @observable
  String id = '';
  @observable
  // ignore: unnecessary_new
  UserModel user = new UserModel(
      userId: '',
      name: '',
      email: '',
      admin: false,
      idTurma: '',
      urlFoto: '',
      datNasc: '',
      matricula: '',
      alredyVoted: false,
      candidate: false);

  _AuthControllerBase() {
    _init();
  }

  _init() async {
    // ignore: unnecessary_new
    var shared = await SharedPreferences.getInstance();
    var idGet = shared.getString('idUser');
    if (idGet != null) {
      id = idGet;
      user.userId = idGet;
      print(id);
      Future.delayed(Duration(milliseconds: 1000), () async {
        await getUser();
      });
    } else {
      Modular.to.pushNamed('/login');
    }
  }

  @action
  getUser() async {
    try {
      print(id);
      Response response = await _http.client.get('/v1/get-user-by-id/$id');
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['STATUS'] == 'SUCCESS') {
          var data = result['DATA'];
          user = UserModel.fromJson(data);
          Modular.to.pushNamed('/navigation');
        }
      } else {
        Modular.to.pushNamed('/login');
      }
    } catch (e) {
      print(e);
      print(id);
      Modular.to.pushNamed('/login');
    }
  }

  @action
  deleteProfile() async {
    UtilsModalMessage().loading(1);
    try {
      Response resp =
          await _http.client.delete('/v1/deleteUser/${user.userId}');
      if (resp.statusCode == 200) {
        print(resp.data);
        loggout();
        UtilsModalMessage().loading(0);
      }
    } catch (e) {
      print(e);
      UtilsModalMessage().loading(0);
      UtilsModalMessage()
          .generalToast(title: 'Não foi possível excluir seu perfil');
    }
  }

  @action
  loggout() async {
    print('logout');
    var shared = await SharedPreferences.getInstance();
    shared.remove('token');
    shared.remove('refreshToken');
    shared.remove('idUser');
    Modular.to.pushNamed('/login');
  }

  @action
  saveDeviceToken() async {
    try {
      var shared = await SharedPreferences.getInstance();
      var token = shared.getString('deviceId');
      final map = {'deviceId': token};
      Response response = await _http.client
          .post('/v1/register-device-id', data: json.encode(map));
      if (response.statusCode == 200) {
        var _result = response.data;
        if (_result['STATUS'] == 'SUCCESS') {
          print(_result);
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
