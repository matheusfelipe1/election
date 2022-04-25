// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_view_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RegisterViewController on _RegisterViewControllerBase, Store {
  late final _$pathImageAtom =
      Atom(name: '_RegisterViewControllerBase.pathImage', context: context);

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

  late final _$showModalGetPhotoAsyncAction = AsyncAction(
      '_RegisterViewControllerBase.showModalGetPhoto',
      context: context);

  @override
  Future showModalGetPhoto(BuildContext context, VoidCallback func) {
    return _$showModalGetPhotoAsyncAction
        .run(() => super.showModalGetPhoto(context, func));
  }

  late final _$accessGalleryOrCameraAsyncAction = AsyncAction(
      '_RegisterViewControllerBase.accessGalleryOrCamera',
      context: context);

  @override
  Future accessGalleryOrCamera(ImageSource source, VoidCallback func) {
    return _$accessGalleryOrCameraAsyncAction
        .run(() => super.accessGalleryOrCamera(source, func));
  }

  late final _$_RegisterViewControllerBaseActionController =
      ActionController(name: '_RegisterViewControllerBase', context: context);

  @override
  dynamic sendRequest() {
    final _$actionInfo = _$_RegisterViewControllerBaseActionController
        .startAction(name: '_RegisterViewControllerBase.sendRequest');
    try {
      return super.sendRequest();
    } finally {
      _$_RegisterViewControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pathImage: ${pathImage}
    ''';
  }
}
