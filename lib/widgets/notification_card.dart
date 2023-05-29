import 'package:flutter/material.dart';
import 'package:stalkin/models/notification.dart';

import '../theme.dart';

class NotificationUser extends StatelessWidget {
  final Notifications notif;
  const NotificationUser(this.notif, {super.key});

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
                Text(
                  notif.message,
                  style: regularPoppins.copyWith(fontSize: 13),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {},
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
