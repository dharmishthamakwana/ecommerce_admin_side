import 'dart:async';
import 'package:timezone/data/latest_all.dart' as tz;

import 'package:firebase_app/screen/modal/task_modal.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:firebase_app/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  //Only Variable's
  TextEditingController txtSignInEmail = TextEditingController();
  TextEditingController txtSignInPass = TextEditingController();
  TextEditingController txtSignUpEmail = TextEditingController();
  TextEditingController txtSignUpPass = TextEditingController();

  GlobalKey<FormState> SignUpkey = GlobalKey<FormState>();
  GlobalKey<FormState> SignInkey = GlobalKey<FormState>();

  RxBool SignUp_password_vis = true.obs;
  RxBool SignIn_password_vis = true.obs;
  RxMap data = {}.obs;

  TaskModal updatedata = TaskModal();

  //Only Function's

  Future<void> IsLogin() async {
    bool isLogin = await FirebaseHelper.firebaseHelper.checkUser();
    print("===== $isLogin");
    if (isLogin) {
      Timer(Duration(seconds: 3), () {
        Get.offNamed('note');
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Get.offNamed('SignIn');
      });
    }
  }

  RxMap userData = {}.obs;

  Future<void> userDetailFromId() async {
    userData.value = await FirebaseHelper.firebaseHelper.userDetails();
    print(userData);
  }

  RxString? msg;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void InitializeNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('appicon');

    DarwinInitializationSettings iOSInitializationSettings =
        const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);

    tz.initializeTimeZones();

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //Show Simple Notification
  Future<void> ShowSimpleNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "1",
      "Android",
      importance: Importance.high,
      priority: Priority.max,
    );

    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails(
      subtitle: "IOS",
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iOSNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(1, "Hello Everyone", "Flutter Simple Notification Testing",
            notificationDetails)
        .then((value) => print(
              "Successful",
            ))
        .catchError((error) => print("$error"));
  }

  //Show Sound & Image Notification
  Future<void> ShowSoundImageNotification() async {
    var response = await http.get(Uri.parse(
        "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80"));

    final ByteArrayAndroidBitmap bigPicturePath =
        await ByteArrayAndroidBitmap(response.bodyBytes);
    final ByteArrayAndroidBitmap largeIconPath =
        await ByteArrayAndroidBitmap(response.bodyBytes);

    BigPictureStyleInformation bigPictureStyleInformation =
        BigPictureStyleInformation(bigPicturePath,
            contentTitle: 'overridden <b>big</b> content title',
            htmlFormatContentTitle: true,
            summaryText: 'summary <i>text</i>',
            htmlFormatSummaryText: true);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("1", "Android",
            importance: Importance.high,
            priority: Priority.max,
            sound: RawResourceAndroidNotificationSound('sound'),
            styleInformation: bigPictureStyleInformation);

    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails(
      subtitle: "IOS",
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iOSNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(1, "Hello Everyone",
            "Flutter Sound And Image Notification Testing", notificationDetails)
        .then((value) => print(
              "Successful",
            ))
        .catchError((error) => print(
              "$error",
            ));
  }

  //Show Schedule Notification
  Future<void> ShowScheduleNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "1",
      "Android",
      importance: Importance.high,
      priority: Priority.max,
    );

    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails(
      subtitle: "IOS",
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iOSNotificationDetails);

    await flutterLocalNotificationsPlugin
        .zonedSchedule(
          1,
          "Hello Everyone",
          "Flutter Schedule Notification Testing",
          tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          // androidAllowWhileIdle: true,
        )
        .then((value) => print(
              "Successful",
            ))
        .catchError((error) => print(
              "$error",
            ));
  }
}

