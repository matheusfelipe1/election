import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsCall {
  int ctt = 0;
  showNotification(int hash, String title, String body) async {
    try {
      ctt++;
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      final InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
      print("_firebaseMessagingBackgroundHandler Clicked!");
      flutterLocalNotificationsPlugin.show(
          ctt,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'election-notification',
              'election-notification',
              channelDescription: 'push notification for Election',
              enableVibration: true,
              playSound: true,
              importance: Importance.high,
              priority: Priority.high,
              showWhen: true,
            ),
          ));
    } catch (e) {
      print(e);
    }
  }
}
