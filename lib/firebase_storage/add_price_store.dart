


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:krishi_mitra/models/add_price_model.dart';

class AddPrices{

  static Future<void> addPrice() async{
     FirebaseFirestore.instance.collection("cropPrices").doc().update(
         {"price": FieldValue.arrayUnion(["500 to 700"])}
     );
  }

}