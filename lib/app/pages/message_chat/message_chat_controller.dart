import 'dart:convert';
import 'dart:io';

import 'package:age_calculator/age_calculator.dart';
import 'package:dio/dio.dart';
import 'package:election/app/auth/auth_controller.dart';
import 'package:election/app/models/chat_model.dart';
import 'package:election/app/models/profile_model.dart';
import 'package:election/app/shared/custom_http.dart';
import 'package:election/app/utils/modal_messages.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'message_chat_controller.g.dart';

class MessageChatController = _MessageChatControllerBase
    with _$MessageChatController;

abstract class _MessageChatControllerBase with Store {
  final _http = CustomHttp();
  @observable
  List<dynamic> adminUsers = [];
  @observable
  List<dynamic> messages = [];
  @observable
  VoidCallback? funcList;
  @observable
  VoidCallback? func;
  @observable
  FirebaseDatabase database = FirebaseDatabase.instance;
  @observable
  AuthController _auth = Modular.get<AuthController>();
  @observable
  String reference = 'chat';
  @observable
  String senderRef = 'sender';
  @observable
  String recipientRef = 'recipient';
  @observable
  String idChat = '';
  @observable
  String personSelected = '';
  @observable
  List<ChatModel>? chats = [];
  @observable
  ChatModel? selectedChat;
  @observable
  String urlImage = '';

  _MessageChatControllerBase() {
    _init();
  }

  _init() {
    selectedChat = new ChatModel();
    initialize();
  }

  @observable
  Future<ProfileModel> getUser(String id) async {
    UtilsModalMessage().loading(1);
    ProfileModel profile = new ProfileModel();
    try {
      Response resp = await _http.client.get('/v1/get-user-by-id/$id');
      if (resp.statusCode == 200) {
        if (resp.data['STATUS'] == 'SUCCESS') {
          var result = resp.data['DATA'];
          UtilsModalMessage().loading(0);
          ProfileModel profileGet = ProfileModel.fromJson(result);
          profile = profileGet;
        }
      }
      UtilsModalMessage().loading(0);
      funcList!.call();
      await listenListMessages();
      return profile;
    } catch (e) {
      print(e);
      UtilsModalMessage().loading(0);
      return profile;
    }
  }

  @action
  getMessageInDatabase() async {
    chats!.clear();
    selectedChat!.messages!.clear();
    DataSnapshot sender = await database
        .reference()
        .child(reference)
        .orderByChild(senderRef)
        .equalTo(_auth.user.userId)
        .once();
    DataSnapshot recipient = await database
        .reference()
        .child(reference)
        .orderByChild(recipientRef)
        .equalTo(_auth.user.userId)
        .once();
    if (sender.value != null) {
      Map result = sender.value;
      result.forEach((key, value) async {
        ChatModel chatModel = ChatModel.fromJson(value);
        if (chatModel.recipient != _auth.user.userId) {
          ProfileModel? profile;
          profile = await getUser(chatModel.recipient!);
          chatModel.profileModel = profile;
        }
        if (chatModel.messages!.length > 0) {
          chatModel.messages!.reversed.toList();
          chats!.add(chatModel);
        }
      });
    }
    if (recipient.value != null) {
      Map result = recipient.value;
      result.forEach((key, value) async {
        ChatModel chatModel = ChatModel.fromJson(value);
        if (chatModel.sender != _auth.user.userId) {
          ProfileModel? profile;
          profile = await getUser(chatModel.sender!);
          chatModel.profileModel = profile;
        }
        if (chatModel.messages!.length > 0) {
          chatModel.messages!.reversed.toList();
          chats!.add(chatModel);
        }
      });
    }
  }

  @action
  Future createChat(String person) async {
    String key = database.reference().child(reference).push().key;
    database.reference().child(reference).child(key).set({
      'date': DateTime.now().toIso8601String(),
      'sender': _auth.user.userId,
      'recipient': person,
      'id': key,
    });
    personSelected = person;
    return key;
  }

  @action
  Future<void> addMessage(String text, String type) async {
    String key = database.reference().child(reference).child(idChat).push().key;
    return database
        .reference()
        .child(reference)
        .child(idChat)
        .child('messages')
        .child(key)
        .set({
      'date': DateTime.now().toIso8601String(),
      'sender': _auth.user.userId,
      'id': key,
      'type': type,
      'value': text,
    });
  }

