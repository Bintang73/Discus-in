import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stalkin/pages/setting_page.dart';

import '../models/post.dart';
import '../theme.dart';
import '../widgets/post_card_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;
  List<Post> posts = [];

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
      // ignore: prefer_is_empty
      if (snapshot.docs.length > 0) {
        for (int i = 0; i < snapshot.docs.length && i < 20; i++) {
          String email = snapshot.docs[i].get('email');
          DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
              .collection('Users')
              .doc(email)
              .get();
          Map<String, dynamic> data =
              docSnapshot.data() as Map<String, dynamic>;
          String name = data['name'];
          String userUrlProfile = data['urlProfile'];
          String userContent = snapshot.docs[i].get('postingan');
          String getDocId = snapshot.docs[i].id; // Get the document ID
          String getTopic = snapshot.docs[i].get('kategori');
          int userCommentCount = snapshot.docs[i].get('commentCount');
          int userTimestamp = snapshot.docs[i].get('timestamp');
          setState(() {
            if (docSnapshot.exists) {
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: whiteColor,
            elevation: 2,
            pinned: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            toolbarHeight: 70, // Adjust the desired height here
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: const EdgeInsets.only(top: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Aligns the text vertically at the center
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Profile',
                        style: semiPoppins.copyWith(
                            fontSize: 24, color: mainColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.only(top: 38),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 286,
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 8, right: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return const SettingPage();
                                        }));
                                      },
                                      child: const Icon(
                                        Icons.settings,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // buildstream
                              StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(currentUser.email)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  // get user data
                                  if (snapshot.hasData) {
                                    final userData = snapshot.data!.data()
                                        as Map<String, dynamic>;
                                    return Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 36),
                                          // color: Colors.red,
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.network(
                                                  userData['urlProfile'],
                                                  height: 80,
                                                  width: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                child: Text(
                                                  userData['name'],
                                                  style: semiPoppins.copyWith(
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 18),
                                                child: Text(
                                                  // ignore: prefer_interpolation_to_compose_strings
                                                  '${'" ' + userData['bio']} "',
                                                  textAlign: TextAlign.center,
                                                  style: regularPoppins
                                                      .copyWith(fontSize: 12),
                                                ),
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    FirebaseAuth.instance
                                                        .signOut();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        secondaryColor,
                                                  ),
                                                  child: Text(
                                                    'Log Out',
                                                    style: semiPoppins.copyWith(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error ${snapshot.error}'),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 8),
                          child: Text(
                            'My Post',
                            style: semiPoppins.copyWith(
                                fontSize: 24, color: whiteColor),
                          ),
                        ),
                        ...posts.map((post) => PostCardProfile(post)).toList(),
                      ],
                    )),
              ),
              // Add your remaining ListView children here
            ]),
          ),
        ],
      ),
    );
  }
}
