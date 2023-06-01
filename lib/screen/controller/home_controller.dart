import 'dart:async';

import 'package:firebase_app/screen/modal/task_modal.dart';
import 'package:firebase_app/screen/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  TaskModal updatedata=TaskModal();

  //Only Function's

  Future<void> IsLogin() async {
    bool isLogin = await FirebaseHelper.firebaseHelper.checkUser();
    print("===== $isLogin");
    if (isLogin) {
      Timer(Duration(seconds: 3), () {
        Get.offNamed('Home');
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Get.offNamed('SignIn');
      });
    }
  }
  RxMap userData = {}.obs;
  Future<void> userDetailFromId()
  async {
    userData.value = await FirebaseHelper.firebaseHelper.userDetails();
    print(userData);
  }

  RxString? msg;

}
