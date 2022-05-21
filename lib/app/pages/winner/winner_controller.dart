import 'package:election/app/utils/modal_messages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'winner_controller.g.dart';

class WinnerController = _WinnerControllerBase with _$WinnerController;

abstract class _WinnerControllerBase with Store {
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
  late VoidCallback func;
  @action
  Future<bool> setDateValidInRealtime(String date) async {
    try {
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
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
