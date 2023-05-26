import 'package:firebase_app/screen/views/Sign_InScreen.dart';
import 'package:firebase_app/screen/views/Sign_UpScreen.dart';
import 'package:firebase_app/screen/views/Splesh_Screen.dart';
import 'package:firebase_app/screen/views/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(
            name: '/',
            page: () => SpleshScreen(),
          ),
          GetPage(
            name: '/SignIn',
            page: () => SignInScreen(),
          ),
          GetPage(
            name: '/SignUp',
            page: () => SignUpScreen(),
          ),
          GetPage(
            name: '/home',
            page: () => HomeScreen(),
          ),
        ],
      ),
    ),
  );
}
