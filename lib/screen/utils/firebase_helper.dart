import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> SignUpUser(
      {required String email, required String password}) async {
    String? msg;

    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      msg = "Sign Up Successful With $email";
    }).catchError((error) {
      msg = "$error";
    });
    return msg!;
    // return check;
  }

  //Sign In In Firebase Authentication
  Future<bool?> SignInUser(
      {required String email, required String password}) async {
    bool? check;

    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      check = true;
    }).catchError((error) {
    });
    // return msg!;
    return check;
  }

  //Check User Login In Firebase Authentication
  bool CheckUserLogin() {
    User? user = firebaseAuth.currentUser;
    return user != null;
  }

  Future<bool?> SignOut() async {
    bool? msg;
    await firebaseAuth.signOut().then((value) => msg = true);
    return msg;
  }

  Future<dynamic> GoogleLogIn() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
    }).catchError((error) {
      int len = 0;
      for (int i = 0; i < error.toString().length; i++) {
        if (error.toString()[i].contains(']')) {
          len = i + 2;
          print("object====== $len");
          break;
        }
      }
    });
  }
}
