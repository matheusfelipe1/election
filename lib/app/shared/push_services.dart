import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  config() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      sound: true,
    );

    // var token = await messaging.getToken();
    // print(token);

    // var shared = await SharedPreferences.getInstance();
    // shared.setString('deviceId', token!);
  }
}
