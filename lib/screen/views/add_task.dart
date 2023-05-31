import 'package:firebase_app/screen/utils/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtnumber = TextEditingController();
  TextEditingController txtimg = TextEditingController();
  TextEditingController txtname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Task"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: txtemail,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(),
                    label: Text("enter the emaill"),
                    hintText: "email"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtname,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(),
                    label: Text("enter the name"),
                    hintText: "name"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtimg,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(),
                    label: Text("enter the image"),
                    hintText: "image"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: txtnumber,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(),
                    label: Text("enter the number"),
                    hintText: "number"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseHelper.firebaseHelper.addTask(
                      email: txtemail.text,
                      img: txtimg.text,
                      name: txtname.text,
                      number: txtnumber.text);
                  Get.back();
                },
                child: const Text("Add Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
