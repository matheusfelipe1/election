import 'dart:convert';

import 'package:age_calculator/age_calculator.dart';
import 'package:dio/dio.dart';
import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/pages/message_chat/message_chat_controller.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'accept_admin_controller.g.dart';

class AcceptAdminController = _AcceptAdminControllerBase
    with _$AcceptAdminController;

abstract class _AcceptAdminControllerBase with Store {
  final _http = CustomHttp();

  @observable
  List users = [];

  @observable
  VoidCallback? func;

  @observable
  MessageChatController messageChatController =
      Modular.get<MessageChatController>();

  @observable
  AuthController authController = Modular.get<AuthController>();

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
                  'foto': item['urlFoto'],
                  'blocked': item['blocked']
                });
                // func!.call();
                print(item);
                UtilsModalMessage().loading(0);
              }
            }
          }
        }
      }
      UtilsModalMessage().loading(0);
      func!.call();
    } catch (e) {
      print(e);
      UtilsModalMessage().loading(0);
    }
  }

  @action
  aprovar(String id) async {
    UtilsModalMessage().loading(1);
    try {
      final map = {'userId': id, 'param': 2};
      Response response =
          await _http.client.post('/v1/aprove-or-not', data: json.encode(map));
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['STATUS'] == 'SUCCESS') {
          users.removeWhere((element) => element['id'] == id);
          UtilsModalMessage().loading(0);
          UtilsModalMessage()
              .generalToast(title: 'Usu??rio aprovado com sucesso.');
          await callNotification(id, 'Aprovado',
              'Seu cadastro como usu??rio administrativo foi aprovado.');
          func!.call();
        }
      }
    } catch (e) {
      UtilsModalMessage().loading(0);
      UtilsModalMessage()
          .generalToast(title: 'Erro ao prosseguir com a solicita????o.');
    }
  }

  @action
  reprovar(String id) async {
    UtilsModalMessage().loading(1);
    try {
      final map = {'userId': id, 'param': 1};
      Response response =
          await _http.client.post('/v1/aprove-or-not', data: json.encode(map));
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['STATUS'] == 'SUCCESS') {
          UtilsModalMessage().loading(0);
          UtilsModalMessage()
              .generalToast(title: 'Usu??rio reprovado com sucesso.');
          users.forEach((element) {
            if (element['id'] == id) {
              element['blocked'] = true;
            }
          });
          await callNotification(id, 'Reprovado',
              'Seu cadastro como usu??rio administrativo foi reprovado.');
          func!.call();
        }
      }
    } catch (e) {
      UtilsModalMessage().loading(0);
      UtilsModalMessage()
          .generalToast(title: 'Erro ao prosseguir com a solicita????o.');
    }
  }

  @action
  callNotification(String id, String title, String body) async {
    try {
      final map = {
        'userId': id,
        'title': title,
        'body': body,
      };
      Response response = await _http.client
          .post('/v1/call-notifications-service', data: json.encode(map));
    } catch (e) {
      print(e);
    }
  }

  @action
  actionToCreateChat(String id, String name, String photo) async {
    var result = await messageChatController.createChat(id);
    messageChatController.idChat = result;
    final map = {
      'name': name,
      'id': messageChatController.idChat,
      'photo': photo
    };
    Modular.to.pushNamed('/details-chat', arguments: map);
  }
}
