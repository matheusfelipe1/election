// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_chart_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PageChartController on _PageChartControllerBase, Store {
  late final _$turmaTextAtom =
      Atom(name: '_PageChartControllerBase.turmaText', context: context);

  @override
  String get turmaText {
    _$turmaTextAtom.reportRead();
    return super.turmaText;
  }

  @override
  set turmaText(String value) {
    _$turmaTextAtom.reportWrite(value, super.turmaText, () {
      super.turmaText = value;
    });
  }

  late final _$turmasAtom =
      Atom(name: '_PageChartControllerBase.turmas', context: context);

  @override
  List<String> get turmas {
    _$turmasAtom.reportRead();
    return super.turmas;
  }

  @override
  set turmas(List<String> value) {
    _$turmasAtom.reportWrite(value, super.turmas, () {
      super.turmas = value;
    });
  }

  late final _$candidatesFilterAtom =
      Atom(name: '_PageChartControllerBase.candidatesFilter', context: context);

  @override
  List<dynamic> get candidatesFilter {
    _$candidatesFilterAtom.reportRead();
    return super.candidatesFilter;
  }

  @override
  set candidatesFilter(List<dynamic> value) {
    _$candidatesFilterAtom.reportWrite(value, super.candidatesFilter, () {
      super.candidatesFilter = value;
    });
  }

  late final _$dataCandidatesAtom =
      Atom(name: '_PageChartControllerBase.dataCandidates', context: context);

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

  late final _$_PageChartControllerBaseActionController =
      ActionController(name: '_PageChartControllerBase', context: context);

  @override
  dynamic organizerData() {
    final _$actionInfo = _$_PageChartControllerBaseActionController.startAction(
        name: '_PageChartControllerBase.organizerData');
    try {
      return super.organizerData();
    } finally {
      _$_PageChartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic filter(String query) {
    final _$actionInfo = _$_PageChartControllerBaseActionController.startAction(
        name: '_PageChartControllerBase.filter');
    try {
      return super.filter(query);
    } finally {
      _$_PageChartControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
turmaText: ${turmaText},
turmas: ${turmas},
candidatesFilter: ${candidatesFilter},
dataCandidates: ${dataCandidates}
    ''';
  }
}
