import 'package:flutter/material.dart';
import 'package:stalkin/models/notification.dart';
import 'package:stalkin/pages/comment_page.dart';

import '../theme.dart';

class CustomNotification extends StatelessWidget {
  final NotificationModel notification;

  const CustomNotification({
    required this.notification,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: 60,
      width: double.infinity,
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "${notification.idTopic} : ${notification.content}",
                style: regularPoppins.copyWith(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CommentPage(
                    name: notification.nameUser,
                    content: notification.content,
                    votes: notification.votes,
                    idPost: notification.idPost,
                    idTopic: notification.idTopic,
                    profileUser: notification.profileUser,
                    timestamp: notification.timestamp,
                    originalpost: notification.originalpost,
                  );
                }));
              },
              child: Container(
                height: 30,
                width: 62,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: secondaryColor,
                ),
                child: Text(
                  'Lihat',
                  style: semiPoppins.copyWith(fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
