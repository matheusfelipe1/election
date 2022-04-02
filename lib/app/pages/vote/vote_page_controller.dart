import 'package:mobx/mobx.dart';

part 'vote_page_controller.g.dart';

class VotePageController = _VotePageControllerBase with _$VotePageController;

abstract class _VotePageControllerBase with Store {
  @observable
  List dataCandidates = [
    {'name': 'Marcus', 'age': 21, 'qttVotes': 95.0},
    {'name': 'Ana Carolina', 'age': 22, 'qttVotes': 56.0},
    {'name': 'Carlos', 'age': 20, 'qttVotes': 47.0},
    {'name': 'Edgar', 'age': 21, 'qttVotes': 85.0},
  ];
  @action
  organizerData() {
    dataCandidates.sort((a, b) {
      if (b['qttVotes'] < a['qttVotes']) return -1;
      if (b['qttVotes'] > a['qttVotes']) return 1;
      return 0;
    });
  }
}
