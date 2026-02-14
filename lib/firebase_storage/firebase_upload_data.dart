// ignore_for_file: invalid_return_type_for_catch_error, avoid_print

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mitra/common/shared_pref.dart';

import 'package:krishi_mitra/models/crop_detail_model.dart';
import 'package:krishi_mitra/screens/bottom_nav_bar.dart';
import 'package:krishi_mitra/screens/home_screen/crop_doctor/add_crop.dart';
import 'package:krishi_mitra/screens/home_screen/crop_doctor/add_crop_detail.dart';
import 'package:krishi_mitra/screens/home_screen/crop_doctor/choose_crop.dart';
import 'package:krishi_mitra/screens/more/edit_profile.dart';

class UploadData {
  static String uploadCollection = "upload";
  static CollectionReference upload =
      FirebaseFirestore.instance.collection(uploadCollection);
  static final userId = FirebaseAuth.instance.currentUser;
  static Future<void> addUploadData() async {

    return await upload
        .doc()
        .set(
          CropDetail(
            image: SharedPref.getUserImage,
            name : SharedPref.getUserName,
            userMobile: SharedPref.getPhoneNumber ,
            acres: AddCropDetail.acers.toString(),
            condition: AddCropDetail.selectedCondition.toString(),
            cropName: ChooseCrop.cropName.toString(),
            date: AddCropDetail.plantedDate.toString(),
            picture: AddCrop.url!,
            uid: userId!.uid,
          ).toJson(),
        )
        .then(
      (value) {
        Get.offUntil(
          MaterialPageRoute(
            builder: (context) => const CommonBottomNavigation(),
          ),
          (route) => false,
        );
        log("data Upload");
      },
    ).catchError((onError) => print(onError));
  }
}
