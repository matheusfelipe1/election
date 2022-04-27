import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'winner_controller.g.dart';

class WinnerController = _WinnerControllerBase with _$WinnerController;

abstract class _WinnerControllerBase with Store {}
