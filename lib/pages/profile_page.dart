import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: whiteColor,
              elevation: 2,
              pinned: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              toolbarHeight: 70, // Adjust the desired height here
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Aligns the text vertically at the center
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Profile',
                        style: semiPoppins.copyWith(
                            fontSize: 24, color: mainColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: const EdgeInsets.only(top: 38),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 286,
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 8, right: 8),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.settings,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 36),
                                      // color: Colors.red,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.asset(
                                              'assets/captcha/1.jpg',
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 12),
                                            child: Text(
                                              'Anton Subroto',
                                              style: semiPoppins.copyWith(
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 18),
                                            child: Text(
                                              '"Lorem Ipsum is simply dummy text of the printing and typesetting industry."',
                                              textAlign: TextAlign.center,
                                              style: regularPoppins.copyWith(
                                                  fontSize: 12),
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: secondaryColor,
                                              ),
                                              child: Text(
                                                'Log Out',
                                                style: semiPoppins.copyWith(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
                // Add your remaining ListView children here
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
