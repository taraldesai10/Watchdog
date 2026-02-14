import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:krishi_mitra/common/toast.dart';
import 'package:krishi_mitra/screens/for_doctors/doctor_home_screen.dart';

import 'package:krishi_mitra/service/auth.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class DoctorLogin extends StatefulWidget {
  const DoctorLogin({super.key});

  @override
  State<DoctorLogin> createState() => _DoctorLoginState();
}

class _DoctorLoginState extends State<DoctorLogin> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  late FirebaseAuth auth = FirebaseAuth.instance;
  bool istrue = false;
  TextEditingController emailTxtController = TextEditingController();
  TextEditingController passTxtController = TextEditingController();
  bool comform = false;
  String? mail;
  String? pass;

  @override
  Widget build(BuildContext context) {
    // final auth = Provider.of<Auth>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // StreamBuilder(
            //   stream: FirebaseFirestore.instance
            //       .collection("addDoctor")
            //       .where("email", isEqualTo: mail)
            //       .where("pass", isEqualTo: pass)
            //       .snapshots(),
            //   builder: (context, snapshot) {

            //   },
            // ),
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              child: Form(
                key: key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset("assets/lottie/doctor.json",
                        fit: BoxFit.cover, animate: true),
                    const Text(
                      "Email verification",
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
                                  builder: (context) => DoctorHomePage(),
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(msg: "not valid");
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
          .collection("addDoctor")
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
