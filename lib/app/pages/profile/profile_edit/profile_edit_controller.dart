import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'profile_edit_controller.g.dart';

class ProfileEditController = _ProfileEditControllerBase
    with _$ProfileEditController;

abstract class _ProfileEditControllerBase with Store {
  final _http = CustomHttp();
  @observable
  var pathImage;
  @observable
  TextEditingController email = new TextEditingController();
  @observable
  TextEditingController password = new TextEditingController();
  @observable
  TextEditingController name = new TextEditingController();
  @observable
  TextEditingController confirmedPassword = new TextEditingController();
  @observable
  TextEditingController datNasc = new TextEditingController();
  @observable
  TextEditingController matricula = new TextEditingController();
  @observable
  AuthController auth = Modular.get<AuthController>();
  @observable
  String urlFoto = '';
  @observable
  String urlImage = '';
  @observable
  XFile? fileSend;

  @action
  renderValues() {
    name.text = auth.user.name;
    email.text = auth.user.email;
    matricula.text = auth.user.matricula;
    datNasc.text = auth.user.datNasc;
  }

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
      fileSend = file;
      urlFoto = '';
      Modular.to.pop();
      var newFile = await file.readAsBytes();
      pathImage = newFile;
      func.call();
    }
  }

  @action
  sendPhoto(XFile? file) async {
    try {
      FirebaseStorage firebase = FirebaseStorage.instance;

      // Create a Reference to the file
      var date = DateTime.now().toIso8601String();
      Reference ref = firebase.ref().child('$date.jpg');

      final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file!.path});

      await ref.putFile(File(file.path), metadata).then((p0) async {
        urlImage = await p0.ref.getDownloadURL();
      });
      // print(await ref.getDownloadURL());

      // return Future.value(uploadTask);
    } catch (e) {
      print(e);
    }
  }

  @action
  editUser(BuildContext context) async {
    UtilsModalMessage().loading(1);
    try {
      if (fileSend != null) {
        await sendPhoto(fileSend);
      }
      print(urlImage);
      final map = {
        "email": email.text.toString(),
        "password": password.text.toString(),
        "displayName": name.text.toString(),
        "admin": auth.user.admin,
        "datNasc": datNasc.text.toString(),
        "matricula": matricula.text.toString(),
        "idTurma": auth.user.idTurma,
        "urlFoto": urlImage,
      };

      Response response = await _http.client
          .post('/v1/updateUser/${auth.user.userId}', data: json.encode(map));
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['STATUS'] == 'SUCCESS') {
          UtilsModalMessage()
              .generalToast(title: 'Usuário atualizado com sucesso');
          UtilsModalMessage().loading(0);
          await auth.getUser();
          return Modular.to.pushNamed('/navigation');
        } else {
          UtilsModalMessage().loading(0);
          UtilsModalMessage().generalToast(title: 'Erro ao atualizar usuário');
        }
      }
      print(response.data);
      UtilsModalMessage().loading(0);
      UtilsModalMessage().generalToast(title: 'Erro ao atualizar usuário');
    } catch (e) {
      print(e);
      await UtilsModalMessage().loading(0);
      UtilsModalMessage().generalToast(title: 'Erro ao atualizar usuário');
    }
  }
}
