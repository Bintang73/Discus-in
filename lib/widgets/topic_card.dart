import 'package:flutter/material.dart';
import 'package:stalkin/models/topic.dart';
import 'package:stalkin/pages/topic_post_page.dart';

import '../theme.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  const TopicCard(this.topic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TopicPostPage(
                  name: topic.name,
                );
              }));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    topic.name,
                    style: semiPoppins.copyWith(fontSize: 14),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      shape: BoxShape.circle,
                    ),
                    width: 40,
                    height: double.infinity,
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
