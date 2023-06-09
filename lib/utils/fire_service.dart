//Set Notification With Firebase Messaging

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static NotificationService notificationService = NotificationService._();

  NotificationService._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  initNotification() async {
    AndroidInitializationSettings androidSetting =
    AndroidInitializationSettings('appicon');
    DarwinInitializationSettings ioSsettings = DarwinInitializationSettings();
    InitializationSettings initializationSettings =
    InitializationSettings(android: androidSetting, iOS: ioSsettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showSimpleNotification() {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails("1", "Flutter");
    DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        iOS: darwinNotificationDetails, android: androidNotificationDetails);
    flutterLocalNotificationsPlugin.show(
        1, "Flutter notification", "simple notification", notificationDetails);
  }

  Future<String> uriToBase64(String link) async {
    var response = await http.get(Uri.parse(link));
    var bs64 = base64Encode(response.bodyBytes);
    return bs64;
  }

  Future<void> showFireNotification(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        "1", "Andorid");
    DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
  await  flutterLocalNotificationsPlugin.show(1, "$title", "$body", notificationDetails);
  }
}
