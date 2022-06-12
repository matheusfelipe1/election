import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:election/app/models/user_model.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:firebase_database/firebase_database.dart';
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
      aproved: false,
      blocked: false,
      candidate: false);

  _AuthControllerBase() {
    _init();
  }

  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

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
          if (user.admin) {
            if (user.aproved) {
              Modular.to.pushNamed('/navigation');
            } else {
              Modular.to.pushNamed('/passport');
            }
          } else {
            Modular.to.pushNamed('/navigation');
          }
        } else {
          Modular.to.pushNamed('/login');
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
    UtilsModalMessage().loading(1);
    await resetDeviceToken();
    UtilsModalMessage().loading(0);
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
      final map = {'deviceId': token, 'userId': user.userId};

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

  @action
  resetDeviceToken() async {
    try {
      var token = '00658';
      final map = {'deviceId': token, 'userId': user.userId};

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

  @action
  verifyAproveRegister() async {
    UtilsModalMessage().loading(1);
    try {
      Response response =
          await _http.client.get('/v1/get-user-by-id/${user.userId}');
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['STATUS'] == 'SUCCESS') {
          var data = result['DATA'];
          user = UserModel.fromJson(data);
          if (user.aproved) {
            UtilsModalMessage().loading(0);
            Modular.to.pushNamed('/navigation');
          } else {
            UtilsModalMessage().loading(0);
            UtilsModalMessage()
                .generalToast(title: 'Seu cadastro ainda não foi aprovado.');
          }
        } else {
          UtilsModalMessage().loading(0);
          UtilsModalMessage()
              .generalToast(title: 'Seu cadastro ainda não foi aprovado.');
        }
      } else {
        UtilsModalMessage().loading(0);
        UtilsModalMessage()
            .generalToast(title: 'Seu cadastro ainda não foi aprovado.');
      }
    } catch (e) {
      print(e);
      UtilsModalMessage().loading(0);
      UtilsModalMessage()
          .generalToast(title: 'Seu cadastro ainda não foi aprovado.');
    }
  }

  @action
  Future<bool> verifyDeviceInDataBase() async {
    try {
      Response response =
          await _http.client.get('/v1/get-device-id/${user.userId}');
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['STATUS'] == 'SUCCESS') {
          if (result['DATA'] != null) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  @action
  listenDataBase() async {
    // DataSnapshot value =
    //     await firebaseDatabase.reference().child('isInProgress').once();
    // if (value.value == false) Modular.to.pushNamed('/winners');
    firebaseDatabase.reference().child('isInProgress').onValue.listen((event) {
      if (event.snapshot.value != null) {
        var value = event.snapshot.value;
        if (value == false) {
          Modular.to.pushNamed('/winners');
        }
      }
    });
  }
}
