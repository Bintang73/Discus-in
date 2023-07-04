import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stalkin/models/post.dart';
import 'package:stalkin/widgets/post_card.dart';
import '../theme.dart';

class TopicPostPage extends StatefulWidget {
  final String name;
  const TopicPostPage({Key? key, required this.name}) : super(key: key);

  @override
  State<TopicPostPage> createState() => _TopicPostPageState();
}

class _TopicPostPageState extends State<TopicPostPage> {
  List<Post> posts = [];
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPost();
  }

  Future<void> getPost() async {
    try {
      CollectionReference postCollection =
          FirebaseFirestore.instance.collection('User Post');
      QuerySnapshot<Object?> snapshot =
          await postCollection.where('kategori', isEqualTo: widget.name).get();
      // ignore: prefer_is_empty
      if (snapshot.docs.length > 0) {
        for (int i = 0; i < snapshot.docs.length && i < 20; i++) {
          String email = snapshot.docs[i].get('email');
          DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
              .collection('Users')
              .doc(email)
              .get();
          setState(() {
            if (docSnapshot.exists) {
              Map<String, dynamic> data =
                  docSnapshot.data() as Map<String, dynamic>;
              String name = data['name'];
              String userUrlProfile = data['urlProfile'];
              String userContent = snapshot.docs[i].get('postingan');
              int userCommentCount = snapshot.docs[i].get('commentCount');
              int userTimestamp = snapshot.docs[i].get('timestamp');
              posts.add(
                Post(
                  idPost: email,
                  idTopic: widget.name,
                  profileUser: userUrlProfile,
                  nameUser: name,
                  content: userContent,
                  votes: userCommentCount,
                  timestamp: userTimestamp,
                ),
              );
            }
          });
        }
      } // Trigger a rebuild after retrieving the posts
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: semiPoppins,
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child: Text(
                widget.name,
                style: semiPoppins.copyWith(fontSize: 24, color: whiteColor),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30, left: 32, right: 32),
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
                controller: search,
                style: regularPoppins.copyWith(fontSize: 14),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: whiteColor,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: secondaryColor, width: 2.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Cari",
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: mainColor,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            if (posts.isEmpty)
              Center(
                child: Text(
                  'No data available',
                  style: semiPoppins.copyWith(fontSize: 16, color: whiteColor),
                ),
              ),
            ...posts.map((post) => PostCard(post)).toList(),
          ],
        ),
      ),
    );
  }
}
