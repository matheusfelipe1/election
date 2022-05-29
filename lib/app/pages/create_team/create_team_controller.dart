import 'package:election/app/shared/custom_http.dart';
import 'package:mobx/mobx.dart';

part 'create_team_controller.g.dart';

class CreateTeamController = _CreateTeamControllerBase
    with _$CreateTeamController;

abstract class _CreateTeamControllerBase with Store {
  final _http = CustomHttp();
}
