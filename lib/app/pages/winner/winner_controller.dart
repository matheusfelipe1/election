import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'winner_controller.g.dart';

class WinnerController = _WinnerControllerBase with _$WinnerController;

abstract class _WinnerControllerBase with Store {
  final _http = CustomHttp();
  @observable
  DateTime dateToday = DateTime.now();
  @observable
  DateTime date = DateTime.now();
  @observable
  DateTime dateFirst = DateTime.parse('2022-01-01 00:00:00.000');
  @observable
  DateTime dateLast = DateTime.parse('2022-12-31 00:00:00.000');
  @observable
  DateTime dateCalc = DateTime.parse('2022-05-05T00:00:00Z');
  @observable
  Duration myDuration = Duration(days: 5);
  @observable
  bool counting = false;
  VoidCallback? func;
  @observable
  List dataCandidates = [];
  @action
  Future<bool> setDateValidInRealtime(String date) async {
    try {
      await getAllCandidates();
      await FirebaseDatabase.instance
          .reference()
          .child('isInProgress')
          .set(true)
          .asStream();
      await FirebaseDatabase.instance
          .reference()
          .child('validDate')
          .set(date)
          .asStream();
      return true;
    } catch (e) {
      return false;
    }
  }

  @action
  Future<bool> getDataInRealtime() async {
    try {
      UtilsModalMessage().loading(1);
      DataSnapshot dataSnapshot = await FirebaseDatabase.instance
          .reference()
          .child('isInProgress')
          .once();
      DataSnapshot dataSnapshotDate =
          await FirebaseDatabase.instance.reference().child('validDate').once();
      if (dataSnapshotDate.value != null &&
          dataSnapshot.value != null &&
          dataSnapshot.value == true) {
        dateToday = DateTime.parse(dataSnapshotDate.value);
        counting = true;
        UtilsModalMessage().loading(0);
        return true;
      } else {
        UtilsModalMessage().loading(0);
        counting = false;
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @action
  callNotifications() async {
    try {
      Response response = await _http.client.post('/v1/call-notifications');
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['STATUS'] == 'SUCCESS') {
          print(result);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  finishVotation() async {
    FirebaseDatabase.instance.reference().child('isInProgress').set(false);
    await callNotifications();
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
                dataCandidates.add(item['userId']);
                UtilsModalMessage().loading(0);
              }
            }
          }
          await resetCandidate();
        }
      }
      UtilsModalMessage().loading(0);
    } catch (e) {
      print(e);
      UtilsModalMessage().loading(0);
    }
  }

  @action
  Future<void> resetCandidate() async {
    try {
      final map = {'userIds': dataCandidates};
      Response resp = await _http.client
          .post('/v1/reset-candidate', data: json.encode(map));
    } catch (e) {
      print(e);
    }
  }
}
