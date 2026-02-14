import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krishi_mitra/models/Add_doctor_model.dart';
import 'package:krishi_mitra/screens/admin/admin_add_doctor_page.dart';

class AddDoctorStore {
  static Future<void> addDoctorStore() {
    return FirebaseFirestore.instance.collection("addDoctor").doc().set(
          AddDoctorModel(
            email: AdminDoctorAddPage.doctorEmail,
            pass: AdminDoctorAddPage.doctorPass,
            doctorName: AdminDoctorAddPage.doctorName,
          ).tojJson(),
        );
  }

  static Future<void> updateDoctorStore() {
    return FirebaseFirestore.instance
        .collection("addDoctor")
        .doc(AdminDoctorAddPage.docId)
        .update(AddDoctorModel(
                email: AdminDoctorAddPage.txtUpdateEmailController.text,
                pass: AdminDoctorAddPage.txtUpdatePassController.text,
                doctorName:
                    AdminDoctorAddPage.txtUpdateDoctorNameController.text)
            .tojJson());
  }

  static Future<void> deleteDoctor() {
    return FirebaseFirestore.instance
        .collection("addDoctor")
        .doc(AdminDoctorAddPage.docId)
        .delete();
  }
}
