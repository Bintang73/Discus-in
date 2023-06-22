import 'package:flutter/material.dart';
import 'package:stalkin/models/post.dart';
import 'package:stalkin/widgets/post_card.dart';
import '../theme.dart';

class TopicPostPage extends StatefulWidget {
  final String name;
  const TopicPostPage({super.key, required this.name});

  @override
  State<TopicPostPage> createState() => _TopicPostPageState();
}

class _TopicPostPageState extends State<TopicPostPage> {
  TextEditingController search = TextEditingController();
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
            PostCard(
              Post(
                  idPost: 1,
                  idTopic: 1,
                  nameUser: 'Anindita',
                  content:
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys',
                  likes: 122,
                  dislike: 3),
            ),
            PostCard(
              Post(
                  idPost: 2,
                  idTopic: 1,
                  nameUser: 'Amelia',
                  content:
                      'standard dummy text ever since the 1500s, when an unknown printer took a galley of Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys',
                  likes: 0,
                  dislike: 8),
            ),
          ],
        ),
      ),
    );
  }
}
