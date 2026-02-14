// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:krishi_mitra/firebase_storage/firebase_upload_data.dart';


class AddCrop extends StatefulWidget {
  const AddCrop({super.key});
  static File? imageFile;
  static String? url;

  @override
  State<AddCrop> createState() => _AddCropState();
}

class _AddCropState extends State<AddCrop> {
  // var result;

DateTime now = DateTime.now();
  final picker = ImagePicker();

  Future selectFile() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      AddCrop.imageFile = File(pickedFile!.path);
    });
  }

  // Future selectFile() async {
  //   result = await FilePicker.platform.pickFiles();
  //   if (result == null) return;
  //   setState(() {
  //     AddCrop.pickedFile = result.files.first;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "crop doctor".tr,
          style: GoogleFonts.lato(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (AddCrop.imageFile != null)
              SizedBox(
                height: 300,
                child: Image.file(
                  File(AddCrop.imageFile!.path),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectFile,
              child:  Text("select picture".tr),
            ),

            (AddCrop.imageFile != null)
                ? ElevatedButton(
                    onPressed: () async {
                      if (AddCrop.imageFile == null) {
                        log("empty image");
                      } else {

                        final ref =
                            FirebaseStorage.instance.ref().child("cropImages").child("${now}.jpg");
                        await ref.putFile(AddCrop.imageFile!);
                        AddCrop.url = await ref.getDownloadURL();
                        AddCrop.imageFile = null;
                      }

                      await UploadData.addUploadData();
                      AddCrop.url = null;
                      // log(UploadData.addUploadData().toString());
                      setState(() {});
                    },
                    child:  Text("upload".tr),
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.green[200],
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "upload".tr,
                      style: GoogleFonts.lato(color: Colors.white),
                    ),
                  ),
            const SizedBox(
              height: 32,
            ),
            // buildProgress(),
          ],
        ),
      ),
    );
  }

  // Widget buildProgress() => StreamBuilder<TaskSnapshot>(
  //       stream: uploadTask?.snapshotEvents,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           final data = snapshot.data!;
  //           var progress = data.bytesTransferred / data.totalBytes * 100;
  //           return SizedBox(
  //             height: 40,
  //             child: Stack(fit: StackFit.expand, children: [
  //               LinearProgressIndicator(
  //                 borderRadius: BorderRadiusDirectional.circular(30),
  //                 value: progress,
  //                 backgroundColor: Colors.grey,
  //                 color: Colors.green,
  //               ),
  //               (progress == 100)
  //                   ? const Center(
  //                       child: Text("done"),
  //                     )
  //                   : Center(
  //                       child: Text(
  //                       "${(100 * progress).roundToDouble()}%",
  //                       style: const TextStyle(color: Colors.white),
  //                     ))
  //             ]),
  //           );
  //         } else {
  //           return const SizedBox(
  //             height: 50,
  //           );
  //         }
  //       },
  //     );
}
