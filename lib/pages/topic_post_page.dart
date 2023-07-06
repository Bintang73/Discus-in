import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stalkin/models/post.dart';
import 'package:stalkin/widgets/not_found_card.dart';
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
  List<Post> filteredPosts = [];
  TextEditingController search = TextEditingController();
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
      QuerySnapshot<Object?> snapshot =
          await postCollection.where('kategori', isEqualTo: widget.name).get();
      if (snapshot.docs.isNotEmpty) {
        for (int i = 0; i < snapshot.docs.length && i < 20; i++) {
          String email = snapshot.docs[i].get('email');
          int jumlahlike = snapshot.docs[i].get('likeby').length;
          int jumlahdislike = snapshot.docs[i].get('dislikeby').length;
          int totallikeanddislike = 0;
          if (jumlahlike == 0) {
            totallikeanddislike = jumlahlike - jumlahdislike;
          } else if (jumlahlike == 0 && jumlahdislike == 0) {
            totallikeanddislike = 0;
          } else {
            totallikeanddislike = jumlahlike;
          }
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
            int likeCount = totallikeanddislike;
            int userTimestamp = snapshot.docs[i].get('timestamp');
            posts.add(
              Post(
                idPost: getDocId,
                idTopic: getTopic,
                profileUser: userUrlProfile,
                nameUser: name,
                content: userContent,
                votes: likeCount,
                timestamp: userTimestamp,
                originalpost: userContent,
              ),
            );
          }
        }
        setState(() {
          filteredPosts = posts; // Initialize filteredPosts with all posts
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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

  void searchPosts(String query) {
    setState(() {
      filteredPosts = posts.where((post) {
        final String content = post.content.toLowerCase();
        final String nameUser = post.nameUser.toLowerCase();
        final String queryLower = query.toLowerCase();
        return content.contains(queryLower) || nameUser.contains(queryLower);
      }).toList();
    });
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
                onChanged: (query) => searchPosts(query),
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
            if (isLoading)
              Column(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(left: 32, right: 32, bottom: 26),
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
                    margin:
                        const EdgeInsets.only(left: 32, right: 32, bottom: 26),
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
                    margin:
                        const EdgeInsets.only(left: 32, right: 32, bottom: 26),
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
            if (!isLoading && filteredPosts.isEmpty)
              const NotFoundCard(deskripsi: 'Belum ada postingan sama sekali.'),
            ...filteredPosts.map((post) => PostCard(post)).toList(),
          ],
        ),
      ),
    );
  }
}
