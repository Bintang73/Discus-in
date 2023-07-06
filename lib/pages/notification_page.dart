import 'package:flutter/material.dart';
import 'package:stalkin/models/notification.dart';
import 'package:stalkin/widgets/notification_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../theme.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final balas = TextEditingController();
  List<NotificationModel> notif = [];
  final currentUser = FirebaseAuth.instance.currentUser!;
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
          String originalContent = snapshot.docs[i].get('postingan');
          String email = snapshot.docs[i].get('email');

          DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
              .collection('Users')
              .doc(email)
              .get();
          if (docSnapshot.exists) {
            String getDocId = snapshot.docs[i].id;

            CollectionReference filterComment =
                FirebaseFirestore.instance.collection('User Post');
            QuerySnapshot<Object?> snapComment = await filterComment
                .doc(getDocId)
                .collection('Comments')
                .orderBy('CommentTime', descending: false)
                .get();

            if (snapComment.docs.isNotEmpty) {
              for (int j = 0; j < snapComment.docs.length && j < 20; j++) {
                int jumlahlike = snapComment.docs[j].get('likedBy').length;
                int jumlahdislike =
                    snapComment.docs[j].get('dislikedBy').length;
                int totallikeanddislike = 0;
                if (jumlahlike == 0) {
                  totallikeanddislike = jumlahlike - jumlahdislike;
                } else if (jumlahlike == 0 && jumlahdislike == 0) {
                  totallikeanddislike = 0;
                } else {
                  totallikeanddislike = jumlahlike;
                }
                Map<String, dynamic> data =
                    docSnapshot.data() as Map<String, dynamic>;
                String name = data['name'];
                String userUrlProfile = data['urlProfile'];
                String userContent = snapComment.docs[j].get('CommentText');
                String getTopic = snapComment.docs[j].get('idTopic');
                int jumlahvote = totallikeanddislike;
                int userTimestamp = snapComment.docs[j].get('CommentTime');

                notif.add(
                  NotificationModel(
                      idPost: getDocId,
                      idTopic: getTopic,
                      profileUser: userUrlProfile,
                      nameUser: name,
                      content: userContent,
                      votes: jumlahvote,
                      timestamp: userTimestamp,
                      originalpost: originalContent),
                );
              }
            }
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
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
                        'Notification',
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
              const SizedBox(height: 38),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    ...notif
                        .map(
                          (model) => CustomNotification(notification: model),
                        )
                        .toList(),
                  ],
                ),
              ),
              // Add your remaining ListView children here
            ]),
          ),
        ],
      ),
    );
  }
}
