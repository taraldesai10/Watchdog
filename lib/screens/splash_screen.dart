// ignore_for_file: unused_field

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:krishi_mitra/screens/bottom_nav_bar.dart';

import 'package:krishi_mitra/screens/language_page.dart';
import 'package:krishi_mitra/screens/select_side.dart';

import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const keyLogin = "LOGIN";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _splashContoller = AnimationController(vsync: this);

  @override
  void initState() {
    super.initState();
    forShared();
    _splashContoller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/lottie/Animation - 1706774554783.json",
          height: 200,
        ),
      ),
    );
  }

  void forShared() async {
    var sharePre = await SharedPreferences.getInstance();
    var isLogIn = sharePre.getBool(SplashScreen.keyLogin);

    Timer(
      const Duration(seconds: 5),
      () {
        if (isLogIn != null) {
          if (isLogIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CommonBottomNavigation()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SelectSide()),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SelectSide()),
          );
        }
      },
    );
  }
}
