import 'package:election/app/models/profile_model.dart';
import 'package:mobx/mobx.dart';

class ChatModel {
  String? id;
  String? sender;
  String? recipient;
  String? date;
  ProfileModel? profileModel;
  List<Message>? messages;

  ChatModel(
      {this.id,
      this.date,
      this.recipient,
      this.sender,
      this.messages,
      this.profileModel});

  ChatModel.fromJson(Map json) {
    id = json['id'].toString();
    date = json['date'];
    recipient = json['recipient'];
    sender = json['sender'];
    var listMessages = json['messages'];
    this.messages = new ObservableList<Message>();
    if (listMessages is Map) {
      listMessages.forEach((key, value) {
        listMessages[key]['id'] = key;
      });
      for (var item in listMessages.values.toList()) {
        if (item != null) this.messages!.add(Message.fromJson(item));
      }
      this.messages!.sort(
          (a, b) => DateTime.parse(b.date!).compareTo(DateTime.parse(a.date!)));
    }
  }
}

class Message {
  String? id;
  String? date;
  String? type;
  String? sender;
  String? value;

  Message({this.id, this.date, this.type, this.sender, this.value});

  Message.fromJson(Map json) {
    id = json['id'];
    date = json['date'];
    type = json['type'];
    sender = json['sender'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['type'] = this.type;
    data['sender'] = this.sender;
    data['value'] = this.value;
    return data;
  }
}
