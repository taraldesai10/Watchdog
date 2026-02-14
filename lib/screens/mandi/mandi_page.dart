import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_mitra/common/media_query.dart';
import 'package:krishi_mitra/models/crop_doctor_maps.dart';
import 'package:krishi_mitra/screens/mandi/mandi_crop_price_page.dart';
import 'package:lottie/lottie.dart';

class MandiPage extends StatefulWidget {
  const MandiPage({super.key});

  @override
  State<MandiPage> createState() => _MandiPageState();
}

class _MandiPageState extends State<MandiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        centerTitle: true,
        title: Text("mandi".tr,
            style: GoogleFonts.lato(
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("cropPrices").snapshots(),
          builder: (context, snapshot) => snapshot.hasData
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      ...List.generate(
                        snapshot.data!.docs.length,
                        (index) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MandiCropPrice(
                                    image: chooseCrop[index]["image"],
                                    cropName: chooseCrop[index]["crop name"]),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                  image: DecorationImage(
                                    image:
                                        AssetImage(chooseCrop[index]["image"]),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                height: 100,
                                width: displayWidth(context) * 0.6,
                                decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      chooseCrop[index]["crop name"]
                                          .toString()
                                          .tr,
                                      style: GoogleFonts.lato(
                                          color: Colors.green[900],
                                          fontSize: 16),
                                    ),
                                    ...List.generate(
                                      chooseCrop.length,
                                      (var lIndex) => snapshot
                                                  .data!.docs[lIndex]["crop"] ==
                                              chooseCrop[index]["crop name"]
                                          ? Text(
                                              "${snapshot.data!.docs[lIndex]["price"].last}/ 20 ${"kg".tr}",
                                              style: GoogleFonts.lato(
                                                  color: Colors.green[900],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.04),
                                            )
                                          : Container(),
                                    ),

                                    // Text(snapshot.data!.docs[index]["price"].last)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Lottie.asset(
                      "assets/icons/loading_.json",
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
