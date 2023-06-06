import 'package:firebase_app/screen/controller/home_controller.dart';
import 'package:firebase_app/screen/modal/task_modal.dart';
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
  Map index = Get.arguments;

  var args={};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(index["status"]==1) {
      txtemail = TextEditingController(text: "${index['data'].email}");
      txtname = TextEditingController(text: "${index['data'].name}");
      // txtimg=TextEditingController(text:"${index['data'].img}" );
      txtnumber = TextEditingController(text: "${index['data'].number}");
    }
    else if(index["id"]==0){
        txtemail = TextEditingController(text: "${index['data'].email}");
        txtname = TextEditingController(text:  "${index['data'].name}");
        txtimg=TextEditingController(text:"${index['data'].img}" );
        txtnumber = TextEditingController(text: "${index['data'].number}");
      }
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    txtemail = TextEditingController(text: homeController.updatedata.email);
    txtname = TextEditingController(text:homeController.updatedata.name);
    // txtimg=TextEditingController(text:"${index['data'].img}" );
    txtnumber = TextEditingController(text: homeController.updatedata.number);

  }
HomeController homeController=Get.put(HomeController());
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
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (args ['status']== 1) {
                    TaskModal t1 = TaskModal(
                        key: args['data'].key,
                        email: txtemail.text,
                        number: txtnumber.text,
                        name: txtname.text,
                        img: txtimg.text);
                    FirebaseHelper.firebaseHelper.updateTask(t1);
                  } else {
                    FirebaseHelper.firebaseHelper.addTask(
                      img: txtimg,
                      name: txtname,
                      number: txtnumber,
                      email: txtemail,
                    );
                  }
                  Get.back();
                },
                child: Text(args['status']==1?"Add Task":"Update Task"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    txtemail.clear();
    txtnumber.clear();
    txtname.clear();
    txtimg.clear();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtemail.clear();
    txtnumber.clear();
    txtname.clear();
    txtimg.clear();
  }
}
