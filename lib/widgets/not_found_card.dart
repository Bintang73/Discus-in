import 'package:flutter/material.dart';

import '../theme.dart';

class NotFoundCard extends StatelessWidget {
  final String deskripsi;
  const NotFoundCard({super.key, required this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
      child: Column(
        children: [
          Image.asset(
            'assets/notfound.png',
            height: 120,
          ),
          Text(
            deskripsi,
            textAlign: TextAlign.center,
            style: regularPoppins.copyWith(
              fontSize: 16,
              color: whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
