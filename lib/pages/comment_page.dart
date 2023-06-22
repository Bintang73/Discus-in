import 'package:flutter/material.dart';
import 'package:stalkin/theme.dart';
import 'package:stalkin/widgets/comment_card.dart';

import '../models/comment.dart';

class CommentPage extends StatefulWidget {
  final String name;
  final String content;
  final int like;
  final int dislike;

  const CommentPage({
    Key? key,
    required this.name,
    required this.content,
    required this.like,
    required this.dislike,
  }) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 23),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: whiteColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            widget.name,
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
                        widget.content,
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
                            widget.like.toString(),
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
                            widget.dislike.toString(),
                            style: boldPoppins.copyWith(fontSize: 14),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CommentCard(
              Comment(
                  idComment: 1,
                  idPost: 1,
                  idUser: 2,
                  content: 'Test Comment',
                  likes: 4,
                  dislike: 90),
              name: 'Anton',
            ),
            CommentCard(
              Comment(
                  idComment: 1,
                  idPost: 1,
                  idUser: 2,
                  content: 'Hmm Menarik',
                  likes: 100,
                  dislike: 0),
              name: 'Budi',
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
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
              child: TextField(
                controller: commentController,
                style: regularPoppins.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: whiteColor,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: secondaryColor,
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Comment',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
