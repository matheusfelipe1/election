import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'profile_edit_controller.g.dart';

class ProfileEditController = _ProfileEditControllerBase
    with _$ProfileEditController;

abstract class _ProfileEditControllerBase with Store {
  @observable
  var pathImage;

  @action
  showModalGetPhoto(BuildContext context, VoidCallback func) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            elevation: 5,
            contentPadding: const EdgeInsets.all(20),
            content: Column(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Deseja acessar a camera ou biblioteca?'),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              accessGalleryOrCamera(ImageSource.camera, func),
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.camera_alt),
                                Container(
                                  child: Text('Camera'),
                                  margin: EdgeInsets.only(left: 7),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              accessGalleryOrCamera(ImageSource.gallery, func),
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.photo_library_sharp),
                                Container(
                                  child: Text('Biblioteca'),
                                  margin: EdgeInsets.only(left: 7),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @action
  accessGalleryOrCamera(ImageSource source, VoidCallback func) async {
    XFile? file = await ImagePicker.platform.getImage(source: source);
    if (file != null) {
      Modular.to.pop();
      var newFile = await file.readAsBytes();
      pathImage = newFile;
      func.call();
    }
  }
}
