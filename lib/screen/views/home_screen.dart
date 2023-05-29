import 'package:firebase_app/screen/controller/home_controller.dart';
import 'package:firebase_app/screen/utils/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue.shade100,
        appBar: AppBar(
          backgroundColor: Colors.blueAccent.shade700,
          title: Text("Home Screen"),
          actions: [
            IconButton(
                onPressed: () async {
                  bool msg = await FirebaseHelper.firebaseHelper.signOut();
                  if (msg = true) {
                    Get.offNamed("SignIn");
                  }
                },
                icon: Icon(Icons.login))
          ],
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 60.sp,
                      backgroundImage: NetworkImage(homeController
                                  .userData['img'] ==
                              null
                          ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUtcO4YmGkZhf8rEs8DdPZYnLlPCpOF1pTMZMYf1lDHzaQFAqjUKPzRFdZaqDRuBuYKHo&usqp=CAU'
                          : '${homeController.userData['img']}'),
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Obx(
                    () => Text(
                        homeController.userData['name'] == null
                            ? 'makwana'
                            : '${homeController.userData['name']}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp)),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Obx(
                    () => Text(
                        homeController.userData['email'] == null
                            ? "email: makwana@gmail.com"
                            : '${homeController.userData['email']}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp)),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Obx(
                        () => Text(
                        homeController.userData['number'] == null
                            ? "number:            '9988552266'"
                            : '${homeController.userData['number']}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp)),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "welcome...!!",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
