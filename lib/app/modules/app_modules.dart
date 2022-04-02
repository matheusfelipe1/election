// ignore_for_file: prefer_const_constructors

import 'package:election/app/components/bottom_navigation/bottom_navigation.dart';
import 'package:election/app/pages/home/home_controller.dart';
import 'package:election/app/pages/login/login.dart';
import 'package:election/app/pages/register_ok/register_ok.dart';
import 'package:election/app/pages/screen_charts/screen_charts_controller.dart';
import 'package:election/app/pages/signup/register_view.dart';
import 'package:election/app/pages/signup/register_view_controller.dart';
import 'package:election/app/pages/splash.dart';
import 'package:election/app/pages/vote/vote_page_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => RegisterViewController()),
        Bind((i) => HomeController()),
        Bind((i) => ScreenChartsController()),
        Bind((i) => VotePageController()),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (_, args) => SplashScreen(),
            transition: TransitionType.fadeIn),
        ChildRoute('/login',
            child: (_, args) => LoginScreen(),
            transition: TransitionType.fadeIn),
        ChildRoute('/register',
            child: (_, args) => RegisterView(),
            transition: TransitionType.fadeIn),
        ChildRoute('/register-ok',
            child: (_, args) => RegisterOk(),
            transition: TransitionType.fadeIn),
        ChildRoute('/navigation',
            child: (_, args) => BottomNavigationPage(),
            transition: TransitionType.fadeIn),
      ];
}
