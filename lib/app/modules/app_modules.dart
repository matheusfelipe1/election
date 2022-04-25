// ignore_for_file: prefer_const_constructors

import 'package:election/app/components/bottom_navigation/bottom_navigation.dart';
import 'package:election/app/pages/admin_user/relatorio_admin/report_user_controller.dart';
import 'package:election/app/pages/charts_all_turmas/page_chart_controller.dart';
import 'package:election/app/pages/charts_all_turmas/switch_turma/switch_turma.dart';
import 'package:election/app/pages/home/home_controller.dart';
import 'package:election/app/pages/login/login.dart';
import 'package:election/app/pages/profile/profile_details/profile_details.dart';
import 'package:election/app/pages/profile/profile_details/profile_details_controller.dart';
import 'package:election/app/pages/profile/profile_edit/profile_edit.dart';
import 'package:election/app/pages/profile/profile_edit/profile_edit_controller.dart';
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
        Bind((i) => ProfileEditController()),
        Bind((i) => ProfileDetailsController()),
        Bind((i) => ReportUserController()),
        Bind((i) => PageChartController()),
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
        ChildRoute('/profile-details',
            child: (_, args) => ProfileDetails(
                  data: args.data,
                ),
            transition: TransitionType.fadeIn),
        ChildRoute('/profile-edit',
            child: (_, args) => ProfileEdit(),
            transition: TransitionType.fadeIn),
        ChildRoute('/list-charts',
            child: (_, args) => SwitchCharts(),
            transition: TransitionType.fadeIn),
      ];
}
