import 'package:firebase_app/screen/views/add_product.dart';
import 'package:firebase_app/screen/notification_screen/notification.dart';
import 'package:firebase_app/screen/views/update_product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'screen/views/Login_System/Sign_InScreen.dart';
import 'screen/views/Login_System/Sign_UpScreen.dart';
import 'screen/views/Login_System/Splesh_Screen.dart';
import 'screen/views/All_product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (p0) => SplashPage(),
            'SignIn': (p0) => SignInPage(),
            'SignUp': (p0) => SignUpPage(),
            'Home': (p0) => HomeScreen(),
            'add': (p0) => AddTask(),
            'note': (p0) => HomePage(),
            'update': (p0) => UpdateProduct(),
          },
        );
      },
    ),
  );
}
