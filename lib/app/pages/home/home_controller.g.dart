// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$dataCandidatesAtom =
      Atom(name: '_HomeControllerBase.dataCandidates', context: context);

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

  late final _$dataAtom =
      Atom(name: '_HomeControllerBase.data', context: context);

  @override
  List<dynamic> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(List<dynamic> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$valuesAtom =
      Atom(name: '_HomeControllerBase.values', context: context);

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

  @override
  ObservableFuture getAllCandidates() {
    final _$future = super.getAllCandidates();
    return ObservableFuture(_$future, context: context);
  }

  late final _$getDataInRealtimeAsyncAction =
      AsyncAction('_HomeControllerBase.getDataInRealtime', context: context);

  @override
  Future getDataInRealtime() {
    return _$getDataInRealtimeAsyncAction.run(() => super.getDataInRealtime());
  }

  late final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase', context: context);

  @override
  dynamic organizerData() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.organizerData');
    try {
      return super.organizerData();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataCandidates: ${dataCandidates},
data: ${data},
values: ${values}
    ''';
  }
}
