import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/modules/app_modules.dart';
import 'app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    runApp(ModularApp(
      module: AppModule(),
      child: AppWidget(),
    ));
    configLoading();
  });
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..indicatorSize = 40.0
    ..lineWidth = 2.0
    ..radius = 30.0
    ..loadingStyle = EasyLoadingStyle.custom
    ..progressColor = Color(0xff00D7A9)
    ..backgroundColor = Color(0xff00D7A9)
    ..indicatorColor = Color(0xff00D7A9)
    ..textColor = Color(0xff00D7A9)
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
