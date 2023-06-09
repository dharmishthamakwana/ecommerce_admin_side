import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screen/modal/Product_modal.dart';
import 'package:firebase_app/utils/fire_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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
    print('======================');
    print(img);
    Map m1 = {'email': email, 'img': img, 'name': name, 'number': number};
    return m1;
  }

  // Future<String?> adddata(
  //     {String? Name, Brand, Price, Dis, Day, stock, img, cat}) async {
  //   String? msg;
  //   await fiebaseFirestore.collection("product").add({
  //     "Name": "$Name",
  //     "Brand": "$Brand",
  //     "Price": "$Price",
  //     "Dis": "$Dis",
  //     "rat": "0",
  //     "Day": "$Day",
  //     "Stock": "$stock",
  //     "Cat": "$cat",
  //     "Img": "$img",
  //   }).then((value) => msg = "Success");
  //   return msg;
  // }
  Future<void> addTask({desc, img, name, number,key,price}) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
    await  fiebaseFirestore
        .collection("ecommerce")
        .doc("$uid")
        .collection("product")
        .add({
      'desc': desc,
      'img': img,
      'name': name,
      'number': number,
      'price':price,
      'key':key,
    });
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getTask() {
    String uid = getUid();
    return fiebaseFirestore
        .collection("ecommerce")
        .doc("$uid")
        .collection("user")
        .snapshots();
  }

  String getUid() {
    User? user = firebaseAuth.currentUser;
    var uid = user!.uid;
    return uid;
  }

  // Future<String?> Update(
  //     {rat, String? Name, Brand, Price, Dis, Day, stock, img, cat, key}) async {
  //   String? msg;
  //   await fiebaseFirestore.collection("product").doc('$key').set({
  //     "Name": "$Name",
  //     "Brand": "$Brand",
  //     "Price": "$Price",
  //     "Dis": "$Dis",
  //     "Day": "$Day",
  //     "Stock": "$stock",
  //     "Cat": "$cat",
  //     "Img": "$img",
  //     "rat": "$rat",
  //   }).then((value) => msg = "Success");
  //   return msg;
  // }
  void updateTask(ProductModal task) {
    String uid = getUid();
    fiebaseFirestore
        .collection("ecommerce")
        .doc("${uid}")
        .collection("user")
        .doc(task.key)
        .set({
      "desc": "${task.desc}",
      "number": "${task.number}",
      "img": "${task.img}",
      "name": "${task.name}"
    });
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

  void delet(id) {
    fiebaseFirestore.collection("order").doc('$id').delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> comorder() {
    return fiebaseFirestore.collection("comorder").snapshots();
  }

  Future<String?> Comorder(
      {String? Name,
      Brand,
      Price,
      img,
      con,
      uName,
      email,
      add,
      Dis,
      pay}) async {
    String? msg;
    await fiebaseFirestore.collection("comorder").add({
      "Name": "$Name",
      "pay": "$pay",
      "Con": "$con",
      "Brand": "$Brand",
      "Price": "$Price",
      "Dis": "$Dis",
      "Img": "$img",
      "email": "$email",
      "uname": "$uName",
      "add": "$add",
    }).then((value) => msg = "Success");
    return msg;
  }

  void delete(id) {
    fiebaseFirestore.collection('product').doc('$id').delete();
  }

  // Future<dynamic> FacebookLogIn() async {
  //   dynamic isLogin;
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   // Once signed in, return the UserCredential
  //   FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential)
  //       .then((value) {
  //     isLogin = true;
  //   }).catchError((error) {
  //     int len = 0;
  //     for (int i = 0; i < error.toString().length; i++) {
  //       if (error.toString()[i].contains(']')) {
  //         len = i + 2;
  //         print("object====== $len");
  //         break;
  //       }
  //     }
  //     isLogin = error.toString().substring(len, error.toString().length);
  //   });
  //   print("===== $isLogin");
  //
  //   return isLogin;
  // }

  Future<void> deleteData(String key) async {
    var uid = getUid();
    await fiebaseFirestore
        .collection("ecommerce")
        .doc(uid)
        .collection("user")
        .doc(key)
        .delete();
  }

  Future<void> FirebaseMessageging() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    var token = await firebaseMessaging.getToken();
    print("=== TOKEN === $token");
    InitializeNotification();

    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission(
            alert: true,
            sound: true,
            badge: true,
            announcement: true,
            carPlay: true,
            criticalAlert: true,
            provisional: true);

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
}
