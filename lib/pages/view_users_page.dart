import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stalkin/theme.dart';
import 'package:stalkin/widgets/post_card.dart';

import '../models/post.dart';

class ViewUsersPage extends StatefulWidget {
  final String urlProfile;
  final String name;
  final String bio;
  const ViewUsersPage(
      {super.key,
      required this.urlProfile,
      required this.name,
      required this.bio});

  @override
  State<ViewUsersPage> createState() => _ViewUsersPageState();
}

class _ViewUsersPageState extends State<ViewUsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 23),
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
                            child: Image.asset(
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
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 28, vertical: 10),
                    child: Text(
                      'My Post',
                      style:
                          semiPoppins.copyWith(fontSize: 24, color: whiteColor),
                    ),
                  ),
                  PostCard(
                    Post(
                      idPost: '1',
                      idTopic: '1',
                      nameUser: 'Username',
                      content: 'Test post 1',
                      votes: 122,
                      timestamp: Timestamp.now(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
