
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String? UserUid;

  //SignUp Account Function
  Future<dynamic> CreateSignUp(
      {required String email, required String password}) async {
    dynamic isSignUp;

    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        print("========= Successfully ");
        isSignUp = true;
      },
    ).catchError(
      (error) {
        int len = 0;
        for (int i = 0; i < error.toString().length; i++) {
          if (error.toString()[i].contains(']')) {
            len = i + 2;
            print("object====== $len");
            break;
          }
        }
        isSignUp = error.toString().substring(len, error.toString().length);
      },
    );

    return isSignUp;
  }

  //SignIn Account Function
  Future<dynamic> SignInUser(
      {required String email, required String password}) async {
    dynamic isSignIn;

    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print("object== $value");
      isSignIn = true;
    }).catchError((error) {
      int len = 0;
      for (int i = 0; i < error.toString().length; i++) {
        if (error.toString()[i].contains(']')) {
          len = i + 2;
          print("object====== $len");
          break;
        }
      }
      isSignIn = error.toString().substring(len, error.toString().length);
    });
    print("===== $isSignIn");
    return isSignIn;
  }

  //Check User Login
  Future<bool> CheckSignIn() async {
    if (await firebaseAuth.currentUser != null) {
      return true;
    }
    return false;
  }

  //Sign Out User
  Future<bool?> SignOut() async {
    bool? msg;
    await firebaseAuth.signOut().then((value) => msg = true);
    return msg;
  }
  //Login With Google
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
