import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stalkin/widgets/bookmark_card_profile.dart';

import '../models/post.dart';
import '../theme.dart';
import 'not_found_card.dart';

class MyBookmark extends StatefulWidget {
  const MyBookmark({super.key});

  @override
  State<MyBookmark> createState() => _MyBookmarkState();
}

class _MyBookmarkState extends State<MyBookmark> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  List<Post> posts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getBookmark();
  }

  Future<void> getBookmark() async {
    try {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.email)
          .get();

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        List getBookmarkId = data["bookmarkId"];
        for (int i = 0; i < getBookmarkId.length && i < 20; i++) {
          DocumentSnapshot docGetBookmark = await FirebaseFirestore.instance
              .collection('User Post')
              .doc(getBookmarkId[i])
              .get();

          Map<String, dynamic> dataBookmark =
              docGetBookmark.data() as Map<String, dynamic>;

          int jumlahlike = dataBookmark['likeby'].length;
          int jumlahdislike = dataBookmark['dislikeby'].length;
          int totallikeanddislike = 0;
          if (jumlahlike == 0) {
            totallikeanddislike = jumlahlike - jumlahdislike;
          } else if (jumlahlike == 0 && jumlahdislike == 0) {
            totallikeanddislike = 0;
          } else {
            totallikeanddislike = jumlahlike;
          }

          String email = dataBookmark['email'];

          DocumentSnapshot getdocUser = await FirebaseFirestore.instance
              .collection('Users')
              .doc(email)
              .get();

          String name = getdocUser['name'];
          String userUrlProfile = getdocUser['urlProfile'];
          String userContent = dataBookmark['postingan'];
          String getDocId = docGetBookmark.id;
          String getTopic = dataBookmark['kategori'];
          int jumlahvote = totallikeanddislike;
          int userTimestamp = dataBookmark['timestamp'];
          posts.add(
            Post(
              idPost: getDocId,
              idTopic: getTopic,
              profileUser: userUrlProfile,
              nameUser: name,
              content: userContent,
              votes: jumlahvote,
              timestamp: userTimestamp,
            ),
          );
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isLoading)
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 26),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 180,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 26),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 180,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 26),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: Container(
                          height: 180,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              if (!isLoading && posts.isEmpty)
                const NotFoundCard(
                  deskripsi: 'Anda belum bookmark postingan apapun.',
                ),
              if (!isLoading && posts.isNotEmpty)
                ...posts
                    .map(
                      (post) => BookmarkCardProfile(
                        post: post,
                        onDelete: deletePost,
                      ),
                    )
                    .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
