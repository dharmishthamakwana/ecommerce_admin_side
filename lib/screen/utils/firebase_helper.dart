import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static FirebaseHelper firebaseHelper = FirebaseHelper._();

  FirebaseHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void signUP({required email, required password}) {
    firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => print("Login Success !"))
        .catchError((e) => print("Failed : $e"));
  }


  Future<String> signIn({required email, required password}) {
    return firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return 'Success';
    },)
        .catchError((e){
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
    await firebaseAuth.signInWithCredential(credential).then((value) => msg='Success').catchError((e)=> msg='$e');
    userDetails();
    return msg;
  }

  Future<bool> signOut()
  async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    return true;
  }

  Future<Map> userDetails()
  async {
    User? user = await firebaseAuth.currentUser;
    String? email = user!.email;
    String? img = user.photoURL;
    String? name = user.displayName;String ? number=user.phoneNumber;
    Map m1 = {'email':email,'img':img,'name':name,'number':number};
    return m1;
  }

}