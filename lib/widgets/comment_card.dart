import 'package:flutter/material.dart';

import '../models/comment.dart';
import '../theme.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;
  final String name;
  const CommentCard(this.comment, {super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/captcha/1.jpg',
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                name,
                style: regularPoppins.copyWith(fontSize: 14),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  comment.content,
                  style: regularPoppins.copyWith(fontSize: 12),
                ),
              ),
            ),
          ),
          Row(
            children: [
              const Icon(Icons.thumb_up_alt_outlined),
              const SizedBox(
                width: 8,
              ),
              Text(
                comment.likes.toString(),
                style: boldPoppins.copyWith(fontSize: 14),
              ),
              const SizedBox(
                width: 24,
              ),
              const Icon(Icons.thumb_down_alt_outlined),
              const SizedBox(
                width: 8,
              ),
              Text(
                comment.dislike.toString(),
                style: boldPoppins.copyWith(fontSize: 14),
              )
            ],
          ),
        ],
      ),
    );
  }
}
