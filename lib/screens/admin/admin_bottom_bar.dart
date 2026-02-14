import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krishi_mitra/screens/admin/admin_add_doctor_page.dart';
import 'package:krishi_mitra/screens/admin/admin_crop_page.dart';

class AdminBottomBar extends StatefulWidget {
  const AdminBottomBar({super.key});

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  int page = 0;

  final List pages = [
    const AdminCropPage(),
    const AdminDoctorAddPage(),
  ];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: pages[page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60,
        items: const <Widget>[
          Icon(
            CupertinoIcons.tree,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: Colors.green.shade700,
        buttonBackgroundColor: Colors.green[900],
        backgroundColor: Colors.transparent,
        animationCurve: Curves.ease,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
