


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishi_mitra/firebase_storage/firebase_option_auth.dart';
import 'package:krishi_mitra/screens/admin/admin_bottom_bar.dart';
import 'package:krishi_mitra/screens/bottom_nav_bar.dart';


import 'package:krishi_mitra/screens/for_doctors/doctor_home_screen.dart';
import 'package:krishi_mitra/screens/home_screen/home_page.dart';
import 'package:krishi_mitra/screens/login_page.dart';
import 'package:krishi_mitra/screens/mandi/mandi_page.dart';
import 'package:krishi_mitra/screens/splash_screen.dart';





import 'package:krishi_mitra/utils/app_constants.dart';
import 'package:krishi_mitra/utils/messeges.dart';

import 'common/shared_pref.dart';
import 'controllers/language_controller.dart';
import 'utils/dependency_inj.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SharedPref.init;
  Map<String, Map<String, String>> languages = await dep.init();

  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(
      builder: (localizationController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          locale: localizationController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[1].languageCode,
              AppConstants.languages[1].countryCode),
          //
          //
          //
          //
          home: const SplashScreen (),
          //
          //
          //
          //
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.green.shade200,
              background: Colors.green.shade100,
            ),
          ),
        );
      },
    );
  }
}
