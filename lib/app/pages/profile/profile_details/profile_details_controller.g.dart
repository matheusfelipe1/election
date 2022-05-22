// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileDetailsController on _ProfileDetailsControllerBase, Store {
  late final _$authAtom =
      Atom(name: '_ProfileDetailsControllerBase.auth', context: context);

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

  late final _$updateVoteInDatabaseAsyncAction = AsyncAction(
      '_ProfileDetailsControllerBase.updateVoteInDatabase',
      context: context);

  @override
  Future updateVoteInDatabase(String id) {
    return _$updateVoteInDatabaseAsyncAction
        .run(() => super.updateVoteInDatabase(id));
  }

  late final _$voteCandidateAsyncAction = AsyncAction(
      '_ProfileDetailsControllerBase.voteCandidate',
      context: context);

  @override
  Future voteCandidate(String id) {
    return _$voteCandidateAsyncAction.run(() => super.voteCandidate(id));
  }

  @override
  String toString() {
    return '''
auth: ${auth}
    ''';
  }
}
