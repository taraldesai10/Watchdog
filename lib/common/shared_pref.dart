import 'package:shared_preferences/shared_preferences.dart';

class SharedKey {
  static String phoneNumber = "PhoneNumber";
  static String userName = "UserName";
  static String userImage = "UserImage";
}

class SharedPref {
  static SharedPreferences? pref;
  static Future<SharedPreferences> get init async =>
      pref = await SharedPreferences.getInstance();

  //for the set value
  static set setPhoneNumber(String data) =>
      pref!.setString(SharedKey.phoneNumber, data);
  static set setUserName(String name) =>
      pref!.setString(SharedKey.userName, name);
  static set setUserImage(String image) =>
      pref!.setString(SharedKey.userImage, image);

  //for the get value
  static String get getPhoneNumber =>
      pref!.getString(SharedKey.phoneNumber) ?? "";
  static String get getUserName => pref!.getString(SharedKey.userName) ?? "";
  static String get getUserImage => pref!.getString(SharedKey.userImage) ?? "";
}
