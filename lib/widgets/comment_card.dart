import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/comment.dart';
import '../theme.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  final String name;
  const CommentCard(this.comment, {super.key, required this.name});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  bool isUpvoted = false;
  bool isDownvoted = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/captcha/1.jpg',
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: regularPoppins.copyWith(fontSize: 14),
                  ),
                  Text(
                    DateFormat('d MMM y HH:mm')
                        .format(widget.comment.timeStamp.toDate()),
                    style: regularPoppins.copyWith(fontSize: 10),
                  )
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.comment.content,
                  style: regularPoppins.copyWith(fontSize: 12),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isUpvoted = !isUpvoted;
                            isDownvoted = false; // Reset the downvote state
                            if (isUpvoted) {
                              widget.comment.votes++;
                            } else {
                              widget.comment.votes--;
                            }
                          });
                        },
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          color: isUpvoted ? Colors.blue[800] : blackColor,
                        ),
                      ),
                    ),
                    Text(
                      widget.comment.votes.toString(),
                      style: boldPoppins.copyWith(fontSize: 14),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isDownvoted = !isDownvoted;
                            isUpvoted = false; // Reset the upvote state
                            if (isDownvoted) {
                              widget.comment.votes--;
                            } else {
                              widget.comment.votes++;
                            }
                          });
                        },
                        child: Icon(
                          Icons.arrow_downward_rounded,
                          color: isDownvoted ? Colors.red[800] : blackColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
