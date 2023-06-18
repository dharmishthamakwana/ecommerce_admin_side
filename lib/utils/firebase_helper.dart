import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screen/modal/Product_modal.dart';
import 'package:firebase_app/utils/fire_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore fiebaseFirestore = FirebaseFirestore.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<bool> SignUpUser(
      {required String email, required String password}) async {
    bool isSignUp = false;

    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      isSignUp = true;
      print(
        "Sign Up Successful With $email",
      );
    }).catchError((error) {
      isSignUp = false;
      print("$error");
    });
    return isSignUp;
  }

  Future<String> signIn({required email, required password}) {
    return firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        return 'Success';
      },
    ).catchError((e) {
      return '$e';
    });
  }

  bool checkUser() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<String?> googleSignIn() async {
    String? msg;
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    // create a new credential
    var credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    await firebaseAuth
        .signInWithCredential(credential)
        .then((value) => msg = 'Success')
        .catchError((e) => msg = '$e');
    userDetails();
    return msg;
  }

  Future<bool> signOut() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    return true;
  }

  Future<Map> userDetails() async {
    User? user = await firebaseAuth.currentUser;
    String? email = user!.email;
    String? img = user.photoURL;
    String? name = user.displayName;
    String? number = user.phoneNumber;
    // print('======================');
    print("================================$img");
    Map m1 = {'email': email, 'img': img, 'name': name, 'number': number};
    return m1;
  }


  Future<void> addTask({desc, img, name, number, key, price}) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await fiebaseFirestore.collection("product")
        .add({
      'desc': desc,
      'img': img,
      'name': name,
      'number': number,
      'price': price,
      'key': key,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTask() {
    return fiebaseFirestore
        .collection("product")
        .snapshots();
  }

  String getUid() {
    User? user = firebaseAuth.currentUser;
    var uid = user!.uid;
    return uid;
  }


  void updateTask(ProductModal task) {
    String uid = getUid();
    fiebaseFirestore
        .collection("product")
        .doc(task.key)
        .set({
      "desc": "${task.desc}",
      "number": "${task.number}",
      "img": "${task.img}",
      "name": "${task.name}",
      "price":"${task.price}"
    });
  }






  Future<void> deleteData({required key}) async {
    var uid = getUid();
    await fiebaseFirestore.collection("product")
        .doc(key)
        .delete();
  }

  Future<void> FirebaseMessageging() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    var token = await firebaseMessaging.getToken();
    print("=== TOKEN === $token");
    InitializeNotification();



    FirebaseMessaging.onMessage.listen(
      (msg) {
        if (msg.notification != null) {
          String? body = msg.notification!.body;
          String? title = msg.notification!.title;
          NotificationService.notificationService
              .showFireNotification(title!, body!);
        }
      },
    );
  }

  //Initialize Notification
  void InitializeNotification() {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('icon');

    DarwinInitializationSettings iOSInitializationSettings =
        const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //Show Simple Notification
  Future<void> ShowFirebaseNotification(
      {required String title, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      "1",
      "Android",
      importance: Importance.high,
      priority: Priority.max,
      sound: RawResourceAndroidNotificationSound('sound'),
    );

    DarwinNotificationDetails iOSNotificationDetails =
        const DarwinNotificationDetails(
      subtitle: "IOS",
    );

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iOSNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(1, title, body, notificationDetails)
        .then((value) => print(
              "Successful",
            ))
        .catchError((error) => print("$error"));
  }



 Stream<QuerySnapshot<Map<String, dynamic>>> readdata() {
    return fiebaseFirestore.collection('product').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readorder() {
    return fiebaseFirestore.collection('order').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readuser({uid}) {
    return fiebaseFirestore
        .collection('user')
        .doc('$uid')
        .collection('data')
        .snapshots();
  }




}
