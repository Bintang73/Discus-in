import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stalkin/widgets/post_card_profile.dart';
import 'package:stalkin/widgets/title.dart';

import '../models/post.dart';
import '../theme.dart';
import 'not_found_card.dart';

class MyPost extends StatefulWidget {
  const MyPost({super.key});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  List<Post> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getPost();
  }

  Future<void> getPost() async {
    try {
      CollectionReference postCollection =
          FirebaseFirestore.instance.collection('User Post');
      QuerySnapshot<Object?> snapshot = await postCollection
          .where('email', isEqualTo: currentUser.email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length && i < 20; i++) {
          String email = snapshot.docs[i].get('email');
          DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
              .collection('Users')
              .doc(email)
              .get();
          if (docSnapshot.exists) {
            Map<String, dynamic> data =
                docSnapshot.data() as Map<String, dynamic>;
            String name = data['name'];
            String userUrlProfile = data['urlProfile'];
            String userContent = snapshot.docs[i].get('postingan');
            String getDocId = snapshot.docs[i].id;
            String getTopic = snapshot.docs[i].get('kategori');
            int userCommentCount = snapshot.docs[i].get('commentCount');
            int userTimestamp = snapshot.docs[i].get('timestamp');
            posts.add(
              Post(
                idPost: getDocId,
                idTopic: getTopic,
                profileUser: userUrlProfile,
                nameUser: name,
                content: userContent,
                votes: userCommentCount,
                timestamp: userTimestamp,
              ),
            );
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: semiPoppins,
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void deletePost(Post post) {
    setState(() {
      posts.remove(post);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Container(
        margin: EdgeInsets.only(left: 32, right: 32, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLoading)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            if (!isLoading && posts.isEmpty)
              const NotFoundCard(
                deskripsi: 'Anda belum membuat postingan apapun.',
              ),
            if (!isLoading && posts.isNotEmpty)
              ...posts
                  .map(
                    (post) => PostCardProfile(
                      post: post,
                      onDelete: deletePost,
                    ),
                  )
                  .toList(),
          ],
        ),
      ),
    );
  }
}
