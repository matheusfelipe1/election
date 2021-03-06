import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'register_view_controller.g.dart';

class RegisterViewController = _RegisterViewControllerBase
    with _$RegisterViewController;

abstract class _RegisterViewControllerBase with Store {
  @observable
  var pathImage;
  final _http = CustomHttp();

  @observable
  TextEditingController email = new TextEditingController();
  @observable
  TextEditingController password = new TextEditingController();
  @observable
  TextEditingController name = new TextEditingController();
  @observable
  TextEditingController confirmedPassword = new TextEditingController();
  @observable
  bool isAdmin = false;
  @observable
  TextEditingController datNasc = new TextEditingController();
  @observable
  TextEditingController matricula = new TextEditingController();
  @observable
  String idTurma = '';
  @observable
  dynamic base64ToSend;
  @observable
  String extensionn = '';
  @observable
  String filename = '';
  @observable
  String urlImage = '';
  @observable
  XFile? fileSend;
  @observable
  List<String> teams = ['Selecione sua turma'];
  @observable
  VoidCallback? func;

  _RegisterViewControllerBase() {
    _init();
  }

  _init() {}
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
    print(file!.path);

    if (file != null) {
      fileSend = file;
      // await sendPhoto(file);
      Modular.to.pop();
      var newFile = await file.readAsBytes();
      // base64ToSend = base64.encode(await file.readAsBytes());

      pathImage = newFile;
      func.call();
    }
  }

  @action
  sendRequest() {
    Modular.to.pushNamed('/register-ok');
  }

  @action
  registerUser(BuildContext context) async {
    UtilsModalMessage().loading(1);
    try {
      if (fileSend != null) {
        await sendPhoto(fileSend);
      }
      final map = {
        "email": email.text.toString(),
        "password": password.text.toString(),
        "displayName": name.text.toString(),
        "admin": isAdmin,
        "datNasc": datNasc.text.toString(),
        "matricula": matricula.text.toString(),
        "idTurma": idTurma.toString(),
        "urlFoto": urlImage,
      };

      Response response =
          await _http.client.post('/v1/createUser', data: json.encode(map));
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['STATUS'] == 'SUCCESS') {
          UtilsModalMessage()
              .generalToast(title: 'Usu??rio cadastrado com sucesso');
          UtilsModalMessage().loading(0);
          return Modular.to.pushNamed('/register-ok');
        } else {
          UtilsModalMessage().loading(0);
          UtilsModalMessage().generalToast(title: 'Erro ao cadastrar usu??rio');
        }
      }
      print(response.data);
      UtilsModalMessage().loading(0);
      UtilsModalMessage().generalToast(title: 'Erro ao cadastrar usu??rio');
    } catch (e) {
      print(e);
      await UtilsModalMessage().loading(0);
      UtilsModalMessage().generalToast(title: 'Erro ao cadastrar usu??rio');
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
      print(await ref.getDownloadURL());

      // return Future.value(uploadTask);
    } catch (e) {
      print(e);
    }
  }

  @action
  getTeams() async {
    UtilsModalMessage().loading(1);
    try {
      Response response = await _http.client.get('/v1/get-teams');
      if (response.statusCode == 200) {
        var result = response.data;
        if (result['STATUS'] == 'SUCCESS') {
          print(result['DATA']);
          var finalResult = result['DATA'];
          finalResult.forEach((element) {
            teams.add(element['turma']);
          });
          UtilsModalMessage().loading(0);
          print(teams);
          func!.call();
        }
      }
    } catch (e) {
      print(e);
      UtilsModalMessage().loading(0);
    }
  }
}
