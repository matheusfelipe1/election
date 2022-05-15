// ignore_for_file: unnecessary_this

import 'dart:core';

class UserModel {
  late String userId;
  late String email;
  late String name;
  late bool admin;
  late String idTurma;
  late String urlFoto;
  late String datNasc;
  late String matricula;
  late bool alredyVoted;
  late bool candidate;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.admin,
    required this.idTurma,
    required this.urlFoto,
    required this.datNasc,
    required this.matricula,
    required this.alredyVoted,
    required this.candidate,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    admin = json['admin'];
    name = json['name'];
    email = json['userEmail'];
    idTurma = json['idTurma'];
    urlFoto = json['urlFoto'];
    datNasc = json['datNasc'];
    matricula = json['matricula'];
    alredyVoted = json['alreadyVoted'];
    candidate = json['candidate'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['admin'] = this.name;
    data['name'] = this.email;
    data['email'] = this.admin;
    data['idTurma'] = this.idTurma;
    data['urlFoto'] = this.urlFoto;
    data['datNasc'] = this.datNasc;
    data['matricula'] = this.matricula;
    data['alredyVoted'] = this.alredyVoted;
    data['candidate'] = this.candidate;

    return data;
  }
}
