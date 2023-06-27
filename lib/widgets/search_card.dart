import 'package:flutter/material.dart';
import 'package:stalkin/models/user.dart';
import 'package:stalkin/pages/view_users_page.dart';

import '../theme.dart';

class SearchUsers extends StatelessWidget {
  final Users user;
  const SearchUsers(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    user.urlProfile,
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  user.name,
                  style: regularPoppins.copyWith(fontSize: 13),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ViewUsersPage(
                    urlProfile: user.urlProfile,
                    name: user.name,
                    bio: user.bio,
                  );
                }));
              },
              child: Container(
                height: 30,
                width: 62,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: secondaryColor,
                ),
                child: Text(
                  'Lihat',
                  style: semiPoppins.copyWith(fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
