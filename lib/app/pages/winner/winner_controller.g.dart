// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'winner_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WinnerController on _WinnerControllerBase, Store {
  late final _$dateTodayAtom =
      Atom(name: '_WinnerControllerBase.dateToday', context: context);

  @override
  DateTime get dateToday {
    _$dateTodayAtom.reportRead();
    return super.dateToday;
  }

  @override
  set dateToday(DateTime value) {
    _$dateTodayAtom.reportWrite(value, super.dateToday, () {
      super.dateToday = value;
    });
  }

  late final _$dateAtom =
      Atom(name: '_WinnerControllerBase.date', context: context);

  @override
  DateTime get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(DateTime value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  late final _$dateFirstAtom =
      Atom(name: '_WinnerControllerBase.dateFirst', context: context);

  @override
  DateTime get dateFirst {
    _$dateFirstAtom.reportRead();
    return super.dateFirst;
  }

  @override
  set dateFirst(DateTime value) {
    _$dateFirstAtom.reportWrite(value, super.dateFirst, () {
      super.dateFirst = value;
    });
  }

  late final _$dateLastAtom =
      Atom(name: '_WinnerControllerBase.dateLast', context: context);

  @override
  DateTime get dateLast {
    _$dateLastAtom.reportRead();
    return super.dateLast;
  }

  @override
  set dateLast(DateTime value) {
    _$dateLastAtom.reportWrite(value, super.dateLast, () {
      super.dateLast = value;
    });
  }

  late final _$dateCalcAtom =
      Atom(name: '_WinnerControllerBase.dateCalc', context: context);

  @override
  DateTime get dateCalc {
    _$dateCalcAtom.reportRead();
    return super.dateCalc;
  }

  @override
  set dateCalc(DateTime value) {
    _$dateCalcAtom.reportWrite(value, super.dateCalc, () {
      super.dateCalc = value;
    });
  }

  late final _$myDurationAtom =
      Atom(name: '_WinnerControllerBase.myDuration', context: context);

  @override
  Duration get myDuration {
    _$myDurationAtom.reportRead();
    return super.myDuration;
  }

  @override
  set myDuration(Duration value) {
    _$myDurationAtom.reportWrite(value, super.myDuration, () {
      super.myDuration = value;
    });
  }

  late final _$countingAtom =
      Atom(name: '_WinnerControllerBase.counting', context: context);

  @override
  bool get counting {
    _$countingAtom.reportRead();
    return super.counting;
  }

  @override
  set counting(bool value) {
    _$countingAtom.reportWrite(value, super.counting, () {
      super.counting = value;
    });
  }

  late final _$setDateValidInRealtimeAsyncAction = AsyncAction(
      '_WinnerControllerBase.setDateValidInRealtime',
      context: context);

  @override
  Future<bool> setDateValidInRealtime(String date) {
    return _$setDateValidInRealtimeAsyncAction
        .run(() => super.setDateValidInRealtime(date));
  }

  late final _$getDataInRealtimeAsyncAction =
      AsyncAction('_WinnerControllerBase.getDataInRealtime', context: context);

  @override
  Future<bool> getDataInRealtime() {
    return _$getDataInRealtimeAsyncAction.run(() => super.getDataInRealtime());
  }

  @override
  String toString() {
    return '''
dateToday: ${dateToday},
date: ${date},
dateFirst: ${dateFirst},
dateLast: ${dateLast},
dateCalc: ${dateCalc},
myDuration: ${myDuration},
counting: ${counting}
    ''';
  }
}
