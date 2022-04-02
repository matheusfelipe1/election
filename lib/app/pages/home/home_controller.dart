import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  List dataCandidates = [
    {'name': 'Matheus', 'age': 21, 'turma': '26', 'qttVotes': 76.0},
    {'name': 'Ana Carolina', 'age': 22, 'turma': '25', 'qttVotes': 79.0},
    {'name': 'Joel', 'age': 20, 'turma': '27', 'qttVotes': 72.0},
    {'name': 'Carla', 'age': 21, 'turma': '29', 'qttVotes': 80.0},
    {'name': 'Aurora', 'age': 22, 'turma': '21', 'qttVotes': 95.0},
    {'name': 'Benício', 'age': 26, 'turma': '22', 'qttVotes': 50.0},
    {'name': 'Marta', 'age': 25, 'turma': '23', 'qttVotes': 40.0},
  ];
  @observable
  List data = [];

  @action
  organizerData() {
    dataCandidates.sort((a, b) {
      if (b['qttVotes'] < a['qttVotes']) return -1;
      if (b['qttVotes'] > a['qttVotes']) return 1;
      return 0;
    });
    data = dataCandidates;
  }
}
