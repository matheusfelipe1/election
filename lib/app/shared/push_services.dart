// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_notifications.dart';

class PushService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  config() async {
    if (Platform.isIOS)
      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        sound: true,
      );

    var token = await messaging.getToken();
    print(token);

    var shared = await SharedPreferences.getInstance();
    shared.setString('deviceId', token!);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      NotificationsCall().showNotification(
          message.hashCode, message.data['title']!, message.data['body']!);
    });
  }
}
