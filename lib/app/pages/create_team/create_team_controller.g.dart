// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_team_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateTeamController on _CreateTeamControllerBase, Store {
  late final _$nameAtom =
      Atom(name: '_CreateTeamControllerBase.name', context: context);

  @override
  TextEditingController get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(TextEditingController value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$periodoAtom =
      Atom(name: '_CreateTeamControllerBase.periodo', context: context);

  @override
  TextEditingController get periodo {
    _$periodoAtom.reportRead();
    return super.periodo;
  }

  @override
  set periodo(TextEditingController value) {
    _$periodoAtom.reportWrite(value, super.periodo, () {
      super.periodo = value;
    });
  }

  late final _$cursoAtom =
      Atom(name: '_CreateTeamControllerBase.curso', context: context);

  @override
  TextEditingController get curso {
    _$cursoAtom.reportRead();
    return super.curso;
  }

  @override
  set curso(TextEditingController value) {
    _$cursoAtom.reportWrite(value, super.curso, () {
      super.curso = value;
    });
  }

  late final _$disciplinaAtom =
      Atom(name: '_CreateTeamControllerBase.disciplina', context: context);

  @override
  TextEditingController get disciplina {
    _$disciplinaAtom.reportRead();
    return super.disciplina;
  }

  @override
  set disciplina(TextEditingController value) {
    _$disciplinaAtom.reportWrite(value, super.disciplina, () {
      super.disciplina = value;
    });
  }

  late final _$funcAtom =
      Atom(name: '_CreateTeamControllerBase.func', context: context);

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

  late final _$createTeamAsyncAction =
      AsyncAction('_CreateTeamControllerBase.createTeam', context: context);

  @override
  Future createTeam() {
    return _$createTeamAsyncAction.run(() => super.createTeam());
  }

  @override
  String toString() {
    return '''
name: ${name},
periodo: ${periodo},
curso: ${curso},
disciplina: ${disciplina},
func: ${func}
    ''';
  }
}
