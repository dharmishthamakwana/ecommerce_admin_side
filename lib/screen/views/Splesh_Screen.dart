import 'dart:async';

import 'package:firebase_app/screen/utils/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    isLogin = FirebaseHelper.firebaseHelper.CheckUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 5),
      () => Get.offAndToNamed(isLogin ? '/home' : '/SignIn'),
    );
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.network(
            "https://imgs.bharatmatrimony.com/bmimgs/login/login-otp-banner.png?v=1",
          ),
        ),
      ),
    );
  }
}
