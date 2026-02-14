import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_mitra/screens/select_side.dart';

import 'doctor_crop_detail.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text(
          "Applications",
          style: GoogleFonts.lato(
            color: Colors.white,
          ),
        ),
        actions: [
          ElevatedButton(onPressed: (){
            Get.offUntil(MaterialPageRoute(builder: (context) => SelectSide(),), (route) => false);
          }, child: Text("Logout")),
          SizedBox(width: 10,)
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("upload").snapshots(),
        builder: (context, streamSnapshot) => streamSnapshot.data != null
            ? Column(
                children: [
                  ...List.generate(
                      streamSnapshot.data!.docs.length,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorCropDetailPage(
                                      cropName: streamSnapshot.data!.docs[index]
                                          ["cropName"],
                                      acres: streamSnapshot.data!.docs[index]
                                          ["acres"],
                                      condition: streamSnapshot
                                          .data!.docs[index]["condition"],
                                      cropImage: streamSnapshot
                                          .data!.docs[index]["picture"],
                                      date: streamSnapshot.data!.docs[index]
                                          ["date"],
                                      userImage: streamSnapshot
                                          .data!.docs[index]["image"],
                                      userMNumber: streamSnapshot
                                          .data!.docs[index]["userMobile"],
                                      userName: streamSnapshot.data!.docs[index]
                                          ["name"],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    streamSnapshot.data!.docs[index]['image'] ==
                                            null
                                        ? CircularProgressIndicator()
                                        : Container(
                                            margin:
                                                const EdgeInsets.only(right: 5),
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  streamSnapshot.data!
                                                      .docs[index]['image'],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          streamSnapshot.data?.docs[index]
                                              ['name'],
                                          style: GoogleFonts.lato(
                                            color: Colors.green[1000],
                                          ),
                                        ),
                                        Text(
                                          streamSnapshot.data!.docs[index]
                                              ['cropName'],
                                          style: GoogleFonts.lato(
                                            color: Colors.green[1000],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
