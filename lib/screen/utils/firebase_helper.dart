import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> SignUpUser(
      {required String email, required String password}) async {
    String? msg;
    bool? check;

    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      msg = "Sign Up Successful With $email";
      check = true;
    }).catchError((error) {
      msg = "$error";
    });
    return msg!;
    // return check;
  }

  //Sign In In Firebase Authentication
  Future<bool?> SignInUser(
      {required String email, required String password}) async {
    String? msg;
    bool? check;

    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      msg = "Login Successful With $email";
      check = true;
    }).catchError((error) {
      msg = "$error";
    });
    // return msg!;
    return check;
  }

  //Check User Login In Firebase Authentication
  bool  CheckUserLogin()  {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<bool?> SignOut()
  async {
    bool? msg;
    await firebaseAuth.signOut().then((value) => msg = true);
    return msg;
  }
}
