import 'package:firebase_app/screen/utils/firebase_helper.dart';
import 'package:firebase_app/screen/utils/tostmessges.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "SignIn",
                  style: TextStyle(
                    fontSize: 51,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 10.h),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: txtemail,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey.shade700)),
                            hintText: "Enter Email Ex. xyz123@gmail.com",
                            label: Text("Email",
                                style:
                                    TextStyle(color: Colors.blueGrey.shade700)),
                            prefixIcon: Icon(Icons.email,
                                color: Colors.blueGrey.shade700)),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextField(
                        controller: txtpassword,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(),
                            label: Text("Password",
                                style:
                                    TextStyle(color: Colors.blueGrey.shade700)),
                            hintText: "Enter password",
                            prefixIcon: Icon(Icons.lock,
                                color: Colors.blueGrey.shade700)),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          bool? msg = await FirebaseHelper.firebaseHelper
                              .SignInUser(
                                  email: txtemail.text,
                                  password: txtpassword.text);
                          Get.snackbar(
                              "${msg == true ? "SuccessxFully Logon" : "Fail to login"}",
                              "firebase app");
                          if (msg == true) {
                            Get.offNamed("/home");
                          }
                        },
                        child: Text("SignIn"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey.shade900),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () async {
                          var isLogin = await FirebaseHelper.firebaseHelper.GoogleLogIn();
                          if(isLogin is bool)
                          {
                            Get.offNamed('Home');
                            ToastMessage(msg: "Sign In Successful",color: Colors.green);
                          }
                          else
                          {
                            ToastMessage(msg: "$isLogin",color: Colors.red);
                          }
                        },
                        child: Container(
                          height: Get.height/23,
                          width: Get.height/23,
                          alignment: Alignment.center,
                          child: Image.asset("assets/image/google_logo.png"),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                              onPressed: () {
                                Get.toNamed('/SignUp');
                              },
                              child: Text(
                                "Sign Up",
                                style:
                                    TextStyle(color: Colors.blueGrey.shade900),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
