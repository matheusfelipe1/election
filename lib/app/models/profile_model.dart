import 'package:election/app/pages/profile/profile_details/profile_details.dart';

class ProfileModel {
  String? userId;
  String? email;
  bool? candidate;
  bool? alredyVoted;
  String? idTurma;
  String? matricula;
  String? name;
  bool? admin;
  bool? aproved;
  String? foto;
  String? dateNasc;

  ProfileModel({
    this.userId,
    this.email,
    this.candidate,
    this.alredyVoted,
    this.idTurma,
    this.matricula,
    this.name,
    this.admin,
    this.aproved,
    this.foto,
    this.dateNasc,
  });

  ProfileModel.fromJson(Map json) {
    this.userId = json['userId'];
    this.email = json['userEmail'];
    this.candidate = json['candidate'];
    this.alredyVoted = json['alreadyVoted'];
    this.idTurma = json['idTurma'];
    this.matricula = json['matricula'];
    this.name = json['name'];
    this.admin = json['admin'];
    this.aproved = json['aproved'];
    this.foto = json['urlFoto'];
    this.dateNasc = json['datNasc'];
  }
}
