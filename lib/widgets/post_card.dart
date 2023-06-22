import 'package:flutter/material.dart';
import 'package:stalkin/pages/comment_page.dart';

import '../models/post.dart';
import '../theme.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 32, right: 32, bottom: 26),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    post.nameUser,
                    style: regularPoppins.copyWith(fontSize: 14),
                  ),
                ],
              ),
              const Icon(Icons.bookmark_border_outlined)
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Flexible(
              child: Text(
                post.content,
                style: regularPoppins.copyWith(fontSize: 12),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.thumb_up_alt_outlined),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    post.likes.toString(),
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
                    post.dislike.toString(),
                    style: boldPoppins.copyWith(fontSize: 14),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CommentPage(
                      name: post.nameUser,
                      content: post.content,
                      like: post.likes,
                      dislike: post.dislike,
                    );
                  }));
                },
                child: Row(
                  children: [
                    const Icon(Icons.chat_bubble_outline_rounded),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Lihat',
                      style: boldPoppins.copyWith(fontSize: 14),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
