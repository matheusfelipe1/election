// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribe_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SubscribeController on _SubscribeControllerBase, Store {
  late final _$authAtom =
      Atom(name: '_SubscribeControllerBase.auth', context: context);

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

  late final _$subscribeAsyncAction =
      AsyncAction('_SubscribeControllerBase.subscribe', context: context);

  @override
  Future subscribe() {
    return _$subscribeAsyncAction.run(() => super.subscribe());
  }

  @override
  String toString() {
    return '''
auth: ${auth}
    ''';
  }
}
