import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stalkin/models/post.dart';
import 'package:stalkin/theme.dart';
import 'package:stalkin/widgets/comment_card.dart';
import 'package:stalkin/widgets/post_content.dart';

import '../models/comment.dart';

class CommentPage extends StatefulWidget {
  final String name;
  final String content;
  final int votes;
  final String idPost;
  final String idTopic;
  final Timestamp timestamp;

  const CommentPage({
    Key? key,
    required this.name,
    required this.content,
    required this.votes,
    required this.idPost,
    required this.idTopic,
    required this.timestamp,
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
            PostContent(Post(
              idPost: widget.idPost,
              idTopic: widget.idTopic,
              nameUser: widget.name,
              content: widget.content,
              votes: widget.votes,
              timestamp: widget.timestamp,
            )),
            CommentCard(
              Comment(
                idComment: 1,
                idPost: 1,
                idUser: 2,
                content: 'Test Comment',
                votes: 4,
                timeStamp: Timestamp.now(),
              ),
              name: 'Anton',
            ),
            CommentCard(
              Comment(
                idComment: 1,
                idPost: 1,
                idUser: 2,
                content: 'Hmm Menarik',
                votes: 100,
                timeStamp: Timestamp.now(),
              ),
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
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.send,
                      color: blackColor,
                    ),
                  ),
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