  @observable
  initialize() {
    selectedChat!.id = idChat;
    selectedChat!.sender = _auth.user.userId;
    selectedChat!.recipient = personSelected;
    selectedChat!.messages = [];
  }

  @observable
  listenMessageInDatabase() async {
    selectedChat!.messages!.clear();
    database
        .reference()
        .child(reference)
        .child(idChat)
        .child('messages')
        .onChildAdded
        .listen((event) {
      final message = Message.fromJson(event.snapshot.value);
      message.id = event.snapshot.key;
      if (selectedChat!.messages!.where((c) => c.id == message.id).length == 0)
        selectedChat!.messages!.add(message);
      selectedChat!.messages!.sort(
          (a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
      chats!.reversed.toList();
      funcList!.call();
      func!.call();
    });
  }

  @observable
  listenListMessages() async {
    // selectedChat!.messages!.clear();
    database
        .reference()
        .child(reference)
        .orderByChild(senderRef)
        .equalTo(_auth.user.userId)
        .onChildAdded
        .listen((event) {
      print(event);
      Map result = event.snapshot.value;
      for (var item in chats!) {
        if (item.id == result['id']) {
          Map newResult = result['messages'];
          newResult.forEach((key, value) {
            Message message = Message.fromJson(value);
            item.messages!.add(message);
          });
        }
      }
      chats!.sort(
          (a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
      chats!.reversed.toList();
      funcList!.call();
    });
    database
        .reference()
        .child(reference)
        .orderByChild(recipientRef)
        .equalTo(_auth.user.userId)
        .onChildAdded
        .listen((event) {
      print(event.snapshot.value);
      Map result = event.snapshot.value;
      for (var item in chats!) {
        if (item.id == result['id']) {
          Map newResult = result['messages'];
          newResult.forEach((key, value) {
            Message message = Message.fromJson(value);
            item.messages!.add(message);
          });
        }
      }
      chats!.sort(
          (a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
      chats!.reversed.toList();
      funcList!.call();
    });
  }

  @action
  getImage(ImageSource source) async {
    XFile? file = await ImagePicker.platform.getImage(source: source);
    Modular.to.pop();
    if (file != null) {
      UtilsModalMessage().loading(1);
      FirebaseStorage firebase = FirebaseStorage.instance;

      // Create a Reference to the file
      var date = DateTime.now().toIso8601String();
      Reference ref = firebase.ref().child('$date.jpg');

      final metadata = SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': file.path});

      await ref.putFile(File(file.path), metadata).then((p0) async {
        urlImage = await p0.ref.getDownloadURL();
      });
      print(await ref.getDownloadURL());
      await addMessage(urlImage, 'image');
      UtilsModalMessage().loading(0);
    }
  }

  @action
  stopToListenUniqueChat() {
    database
        .reference()
        .child(reference)
        .child(idChat)
        .child('messages')
        .onChildAdded
        .listen((event) {})
        .cancel();
  }

  @action
  stopToListenChats() {
    database
        .reference()
        .child(reference)
        .orderByChild(recipientRef)
        .equalTo(_auth.user.userId)
        .onChildAdded
        .listen((event) {})
        .cancel();
    database
        .reference()
        .child(reference)
        .orderByChild(senderRef)
        .equalTo(_auth.user.userId)
        .onChildAdded
        .listen((event) {})
        .cancel();
  }

  @action
  callNotification(String id, String title, String body) async {
    try {
      final map = {
        'userId': selectedChat!.recipient,
        'title': title,
        'body': body,
      };
      Response response = await _http.client
          .post('/v1/call-notifications-service', data: json.encode(map));
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  @action
  aproveUser() async {
    try {
      final map = {'userId': selectedChat!.recipient};
      Response response =
          await _http.client.post('/v1/aprove', data: json.encode(map));
      if (response.statusCode == 200) {
        if (response.data['STATUS'] == 'SUCCESS') {
          await deleteChat();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @action
  deleteChat() {
    database
        .reference()
        .child(reference)
        .child(idChat)
        .child('messages')
        .remove();
  }
}
