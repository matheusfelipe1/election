// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReportUserController on _ReportUserControllerBase, Store {
  late final _$dataCandidatesAtom =
      Atom(name: '_ReportUserControllerBase.dataCandidates', context: context);

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
      Atom(name: '_ReportUserControllerBase.data', context: context);

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

  @override
  ObservableFuture createFileXlsx(VoidCallback func) {
    final _$future = super.createFileXlsx(func);
    return ObservableFuture(_$future, context: context);
  }

  @override
  ObservableFuture getAllCandidates() {
    final _$future = super.getAllCandidates();
    return ObservableFuture(_$future, context: context);
  }

  late final _$_ReportUserControllerBaseActionController =
      ActionController(name: '_ReportUserControllerBase', context: context);

  @override
  dynamic organizerData() {
    final _$actionInfo = _$_ReportUserControllerBaseActionController
        .startAction(name: '_ReportUserControllerBase.organizerData');
    try {
      return super.organizerData();
    } finally {
      _$_ReportUserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic filterDatas(String turma) {
    final _$actionInfo = _$_ReportUserControllerBaseActionController
        .startAction(name: '_ReportUserControllerBase.filterDatas');
    try {
      return super.filterDatas(turma);
    } finally {
      _$_ReportUserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  List<pw.Widget> buildContent(pw.Context context) {
    final _$actionInfo = _$_ReportUserControllerBaseActionController
        .startAction(name: '_ReportUserControllerBase.buildContent');
    try {
      return super.buildContent(context);
    } finally {
      _$_ReportUserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataCandidates: ${dataCandidates},
data: ${data}
    ''';
  }
}
