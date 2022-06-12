// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'winners_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WinnersController on _WinnersControllerBase, Store {
  late final _$dataCandidatesAtom =
      Atom(name: '_WinnersControllerBase.dataCandidates', context: context);

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
      Atom(name: '_WinnersControllerBase.data', context: context);

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
      Atom(name: '_WinnersControllerBase.values', context: context);

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

  late final _$teamsAtom =
      Atom(name: '_WinnersControllerBase.teams', context: context);

  @override
  List<dynamic> get teams {
    _$teamsAtom.reportRead();
    return super.teams;
  }

  @override
  set teams(List<dynamic> value) {
    _$teamsAtom.reportWrite(value, super.teams, () {
      super.teams = value;
    });
  }

  late final _$valuesRenderAtom =
      Atom(name: '_WinnersControllerBase.valuesRender', context: context);

  @override
  dynamic get valuesRender {
    _$valuesRenderAtom.reportRead();
    return super.valuesRender;
  }

  @override
  set valuesRender(dynamic value) {
    _$valuesRenderAtom.reportWrite(value, super.valuesRender, () {
      super.valuesRender = value;
    });
  }

  late final _$dataUsersAtom =
      Atom(name: '_WinnersControllerBase.dataUsers', context: context);

  @override
  List<dynamic> get dataUsers {
    _$dataUsersAtom.reportRead();
    return super.dataUsers;
  }

  @override
  set dataUsers(List<dynamic> value) {
    _$dataUsersAtom.reportWrite(value, super.dataUsers, () {
      super.dataUsers = value;
    });
  }

  @override
  ObservableFuture getAllCandidates() {
    final _$future = super.getAllCandidates();
    return ObservableFuture(_$future, context: context);
  }

  late final _$getDataInRealtimeAsyncAction =
      AsyncAction('_WinnersControllerBase.getDataInRealtime', context: context);

  @override
  Future getDataInRealtime() {
    return _$getDataInRealtimeAsyncAction.run(() => super.getDataInRealtime());
  }

  late final _$getTeamsAsyncAction =
      AsyncAction('_WinnersControllerBase.getTeams', context: context);

  @override
  Future getTeams() {
    return _$getTeamsAsyncAction.run(() => super.getTeams());
  }

  late final _$callNotificationAsyncAction =
      AsyncAction('_WinnersControllerBase.callNotification', context: context);

  @override
  Future callNotification() {
    return _$callNotificationAsyncAction.run(() => super.callNotification());
  }

  late final _$_WinnersControllerBaseActionController =
      ActionController(name: '_WinnersControllerBase', context: context);

  @override
  dynamic organizerData() {
    final _$actionInfo = _$_WinnersControllerBaseActionController.startAction(
        name: '_WinnersControllerBase.organizerData');
    try {
      return super.organizerData();
    } finally {
      _$_WinnersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic renderValues(String query) {
    final _$actionInfo = _$_WinnersControllerBaseActionController.startAction(
        name: '_WinnersControllerBase.renderValues');
    try {
      return super.renderValues(query);
    } finally {
      _$_WinnersControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataCandidates: ${dataCandidates},
data: ${data},
values: ${values},
teams: ${teams},
valuesRender: ${valuesRender},
dataUsers: ${dataUsers}
    ''';
  }
}
