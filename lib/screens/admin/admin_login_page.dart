import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:krishi_mitra/screens/admin/admin_bottom_bar.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  late FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailTxtController = TextEditingController();
  TextEditingController passTxtController = TextEditingController();

  String? mail;
  String? pass;

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              child: Form(
                key: key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Admin verification",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        TextFormField(
                          controller: emailTxtController,
                          validator: MultiValidator([
                            EmailValidator(
                                errorText: "please enter valid email"),
                            RequiredValidator(
                                errorText: "please enter your email"),
                          ]).call,
                          onChanged: (value) {},
                          decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.mail),
                            border: InputBorder.none,
                            hintText: "Email",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passTxtController,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "please enter your password"),
                            MaxLengthValidator(10,
                                errorText: "only add 10 charecters")
                          ]).call,
                          onChanged: (value) {},
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.lock),
                            border: InputBorder.none,
                            hintText: "password",
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 165, 221, 166),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          // var sharedPref = await SharedPreferences.getInstance();
                          // sharedPref.setBool(SplashScreen.keyLogin, true);

                          if (key.currentState!.validate()) {
                            List isRegister = await getDoctorData();
                            if (isRegister.isNotEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AdminBottomBar(),
                                  ));
                            } else {
                              Fluttertoast.showToast(
                                  msg: "enter valid email and password");
                            }
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.green.shade900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getDoctorData() async {
    List dataList = [];
    try {
      await FirebaseFirestore.instance
          .collection("admin")
          .where("email", isEqualTo: emailTxtController.text)
          .where("pass", isEqualTo: passTxtController.text)
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) {
                  dataList.add(doc.data());
                })
              });
      return dataList;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
