import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_mitra/models/crop_doctor_maps.dart';
import 'package:krishi_mitra/screens/admin/admin_login_page.dart';
import 'package:krishi_mitra/screens/for_doctors/doctor_login.dart';
import 'package:krishi_mitra/screens/login_page.dart';

class SelectSide extends StatefulWidget {
  const SelectSide({super.key});

  @override
  State<SelectSide> createState() => _SelectSideState();
}

class _SelectSideState extends State<SelectSide> {
  List<Map<String, dynamic>> chooseSide = [
    {"title": "farmer", "class": PhoneVerificationScreen()},
    {"title": "crop doctor", "class": DoctorLogin()},
    {"title": "admin", "class": AdminLoginPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("who".tr),
      ),
      body: Column(
        children: [
          ...List.generate(
              chooseSide.length,
              (index) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => chooseSide[index]["class"],
                          ));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(20),
                      height: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.green.shade900, width: 1.5),
                          color: Colors.green[300]),
                      child: Text(
                        chooseSide[index]["title"].toString().tr,
                        style: GoogleFonts.lato(
                            fontSize: 25, color: Colors.green[1000]),
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
