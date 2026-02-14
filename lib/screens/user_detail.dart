// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_mitra/common/shared_pref.dart';
import 'package:krishi_mitra/firebase_storage/profile_stotre.dart';
import 'package:lottie/lottie.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key});
  static late String profilUrl;
  static late String userName;


  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  DateTime now = DateTime.now();
  File? _image;
  final picker = ImagePicker();
  TextEditingController txtUserNameController = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where("uid", isEqualTo: currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {


              return Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 20),
                                height: 170,
                                width: 170,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(360),
                                      topRight: Radius.circular(370),
                                      bottomLeft: Radius.circular(300),
                                      bottomRight: Radius.circular(300),
                                    ),
                                    color: Colors.green[900],
                                    border: Border.all(color: Colors.white)),
                                child: _image == null
                                    ? Lottie.asset("assets/lottie/profile.json",
                                        fit: BoxFit.cover)
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(360),
                                            topRight: Radius.circular(370),
                                            bottomLeft: Radius.circular(300),
                                            bottomRight: Radius.circular(300),
                                          ),
                                          image: DecorationImage(
                                            image: FileImage(
                                              _image!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                            GestureDetector(
                              onTap: () {
                                showOptions();
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                alignment: Alignment.center,
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(360),
                                    topRight: Radius.circular(370),
                                    bottomLeft: Radius.circular(300),
                                    bottomRight: Radius.circular(300),
                                  ),
                                  color: Colors.green[900],
                                ),
                                child: const Icon(
                                  CupertinoIcons.add,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        TextFormField(
                          controller: txtUserNameController,
                          decoration: InputDecoration(
                            label: Text(
                              "name".tr,
                              style: GoogleFonts.lato(
                                color: Colors.green[900],
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.green[900],
                            ),
                          ),
                          onPressed: () async {
                            UserDetailPage.userName =
                                txtUserNameController.text;
                            if (_image == null) {
                              log("no image");
                            } else {
                              final ref = FirebaseStorage.instance
                                  .ref()
                                  .child("profileImages")
                                  .child("$now.jpg");
                              await ref.putFile(_image!);
                              UserDetailPage.profilUrl =
                                  await ref.getDownloadURL();
                            }
                            setState(() {
                              SharedPref.setUserImage = UserDetailPage.profilUrl.toString();
                              SharedPref.setUserName =UserDetailPage.userName.toString();
                              ProfileStorage.addProfileData();
                            });
                          },
                          child: Text(
                            "Submit",
                            style: GoogleFonts.lato(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );

            return SizedBox();
          },
        )
        );
  }

  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    txtUserNameController.dispose();
    super.dispose();
  }
}
