import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_mitra/common/media_query.dart';

class MandiCropPrice extends StatefulWidget {
  MandiCropPrice({super.key, required this.cropName, required this.image});

  @override
  State<MandiCropPrice> createState() => _MandiCropPriceState();
  String cropName;
  String image;
}

class _MandiCropPriceState extends State<MandiCropPrice> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController txtAddPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text(
          "price".tr,
          style: GoogleFonts.lato(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("cropPrices").snapshots(),
        builder: (context, snapshot) => snapshot.data != null
            ? Center(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: 20,
                        left: 10,
                        bottom: displayHeight(context) / 1.3,
                      ),
                      child: Row(
                        children: [
                          Container(
                            // margin: EdgeInsets.only(
                            //   left: 10,
                            //   bottom: displayHeight(context) / 1.3,
                            // ),
                            height: displayHeight(context) / 5,
                            width: displayWidth(context) / 5,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.green.shade800),
                              image: DecorationImage(
                                image: AssetImage(widget.image),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            child: Text(
                              widget.cropName,
                              style: GoogleFonts.lato(
                                  color: Colors.green[800],
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: displayHeight(context) / 1.3,
                          decoration: BoxDecoration(
                            color: Colors.green[200],
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(40),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: Column(
                              children: [
                                ...List.generate(
                                    snapshot.data!.docs.length,
                                    (index) => snapshot.data!.docs[index]
                                                ["crop"] ==
                                            widget.cropName
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Price Trende :",
                                                style: GoogleFonts.lato(
                                                  color: Colors.green[800],
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ...List.generate(
                                                snapshot
                                                    .data!
                                                    .docs[index]["price"]
                                                    .length,
                                                (var cIndex) => Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text(
                                                          snapshot.data!
                                                                  .docs[index]
                                                              ["date"][cIndex],
                                                          style: GoogleFonts
                                                              .lato(),
                                                        ),
                                                        Text(
                                                          "20 kg",
                                                          style: GoogleFonts
                                                              .lato(),
                                                        ),
                                                        Text(
                                                          "₹${snapshot.data!.docs[index]["price"][cIndex]}",
                                                          style: GoogleFonts.lato(
                                                              color: Colors
                                                                  .green[800],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      height: 25,
                                                      indent: 20,
                                                      endIndent: 20,
                                                      color: Colors.green[900],
                                                      thickness: 1,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        : Container()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
