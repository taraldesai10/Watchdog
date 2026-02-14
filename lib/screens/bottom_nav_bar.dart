import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krishi_mitra/screens/home_screen/home_page.dart';
import 'package:krishi_mitra/screens/mandi/mandi_page.dart';
import 'package:krishi_mitra/screens/more/more_page.dart';

class CommonBottomNavigation extends StatefulWidget {
  const CommonBottomNavigation({super.key});
static  int page = 0;
  @override
  State<CommonBottomNavigation> createState() => _CommonBottomNavigationState();
}

class _CommonBottomNavigationState extends State<CommonBottomNavigation> {

  final List pages = [
    const HomePage(),
    const MandiPage(),
    const MorePage(),
  ];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: pages[CommonBottomNavigation.page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: CommonBottomNavigation.page,
        height: 60,
        items:  <Widget>[
          Icon(
            CupertinoIcons.home,
            size: 30,
            color: Colors.green[900],
          ),
          Icon(
            CupertinoIcons.tree,
            size: 30,
            color: Colors.green[900],
          ),

          Icon(
            Icons.menu,
            size: 30,
            color: Colors.green[1000],
          )
        ],
        color: Colors.green.shade600,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOutQuart,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {

            CommonBottomNavigation. page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
