// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_edit_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileEditController on _ProfileEditControllerBase, Store {
  late final _$pathImageAtom =
      Atom(name: '_ProfileEditControllerBase.pathImage', context: context);

  @override
  dynamic get pathImage {
    _$pathImageAtom.reportRead();
    return super.pathImage;
  }

  @override
  set pathImage(dynamic value) {
    _$pathImageAtom.reportWrite(value, super.pathImage, () {
      super.pathImage = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_ProfileEditControllerBase.email', context: context);

  @override
  TextEditingController get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(TextEditingController value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_ProfileEditControllerBase.password', context: context);

  @override
  TextEditingController get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(TextEditingController value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$nameAtom =
      Atom(name: '_ProfileEditControllerBase.name', context: context);

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

  late final _$confirmedPasswordAtom = Atom(
      name: '_ProfileEditControllerBase.confirmedPassword', context: context);

  @override
  TextEditingController get confirmedPassword {
    _$confirmedPasswordAtom.reportRead();
    return super.confirmedPassword;
  }

  @override
  set confirmedPassword(TextEditingController value) {
    _$confirmedPasswordAtom.reportWrite(value, super.confirmedPassword, () {
      super.confirmedPassword = value;
    });
  }

  late final _$datNascAtom =
      Atom(name: '_ProfileEditControllerBase.datNasc', context: context);

  @override
  TextEditingController get datNasc {
    _$datNascAtom.reportRead();
    return super.datNasc;
  }

  @override
  set datNasc(TextEditingController value) {
    _$datNascAtom.reportWrite(value, super.datNasc, () {
      super.datNasc = value;
    });
  }

  late final _$matriculaAtom =
      Atom(name: '_ProfileEditControllerBase.matricula', context: context);

  @override
  TextEditingController get matricula {
    _$matriculaAtom.reportRead();
    return super.matricula;
  }

  @override
  set matricula(TextEditingController value) {
    _$matriculaAtom.reportWrite(value, super.matricula, () {
      super.matricula = value;
    });
  }

  late final _$authAtom =
      Atom(name: '_ProfileEditControllerBase.auth', context: context);

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

  late final _$urlFotoAtom =
      Atom(name: '_ProfileEditControllerBase.urlFoto', context: context);

  @override
  String get urlFoto {
    _$urlFotoAtom.reportRead();
    return super.urlFoto;
  }

  @override
  set urlFoto(String value) {
    _$urlFotoAtom.reportWrite(value, super.urlFoto, () {
      super.urlFoto = value;
    });
  }

  late final _$urlImageAtom =
      Atom(name: '_ProfileEditControllerBase.urlImage', context: context);

  @override
  String get urlImage {
    _$urlImageAtom.reportRead();
    return super.urlImage;
  }

  @override
  set urlImage(String value) {
    _$urlImageAtom.reportWrite(value, super.urlImage, () {
      super.urlImage = value;
    });
  }

  late final _$fileSendAtom =
      Atom(name: '_ProfileEditControllerBase.fileSend', context: context);

  @override
  XFile? get fileSend {
    _$fileSendAtom.reportRead();
    return super.fileSend;
  }

  @override
  set fileSend(XFile? value) {
    _$fileSendAtom.reportWrite(value, super.fileSend, () {
      super.fileSend = value;
    });
  }

  late final _$showModalGetPhotoAsyncAction = AsyncAction(
      '_ProfileEditControllerBase.showModalGetPhoto',
      context: context);

  @override
  Future showModalGetPhoto(BuildContext context, VoidCallback func) {
    return _$showModalGetPhotoAsyncAction
        .run(() => super.showModalGetPhoto(context, func));
  }

  late final _$accessGalleryOrCameraAsyncAction = AsyncAction(
      '_ProfileEditControllerBase.accessGalleryOrCamera',
      context: context);

  @override
  Future accessGalleryOrCamera(ImageSource source, VoidCallback func) {
    return _$accessGalleryOrCameraAsyncAction
        .run(() => super.accessGalleryOrCamera(source, func));
  }

  late final _$sendPhotoAsyncAction =
      AsyncAction('_ProfileEditControllerBase.sendPhoto', context: context);

  @override
  Future sendPhoto(XFile? file) {
    return _$sendPhotoAsyncAction.run(() => super.sendPhoto(file));
  }

  late final _$editUserAsyncAction =
      AsyncAction('_ProfileEditControllerBase.editUser', context: context);

  @override
  Future editUser(BuildContext context) {
    return _$editUserAsyncAction.run(() => super.editUser(context));
  }

  late final _$_ProfileEditControllerBaseActionController =
      ActionController(name: '_ProfileEditControllerBase', context: context);

  @override
  dynamic renderValues() {
    final _$actionInfo = _$_ProfileEditControllerBaseActionController
        .startAction(name: '_ProfileEditControllerBase.renderValues');
    try {
      return super.renderValues();
    } finally {
      _$_ProfileEditControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pathImage: ${pathImage},
email: ${email},
password: ${password},
name: ${name},
confirmedPassword: ${confirmedPassword},
datNasc: ${datNasc},
matricula: ${matricula},
auth: ${auth},
urlFoto: ${urlFoto},
urlImage: ${urlImage},
fileSend: ${fileSend}
    ''';
  }
}
