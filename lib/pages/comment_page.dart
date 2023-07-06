import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final String profileUser;
  final int timestamp;

  const CommentPage({
    Key? key,
    required this.name,
    required this.content,
    required this.votes,
    required this.idPost,
    required this.idTopic,
    required this.profileUser,
    required this.timestamp,
  }) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController commentController = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser!;

  void addComment(String commentText) async {
    CollectionReference commentsRef = FirebaseFirestore.instance
        .collection('User Post')
        .doc(widget.idPost)
        .collection('Comments');

    DocumentReference newCommentRef =
        commentsRef.doc(); // Generate a new document reference

    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch ~/ 1000;

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.email)
        .get();

    final userData = userSnapshot.data() as Map<String, dynamic>;

    newCommentRef.set({
      'likedBy': [],
      'dislikedBy': [],
      'idComment': newCommentRef.id, // Use the ID of the new comment document
      'idPost': widget.idPost,
      'idTopic': widget.idTopic,
      'CommentText': commentText,
      'CommentedBy': userData['name'],
      'profile': userData['urlProfile'],
      'CommentTime': timestamp,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: ListView(
          children: [
            PostContent(
              Post(
                idPost: widget.idPost,
                idTopic: widget.idTopic,
                profileUser: widget.profileUser,
                nameUser: widget.name,
                content: widget.content,
                votes: widget.votes,
                timestamp: widget.timestamp,
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('User Post')
                  .doc(widget.idPost)
                  .collection('Comments')
                  .orderBy('CommentTime', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                // show loading circle if no data
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: snapshot.data!.docs.map((doc) {
                    final commentData = doc.data() as Map<String, dynamic>;

                    int jumlahlike = commentData['likedBy'].length;
                    int jumlahdislike = commentData['dislikedBy'].length;
                    int totallikeanddislike = 0;
                    if (jumlahlike == 0) {
                      totallikeanddislike = jumlahlike - jumlahdislike;
                    } else if (jumlahlike == 0 && jumlahdislike == 0) {
                      totallikeanddislike = 0;
                    } else {
                      totallikeanddislike = jumlahlike;
                    }

                    return CommentCard(
                      Comment(
                        idComment: commentData['idComment'],
                        idPost: commentData['idPost'],
                        content: commentData['CommentText'],
                        votes: totallikeanddislike,
                        timeStamp: commentData['CommentTime'],
                      ),
                      name: commentData['CommentedBy'],
                      urlProfile: commentData['profile'],
                    );
                  }).toList(),
                );
              },
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
                    onTap: () {
                      addComment(commentController.text);
                      commentController.clear();
                    },
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
                  hintText: 'Add Comment',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
