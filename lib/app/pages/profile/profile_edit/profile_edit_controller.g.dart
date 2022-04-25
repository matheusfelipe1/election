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

  @override
  String toString() {
    return '''
pathImage: ${pathImage}
    ''';
  }
}
