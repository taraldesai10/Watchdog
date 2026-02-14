import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:krishi_mitra/common/media_query.dart';

import '../../firebase_storage/add_price_store.dart';

class CropPriceUpdate extends StatefulWidget {
  CropPriceUpdate(
      {super.key,
        required this.useIndex,
      required this.cropName,
      required this.image,
      required this.id});

  @override
  State<CropPriceUpdate> createState() => _CropPriceUpdateState();
  int useIndex;
  String cropName;
  String image;
  String id;
}

class _CropPriceUpdateState extends State<CropPriceUpdate> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController txtAddPrice = TextEditingController();
  TextEditingController dateController = TextEditingController();
  var uid = "";

  String formatter = DateFormat('yyyy-MM-dd').format(DateTime.now());
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text(
          "Price",
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
                    ...List.generate(snapshot.data!.docs.length, (index) => snapshot.data!.docs[index]["crop"] == widget.cropName? Container(
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
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data!.docs[index]["crop"],
                                  style: GoogleFonts.lato(
                                      color: Colors.green[800],
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(snapshot.data!.docs[index].id)
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                uid = snapshot.data!.docs[index].id;
                              });

                              log(uid);
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: SingleChildScrollView(
                                      child: priceDialog()),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.green[900],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                CupertinoIcons.add,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ):Container(),
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
                                                (var cIndex) {
                                                  return Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Text(
                                                            snapshot.data!.docs[
                                                                        index]
                                                                    ["date"]
                                                                [cIndex],
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
                                                        color:
                                                            Colors.green[900],
                                                        thickness: 1,
                                                      ),
                                                    ],
                                                  );
                                                },
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

  Widget priceDialog() => Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        height: displayHeight(context) / 3.1,
        width: displayWidth(context) / 1.5,
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Add Price",
                    style: GoogleFonts.lato(
                        color: Colors.green[800],
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  validator: MultiValidator(
                      [RequiredValidator(errorText: "please enter date")]),
                  decoration: InputDecoration(
                    icon: Icon(Icons.monetization_on_rounded),
                    label: Text(
                      "add new price",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                  controller: txtAddPrice,
                ),
                SizedBox(
                  height: 20,
                ),
            Row(
              children: [
                Icon(CupertinoIcons.calendar),SizedBox(width: 15,),
                Text(
                      formatter,
                        style: GoogleFonts.lato(color: Colors.green[900]),),
              ],
            ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (key.currentState!.validate()) {
                          final washingtonRef = FirebaseFirestore.instance
                              .collection("cropPrices")
                              .doc(uid);
                          washingtonRef.update({
                            "price":
                                FieldValue.arrayUnion([txtAddPrice.text]),
                            "date":
                                FieldValue.arrayUnion([formatter])
                          });
                          Navigator.pop(context);
                          dateController.clear();
                        }

                        // AddPrices.addPrice();
                        setState(() {});
                      },
                      child: Text("Update"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
