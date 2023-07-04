import 'package:flutter/material.dart';

import '../theme.dart';

class MyTitle extends StatelessWidget {
  final String title;
  const MyTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 38,
        bottom: 16,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 28),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: semiPoppins.copyWith(
          fontSize: 22,
          color: blackColor,
        ),
      ),
    );
  }
}
