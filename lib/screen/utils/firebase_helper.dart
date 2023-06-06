import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screen/modal/task_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore fiebaseFirestore = FirebaseFirestore.instance;

  void signUP({required email, required password}) {
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => print("Login Success !"))
        .catchError((e) => print("Failed : $e"));
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

  Future<void> addTask({email, img, name, number,key}) async {
    User? user = firebaseAuth.currentUser;
    String uid = user!.uid;
  await  fiebaseFirestore
        .collection("ecommerce")
        .doc("$uid")
        .collection("user")
        .add({
      'email': email,
      'img': img,
      'name': name,
      'number': number,
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

  void updateTask(TaskModal task) {
    String uid = getUid();
    fiebaseFirestore
        .collection("ecommerce")
        .doc("${uid}")
        .collection("user")
        .doc(task.key)
        .set({
      "email": "${task.email}",
      "number": "${task.number}",
      "img": "${task.img}",
      "name": "${task.name}"
    });
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
}
