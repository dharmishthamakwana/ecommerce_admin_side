import 'package:firebase_app/utils/fire_service.dart';
import 'package:firebase_app/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controller/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = HomeController();

  @override
  void initState() {
    super.initState();
    homeController.InitializeNotification();
    FirebaseHelper.firebaseHelper.FirebaseMessageging();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notification"),
          leading: Padding(
            padding: EdgeInsets.only(left: Get.width / 60),
            child: IconButton(
              onPressed: () async {
                await FirebaseHelper.firebaseHelper.signOut();
                Get.offNamed('SignIn');
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  homeController.ShowSimpleNotification();
                },
                child: Text("Simple Notification"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
              ),
              SizedBox(
                height: Get.width / 15,
              ),
              ElevatedButton(
                onPressed: () {
                  homeController.ShowScheduleNotification();
                },
                child: Text("Schedule Notification"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
              ),
              SizedBox(
                height: Get.width / 15,
              ),
              ElevatedButton(
                onPressed: () {
                  homeController.ShowSoundImageNotification();
                },
                child: Text("Sound & Image Notification"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
              ),
              SizedBox(
                height: Get.width / 15,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseHelper.firebaseHelper.FirebaseMessageging();
                },
                child: Text("Firebase Notification"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
