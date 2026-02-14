import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:krishi_mitra/common/shared_pref.dart';
import 'package:krishi_mitra/screens/more/edit_profile.dart';
import 'package:krishi_mitra/screens/bottomsheet.dart';

import 'package:krishi_mitra/screens/splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

@override

  @override
  Widget build(BuildContext context) {
  EditProfile.userName = null;
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            profileImage(),

            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {

                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(),
                    ),
                  );
                });
              },
              child: Text("edit profile".tr),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     HapticFeedback.heavyImpact();
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const DoctorLogin(),
            //         ));
            //   },
            //   child: Text("doctor login".tr),
            // ),
            ElevatedButton(
              onPressed: () {
                ForgetPasswordBottomSheet.buildBottomSheet(context);
              },
              child: Text(
                'lenguage button'.tr,
                style: TextStyle(color: Colors.green.shade900),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                var sharedPref = await SharedPreferences.getInstance();
                sharedPref.setBool(SplashScreen.keyLogin, false);
                SharedPref.setPhoneNumber = "";
                Get.offAll(SplashScreen());
              },
              child: Text(
                'logout'.tr,
                style: TextStyle(color: Colors.green.shade900),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget profileImage() => FutureBuilder(
 future: FirebaseFirestore.instance
     .collection("users")
     .where("phone", isEqualTo: SharedPref.getPhoneNumber)
     .snapshots().first,


      builder: (context, snapshot) => snapshot.hasData
          ? snapshot.data!.docs.first["image"] != "null"
              ? Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade800,
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data!.docs.first["image"]),filterQuality: FilterQuality.low,fit: BoxFit.contain
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade800,
                    ),
                    child: Lottie.asset("assets/lottie/profile.json"),
                  ),
                )
          : const Center(
              child: CircularProgressIndicator(),
            ));
}
