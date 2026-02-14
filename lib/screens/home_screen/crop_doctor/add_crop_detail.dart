// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_mitra/models/crop_doctor_maps.dart';
import 'package:krishi_mitra/screens/home_screen/crop_doctor/add_crop.dart';
import 'package:krishi_mitra/screens/login_page.dart';

class AddCropDetail extends StatefulWidget {
  const AddCropDetail({super.key, required this.image, required this.name});
  static String selectedCondition = "";
  static String? plantedDate;
  static String? acers;

  @override
  State<AddCropDetail> createState() => _AddCropDetailState();
  final String image;
  final String name;
}

class _AddCropDetailState extends State<AddCropDetail> {
  int? selectedTap;
  TextEditingController txtAcresController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  // String errorCondition = "";
  bool errorCondition = false;

  String errorDate = "";
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("add crop detail".tr),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      // borderRadius: BorderRadius.circular(40),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          widget.image.tr,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "select infection".tr,
                    style: GoogleFonts.lato(
                      fontSize: 17,
                      color: Colors.green[1000],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...List.generate(
                      cropCondition.length,
                      (index) => GestureDetector(
                        onTap: () {
                          selectedTap = index;
                          errorCondition = true;
                          //selectedCondition is for upload data in firebase
                          AddCropDetail.selectedCondition =
                              cropCondition[index]["name"].toString().tr;
                          print(AddCropDetail.selectedCondition);
                          setState(() {});
                        },
                        child: Container(
                          height: 130,
                          width: 100,
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (selectedTap == index)
                                ? Colors.green[600]
                                : Colors.green[200],
                            image: DecorationImage(
                              image: AssetImage(
                                cropCondition[index]["image"],
                              ),
                            ),
                          ),
                          child: Text(
                            cropCondition[index]["name"].toString(). tr,
                            style: GoogleFonts.lato(
                              color: (selectedTap == index)
                                  ? Colors.white
                                  : Colors.green[900],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(errorCondition?"":"",
                    style: GoogleFonts.lato(color: Colors.red)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: TextFormField(
                    validator: MultiValidator([
                    RequiredValidator(errorText: "enter date")
                    ]),
                      controller: dateController,
                      decoration:  InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "enter date".tr
                      ),
                       readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now()


                        );
                        if(pickedDate != null ){
                          print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                          print(formattedDate); //formatted date output using intl package =>  2022-07-04
                          //You can format date as per your need

                          setState(() {
                            dateController.text = formattedDate;
                            AddCropDetail.plantedDate = dateController.text;
                          });
                        }else{
                          print("Date is not selected");
                        }
                      }
                  )

                ),
                Text(
                  errorDate,
                  style: GoogleFonts.lato(color: Colors.red),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     Text("${"acres".tr}  :"),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 100,
                      // height: 30,
                      child: TextFormField(
                        cursorErrorColor: Colors.red,
                        validator: MultiValidator([
                          RequiredValidator(
                            errorText: "please enter acres",
                          ),
                          LengthRangeValidator(
                              min: 0, max: 4, errorText: "not allowed")
                        ]).call,
                        controller: txtAcresController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {


                      if (key.currentState!.validate()) {
                        if (errorCondition == null) {

                        }
                        AddCropDetail.acers = txtAcresController.text;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddCrop(),
                          ),
                        );
                      }

                      setState(() {});
                    },
                    child: const Text("next"),
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
