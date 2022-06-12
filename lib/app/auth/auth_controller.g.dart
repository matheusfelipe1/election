// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthControllerBase, Store {
  late final _$idAtom = Atom(name: '_AuthControllerBase.id', context: context);

  @override
  String get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$userAtom =
      Atom(name: '_AuthControllerBase.user', context: context);

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$getUserAsyncAction =
      AsyncAction('_AuthControllerBase.getUser', context: context);

  @override
  Future getUser() {
    return _$getUserAsyncAction.run(() => super.getUser());
  }

  late final _$deleteProfileAsyncAction =
      AsyncAction('_AuthControllerBase.deleteProfile', context: context);

  @override
  Future deleteProfile() {
    return _$deleteProfileAsyncAction.run(() => super.deleteProfile());
  }

  late final _$loggoutAsyncAction =
      AsyncAction('_AuthControllerBase.loggout', context: context);

  @override
  Future loggout() {
    return _$loggoutAsyncAction.run(() => super.loggout());
  }

  late final _$saveDeviceTokenAsyncAction =
      AsyncAction('_AuthControllerBase.saveDeviceToken', context: context);

  @override
  Future saveDeviceToken() {
    return _$saveDeviceTokenAsyncAction.run(() => super.saveDeviceToken());
  }

  late final _$verifyAproveRegisterAsyncAction =
      AsyncAction('_AuthControllerBase.verifyAproveRegister', context: context);

  @override
  Future verifyAproveRegister() {
    return _$verifyAproveRegisterAsyncAction
        .run(() => super.verifyAproveRegister());
  }

  late final _$verifyDeviceInDataBaseAsyncAction = AsyncAction(
      '_AuthControllerBase.verifyDeviceInDataBase',
      context: context);

  @override
  Future<bool> verifyDeviceInDataBase() {
    return _$verifyDeviceInDataBaseAsyncAction
        .run(() => super.verifyDeviceInDataBase());
  }

  late final _$listenDataBaseAsyncAction =
      AsyncAction('_AuthControllerBase.listenDataBase', context: context);

  @override
  Future listenDataBase() {
    return _$listenDataBaseAsyncAction.run(() => super.listenDataBase());
  }

  @override
  String toString() {
    return '''
id: ${id},
user: ${user}
    ''';
  }
}
