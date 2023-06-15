import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stalkin/pages/home_page.dart';
import 'package:stalkin/pages/notification_page.dart';
import 'package:stalkin/pages/post_page.dart';
import 'package:stalkin/pages/profile_page.dart';
import 'package:stalkin/pages/search_page.dart';

import '../theme.dart';

class MyNavigation extends StatefulWidget {
  const MyNavigation({super.key});

  @override
  State<MyNavigation> createState() => _MyNavigationState();
}

class _MyNavigationState extends State<MyNavigation> {
  int currentIndex = 0;
  List myMenu = const [
    HomePage(),
    SearchPage(),
    PostPage(),
    NotificationPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: myMenu[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28), topRight: Radius.circular(28)),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            onTabChange: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            backgroundColor: whiteColor,
            color: greyColor,
            activeColor: blackColor,
            tabBackgroundColor: secondaryColor,
            padding: const EdgeInsets.all(16),
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.home,
              ),
              GButton(
                icon: Icons.search,
              ),
              GButton(
                icon: Icons.add,
              ),
              GButton(
                icon: Icons.notifications,
              ),
              GButton(
                icon: Icons.person,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
