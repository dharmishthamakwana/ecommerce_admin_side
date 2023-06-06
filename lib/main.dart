import 'package:firebase_app/screen/views/add_task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'screen/views/Sign_InScreen.dart';
import 'screen/views/Sign_UpScreen.dart';
import 'screen/views/Splesh_Screen.dart';
import 'screen/views/home_screen.dart';

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
            '/': (context) => SplashPage(),
            'SignIn': (context) => SignInPage(),
            'SignUp': (context) => SignUpPage(),
            'Home': (context) => HomeScreen(),
            'add': (context) => AddTask(),
          },
        );
      },
    ),
  );
}
