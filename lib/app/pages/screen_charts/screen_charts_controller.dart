import 'package:election/app/pages/screen_charts/screen_charts.dart';
import 'package:mobx/mobx.dart';

part 'screen_charts_controller.g.dart';

class ScreenChartsController = _ScreenChartsControllerBase
    with _$ScreenChartsController;

abstract class _ScreenChartsControllerBase with Store {
  @observable
  List dataCandidates = [
    {'name': 'Marcus', 'age': 21, 'qttVotes': 95.0},
    {'name': 'Ana Carolina', 'age': 22, 'qttVotes': 56.0},
    {'name': 'Carlos', 'age': 20, 'qttVotes': 47.0},
    {'name': 'Edgar', 'age': 21, 'qttVotes': 85.0},
  ];
  // @observable
  final List<SubscriberSeries> data = [];
  @action
  organizerData() {
    dataCandidates.sort((a, b) {
      if (b['qttVotes'] < a['qttVotes']) return -1;
      if (b['qttVotes'] > a['qttVotes']) return 1;
      return 0;
    });
  }
}
