// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VotePageController on _VotePageControllerBase, Store {
  final _$dataCandidatesAtom =
      Atom(name: '_VotePageControllerBase.dataCandidates');

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

  final _$_VotePageControllerBaseActionController =
      ActionController(name: '_VotePageControllerBase');

  @override
  dynamic organizerData() {
    final _$actionInfo = _$_VotePageControllerBaseActionController.startAction(
        name: '_VotePageControllerBase.organizerData');
    try {
      return super.organizerData();
    } finally {
      _$_VotePageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic vote(String id) {
    final _$actionInfo = _$_VotePageControllerBaseActionController.startAction(
        name: '_VotePageControllerBase.vote');
    try {
      return super.vote(id);
    } finally {
      _$_VotePageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataCandidates: ${dataCandidates}
    ''';
  }
}
