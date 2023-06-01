import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screen/controller/home_controller.dart';
import 'package:firebase_app/screen/modal/task_modal.dart';
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

  TextEditingController txtemail = TextEditingController();
  TextEditingController txtnumber = TextEditingController();
  TextEditingController txtimg = TextEditingController();
  TextEditingController txtname = TextEditingController();
  List taskList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    homeController.data.value =
        await FirebaseHelper.firebaseHelper.userDetails();
  }

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
                    Get.snackbar("true", "$msg");
                  }
                },
                icon: Icon(Icons.login))
          ],
        ),
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 10.h,
                      backgroundImage: NetworkImage(homeController.data['img'] ==
                              null
                          ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUtcO4YmGkZhf8rEs8DdPZYnLlPCpOF1pTMZMYf1lDHzaQFAqjUKPzRFdZaqDRuBuYKHo&usqp=CAU'
                          : '${homeController.data['img']}'),
                    ),

                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Obx(
                    () => Text(
                        homeController.data['name'] == null
                            ? 'makwana'
                            : '${homeController.data['name']}',
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
                        homeController.data['email'] == null
                            ? "email: makwana@gmail.com"
                            : '${homeController.data['email']}',
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
                        homeController.data['number'] == null
                            ? ''
                            : '${homeController.data['number']}',
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
        body: StreamBuilder(
          stream: FirebaseHelper.firebaseHelper.getTask(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(
                "${snapshot.error}",
              );
            } else if (snapshot.hasData) {
              QuerySnapshot? snapData = snapshot.data;
              for (var x in snapData!.docs) {
                Map? data = x.data() as Map;

                String email = data['email'];
                String name = data['name'];
                String img = data['img'];
                String number = data['number'];
                TaskModal t1 = TaskModal(
                  number: number,
                  name: name,
                  img: img,
                  email: email,
                );
                taskList.add(t1);

                print("$email,$name,$number,$img");
              }
              return ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage("${taskList[index].img}")),
                    title: Text("${taskList[index].email}"),
                    subtitle: Text("${taskList[index].number}"),
                    trailing: Text("${taskList[index].name}"),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.toNamed('add');
          },
        ),
      ),
    );
  }
}
