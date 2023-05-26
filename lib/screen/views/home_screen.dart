import 'package:firebase_app/screen/utils/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Home Screen"),
          actions: [
            IconButton(onPressed: () async {
              bool? msg = await FirebaseHelper.firebaseHelper.SignOut();
              if(msg = true)
                {
                  Get.offNamed("/SignIn");
                }
            }, icon: Icon(Icons.login))
          ],
        ),
        body: Column(
          children: [
            Text(
              "welcome...!!",
              style: TextStyle(
              fontSize: 50, fontWeight: FontWeight.w900, letterSpacing: 2),
            ),
          ],
        ),
      ),
    );
  }
}
