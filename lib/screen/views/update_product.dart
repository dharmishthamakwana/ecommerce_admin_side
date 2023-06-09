import 'package:firebase_app/screen/controller/home_controller.dart';
import 'package:firebase_app/screen/modal/Product_modal.dart';

// import 'package:firebase_app/screen/utils/firebase_helper.dart';
import 'package:firebase_app/utils/firebase_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProduct extends StatefulWidget {
  const UpdateProduct({Key? key}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  Map index = Get.arguments;

  var args = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (index["status"] == 1) {
      txtdesc = TextEditingController(text: "${index['data'].desc}");
      txtname = TextEditingController(text: "${index['data'].name}");
      // txtimg=TextEditingController(text:"${index['data'].img}" );
      txtnumber = TextEditingController(text: "${index['data'].number}");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    txtdesc = TextEditingController(text: homeController.updatedata.desc);
    txtname = TextEditingController(text: homeController.updatedata.name);
    // txtimg=TextEditingController(text:"${index['data'].img}" );
    txtnumber = TextEditingController(text: homeController.updatedata.number);
  }

  HomeController homeController = Get.put(HomeController());
  TextEditingController txtdesc = TextEditingController();
  TextEditingController txtnumber = TextEditingController();
  TextEditingController txtimg = TextEditingController();
  TextEditingController txtname = TextEditingController();
  TextEditingController txtprice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update Product"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                  controller: txtdesc,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(),
                      label: Text("enter the description"),
                      hintText: "email"),
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
                TextField(
                  controller: txtprice,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(),
                      enabled: true,
                      enabledBorder: OutlineInputBorder(),
                      label: Text("enter the price"),
                      hintText: "number"),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    ProductModal p1=ProductModal(
                        key: args['data'].key,
                        desc: txtdesc.text,
                        number: txtnumber.text,
                        name: txtname.text,
                        img: txtimg.text);
                    FirebaseHelper.firebaseHelper.updateTask(p1);

                    Get.back();
                  },
                  child: Text("Update Product"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    txtdesc.clear();
    txtnumber.clear();
    txtname.clear();
    txtimg.clear();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    txtdesc.clear();
    txtnumber.clear();
    txtname.clear();
    txtimg.clear();
  }
}
