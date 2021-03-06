// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_charts_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ScreenChartsController on _ScreenChartsControllerBase, Store {
  late final _$authAtom =
      Atom(name: '_ScreenChartsControllerBase.auth', context: context);

  @override
  AuthController get auth {
    _$authAtom.reportRead();
    return super.auth;
  }

  @override
  set auth(AuthController value) {
    _$authAtom.reportWrite(value, super.auth, () {
      super.auth = value;
    });
  }

  late final _$valuesAtom =
      Atom(name: '_ScreenChartsControllerBase.values', context: context);

  @override
  List<dynamic> get values {
    _$valuesAtom.reportRead();
    return super.values;
  }

  @override
  set values(List<dynamic> value) {
    _$valuesAtom.reportWrite(value, super.values, () {
      super.values = value;
    });
  }

  late final _$dataCandidatesAtom = Atom(
      name: '_ScreenChartsControllerBase.dataCandidates', context: context);

  @override
  List<dynamic> get dataCandidates {
    _$dataCandidatesAtom.reportRead();
    return super.dataCandidates;
  }

  @override
  set dataCandidates(List<dynamic> value) {
    _$dataCandidatesAtom.reportWrite(value, super.dataCandidates, () {
      super.dataCandidates = value;
    });
  }

  @override
  ObservableFuture getValuesCharts() {
    final _$future = super.getValuesCharts();
    return ObservableFuture(_$future, context: context);
  }

  late final _$getDataInRealtimeAsyncAction = AsyncAction(
      '_ScreenChartsControllerBase.getDataInRealtime',
      context: context);

  @override
  Future getDataInRealtime() {
    return _$getDataInRealtimeAsyncAction.run(() => super.getDataInRealtime());
  }

  late final _$_ScreenChartsControllerBaseActionController =
      ActionController(name: '_ScreenChartsControllerBase', context: context);

  @override
  dynamic organizerData() {
    final _$actionInfo = _$_ScreenChartsControllerBaseActionController
        .startAction(name: '_ScreenChartsControllerBase.organizerData');
    try {
      return super.organizerData();
    } finally {
      _$_ScreenChartsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
auth: ${auth},
values: ${values},
dataCandidates: ${dataCandidates}
    ''';
  }
}
