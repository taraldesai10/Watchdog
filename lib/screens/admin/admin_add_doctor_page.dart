import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:krishi_mitra/firebase_storage/add_doctor_store.dart';

class AdminDoctorAddPage extends StatefulWidget {
  const AdminDoctorAddPage({super.key});

  static late String doctorEmail;
  static late String doctorPass;
  static late String doctorName;
  static String? docId;
  static TextEditingController txtUpdateEmailController =
      TextEditingController();
  static TextEditingController txtUpdatePassController =
      TextEditingController();
  static TextEditingController txtUpdateDoctorNameController =
      TextEditingController();

  @override
  State<AdminDoctorAddPage> createState() => _AdminDoctorAddPageState();
}

class _AdminDoctorAddPageState extends State<AdminDoctorAddPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtPassController = TextEditingController();
  TextEditingController txtDoctorNameController = TextEditingController();

  late String upDocName;
  late String upEmail;
  late String upPass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Text(
          "Add Doctor",
          style: GoogleFonts.lato(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                useSafeArea: true,
                context: context,
                builder: (context) => Dialog(
                  // backgroundColor: Colors.green[200],
                  child: SingleChildScrollView(
                    child: dilogBox(),
                  ),
                ),
              );

              setState(() {});
            },
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 10),
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("addDoctor").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: Text("no data"));
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  ...List.generate(
                    snapshot.data!.docs.length,
                    (index) => Dismissible(
                      confirmDismiss: (direction) {
                        return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("cancel"),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    // AddDoctorStore.deleteDoctor();
                                    FirebaseFirestore.instance
                                        .collection("addDoctor")
                                        .doc(snapshot.data!.docs[index].id)
                                        .delete().then((value) =>  Navigator.pop(context));
                                    // Navigator.pop(context);
                                  },
                                  child: Text("yes"))
                            ],
                            title: Text("are you sure want to delete?"),
                          ),
                        );
                      },
                      key: UniqueKey(),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: EdgeInsets.all(15),
                          tileColor: Colors.green[400],
                          title: Text(
                            snapshot.data!.docs[index]["doctorName"],
                          ),
                          subtitle: Text(
                            snapshot.data!.docs[index]["email"],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                AdminDoctorAddPage.docId =
                                    snapshot.data!.docs[index].id;
                                upDocName =
                                    snapshot.data!.docs[index]["doctorName"];
                                upEmail = snapshot.data!.docs[index]["email"];
                                upPass = snapshot.data!.docs[index]["pass"];
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    child: updateDilog(),
                                  ),
                                );
                              });
                            },
                            child: Text("update"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget dilogBox() => Container(
        padding: const EdgeInsets.all(20),
        height: 500,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.green.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Add Doctor",
                  style: GoogleFonts.lato(
                      color: Colors.green[900],
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: "please enter doctor name")
                  ]).call,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.person),
                  ),
                  controller: txtDoctorNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: MultiValidator([
                    EmailValidator(errorText: "please enter valid mail"),
                    RequiredValidator(errorText: "enter mail")
                  ]).call,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.mail),
                  ),
                  controller: txtEmailController,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: MultiValidator([
                    MaxLengthValidator(10, errorText: "max length is 10"),
                    RequiredValidator(errorText: "please enter passwoed")
                  ]).call,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.padlock),
                  ),
                  controller: txtPassController,
                ),
                const SizedBox(
                  height: 30,
                ),
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
                        if (_key.currentState!.validate()) {
                          AdminDoctorAddPage.doctorName =
                              txtDoctorNameController.text;
                          AdminDoctorAddPage.doctorEmail =
                              txtEmailController.text;
                          AdminDoctorAddPage.doctorPass =
                              txtPassController.text;

                          AddDoctorStore.addDoctorStore();
                          setState(() {
                            Navigator.pop(context);
                            txtDoctorNameController.clear();
                            txtEmailController.clear();
                            txtPassController.clear();
                          });
                        }
                      },
                      child: Text("Submit"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Widget updateDilog() => Container(
        padding: const EdgeInsets.all(20),
        height: 500,
        width: 400,
        decoration: BoxDecoration(
          color: Colors.green.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Update Doctor",
                  style: GoogleFonts.lato(
                      color: Colors.green[900],
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: "please enter doctor name")
                  ]).call,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.person),
                  ),
                  controller: AdminDoctorAddPage.txtUpdateDoctorNameController
                    ..text = upDocName.toString(),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: MultiValidator([
                    EmailValidator(errorText: "please enter valid mail"),
                    RequiredValidator(errorText: "enter mail")
                  ]).call,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.mail),
                  ),
                  controller: AdminDoctorAddPage.txtUpdateEmailController
                    ..text = upEmail.toString(),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: MultiValidator([
                    MaxLengthValidator(10, errorText: "max length is 10"),
                    RequiredValidator(errorText: "please enter passwoed")
                  ]).call,
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.padlock),
                  ),
                  controller: AdminDoctorAddPage.txtUpdatePassController
                    ..text = upPass.toString(),
                ),
                const SizedBox(
                  height: 30,
                ),
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
                        if (_key.currentState!.validate()) {
                          AddDoctorStore.updateDoctorStore();
                          Navigator.pop(context);
                          setState(() {});
                        }
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

  @override
  void dispose() {
    txtEmailController.dispose();
    txtPassController.dispose();
    super.dispose();
  }
}
