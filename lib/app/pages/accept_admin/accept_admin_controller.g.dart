// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_admin_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AcceptAdminController on _AcceptAdminControllerBase, Store {
  late final _$usersAtom =
      Atom(name: '_AcceptAdminControllerBase.users', context: context);

  @override
  List<dynamic> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<dynamic> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$funcAtom =
      Atom(name: '_AcceptAdminControllerBase.func', context: context);

  @override
  VoidCallback? get func {
    _$funcAtom.reportRead();
    return super.func;
  }

  @override
  set func(VoidCallback? value) {
    _$funcAtom.reportWrite(value, super.func, () {
      super.func = value;
    });
  }

  @override
  ObservableFuture getAllUsers() {
    final _$future = super.getAllUsers();
    return ObservableFuture(_$future, context: context);
  }

  late final _$aprovarAsyncAction =
      AsyncAction('_AcceptAdminControllerBase.aprovar', context: context);

  @override
  Future aprovar(String id) {
    return _$aprovarAsyncAction.run(() => super.aprovar(id));
  }

  late final _$reprovarAsyncAction =
      AsyncAction('_AcceptAdminControllerBase.reprovar', context: context);

  @override
  Future reprovar(String id) {
    return _$reprovarAsyncAction.run(() => super.reprovar(id));
  }

  @override
  String toString() {
    return '''
users: ${users},
func: ${func}
    ''';
  }
}
