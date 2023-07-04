import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stalkin/theme.dart';
import 'package:stalkin/widgets/not_found_card.dart';
import 'package:stalkin/widgets/post_card.dart';
import 'package:stalkin/widgets/title.dart';

import '../models/post.dart';

class ViewUsersPage extends StatefulWidget {
  final String urlProfile;
  final String name;
  final String bio;
  final String email;
  const ViewUsersPage(
      {super.key,
      required this.urlProfile,
      required this.name,
      required this.bio,
      required this.email});

  @override
  State<ViewUsersPage> createState() => _ViewUsersPageState();
}

class _ViewUsersPageState extends State<ViewUsersPage> {
  List<Post> posts = [];
  bool isLoading = true;

  Future<void> getPost() async {
    try {
      CollectionReference postCollection =
          FirebaseFirestore.instance.collection('User Post');
      QuerySnapshot<Object?> snapshot =
          await postCollection.where('email', isEqualTo: widget.email).get();

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 42),
              decoration: BoxDecoration(
                color: whiteColor,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              widget.urlProfile,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            widget.name,
                            style: semiPoppins.copyWith(fontSize: 16),
                          ),
                        ),
                        Text(
                          '"${widget.bio}"',
                          textAlign: TextAlign.center,
                          style: regularPoppins.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: MyTitle(title: '${widget.name}\'s Posts')),
                if (isLoading)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                if (!isLoading && posts.isEmpty)
                  const NotFoundCard(
                      deskripsi: 'You have not posted anything yet.'),
                if (!isLoading && posts.isNotEmpty)
                  ...posts
                      .map(
                        (post) => PostCard(post),
                      )
                      .toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
