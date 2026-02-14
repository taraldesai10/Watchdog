// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mitra/common/shared_pref.dart';
import 'package:krishi_mitra/screens/bottom_nav_bar.dart';
import 'package:krishi_mitra/screens/home_screen/home_page.dart';
import 'package:krishi_mitra/screens/login_page.dart';
import 'package:krishi_mitra/screens/user_detail.dart';

import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "assets/lottie/3-intro.json",
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "otp verification".tr,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "otp intro".tr,
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,
                onChanged: (value) {
                  code = value;
                },
                showCursor: true,
                onCompleted: (pin) => log(pin),
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
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: PhoneVerificationScreen.verify,
                                smsCode: code);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);


                        List isRegister = await isLoged();
                        if (isRegister.isNotEmpty) {
                          Get.offUntil(
                              MaterialPageRoute(
                                builder: (context) => CommonBottomNavigation(),
                              ),
                                  (route) => false);
                        } else {
                          Get.offUntil(
                              MaterialPageRoute(
                                builder: (context) => UserDetailPage(),
                              ),
                                  (route) => false);

                        }


                      } catch (e) {
                        log("wrong otp");
                      }
                    },
                    child: Text(
                      "submit".tr,
                      style: TextStyle(color: Colors.green.shade900),
                    )),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Future isLoged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List dataList = [];
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .where("phone", isEqualTo: SharedPref.getPhoneNumber )

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
