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
import 'package:krishi_mitra/common/media_query.dart';
import 'package:krishi_mitra/firebase_storage/profile_stotre.dart';
import 'package:krishi_mitra/models/profile_detail_model.dart';
import 'package:krishi_mitra/screens/bottom_nav_bar.dart';
import 'package:lottie/lottie.dart';

import '../../common/shared_pref.dart';
import '../user_detail.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  static late String uid;
  static  String? userName;
  static late String userImage;


  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
   bool forUpdate = false;
  TextEditingController txtNameEditController = TextEditingController();
  var currentUser = FirebaseAuth.instance.currentUser;
  File? _image;
  final picker = ImagePicker();
    TextEditingController txtUserNameController = TextEditingController();
  String forName = "";
  String? name;
  bool forLoading =false;
  DateTime now = DateTime.now();



  @override
  Widget build(BuildContext context) {


forSubmit();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {

            Navigator.pop(context);

          },
          icon: const Icon(CupertinoIcons.arrow_left),
        ),
      ),
      body:  StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where("phone", isEqualTo: SharedPref.getPhoneNumber)
            .snapshots(),
        builder: (context, snapshot) => snapshot.hasData
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      ...List.generate(
                        snapshot.data!.docs.length,
                        (index) => Column(
                          children: [

                            snapshot.data!.docs[index]["image"] != null
                                ? Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      _image == null
                                          ? Container(
                                              alignment: Alignment.center,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green.shade800,
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 2),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    snapshot.data!.docs
                                                        .first["image"],
                                                  ),fit: BoxFit.contain
                                                ),
                                              ),
                                            )
                                          : Container(
                                              alignment: Alignment.center,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.green.shade800,
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 2),
                                                image: DecorationImage(
                                                  image: FileImage(
                                                    _image!,
                                                  ),fit: BoxFit.contain
                                                ),
                                              ),
                                            ),
                                      GestureDetector(
                                        onTap: () {

                                          showOptions();
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: displayWidth(context) / 2.4,
                                              top: displayHeight(context) / 8),
                                          alignment: Alignment.center,
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.green[800],
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 1)),
                                          child: Icon(
                                            CupertinoIcons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green.shade800,
                                    ),
                                    child: Lottie.asset(
                                        "assets/lottie/profile.json"),
                                  ),
                            Container(
                              margin: EdgeInsets.only(top: 40),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 40,
                              ),
                              height: 170,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.green.shade700),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(80)),
                                  color: Colors.green[200]),
                              child: Column(
                                children: [

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.person),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    name != null?Text(
                                      name.toString()
                                      ,
                                      style: GoogleFonts.lato(
                                          color: Colors.green[800],
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ) :Text(
                                         snapshot.data!.docs[index]["name"]
                                    ,
                                       style: GoogleFonts.lato(
                                           color: Colors.green[800],
                                           fontSize: 18,
                                           fontWeight: FontWeight.bold),
                                     ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          forName = snapshot.data!.docs[index]["name"];
                                          showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                              child: nameDilog(),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.edit),
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(CupertinoIcons.phone),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]["phone"],
                                        style: GoogleFonts.lato(
                                            color: Colors.green[800],
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            forUpdate == true
                                ?
                            ElevatedButton(
                                    onPressed: () async {
                                      if(EditProfile.userName == null) {
                                        EditProfile.userName =
                                        snapshot.data!.docs[index]["name"];

                                      }

                                      if (_image == null) {

                                      } else {

final ref = FirebaseStorage.instance
                                            .ref()
                                            .child("profileImage").child("$now.jpg");
                                        await ref.putFile(_image!);
                                        EditProfile.userImage =
                                            await ref.getDownloadURL();
                                      }




setState(() {

  EditProfile.uid = snapshot.data!.docs[index].id;

  Get.offUntil(MaterialPageRoute(builder: (context) => CommonBottomNavigation(),), (route) => false);
SharedPref.setUserImage = EditProfile.userImage;
SharedPref.setUserName = EditProfile.userName!;
  CommonBottomNavigation.page =2;
});



                                        ProfileStorage.updateProfile();


                                    },
                                    child: Text("update".tr))
                                : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: SizedBox(
                height: 100,
                child: Lottie.asset("assets/icons/loading_.json"),
              )),
      ),
    );
  }
  //
  void forSubmit(){
   if (_image != null) {
     forUpdate = true;
   }
  }

  Widget nameDilog() => Container(
    height: 160,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: Colors.transparent),
    child: Form(
      key: _key,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              "update name".tr,
              style: GoogleFonts.lato(
                color: Colors.green[900],
                fontSize: 21,
              ),
            ),
            TextFormField(
              controller: txtUserNameController..text = forName,
            ),
            ElevatedButton(onPressed: (){
              setState(() {
                forUpdate = true;
                name = txtUserNameController.text;
                Navigator.pop(context);
              });

              EditProfile.userName = txtUserNameController.text;
              log(txtUserNameController.text);
            }, child: Text("submit".tr))
          ],
        ),
      ),
    ),
  );

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
