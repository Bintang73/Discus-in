import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stalkin/models/post.dart';

import '../theme.dart';

class PostContent extends StatefulWidget {
  final Post post;
  const PostContent(this.post, {super.key});

  @override
  State<PostContent> createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  bool isUpvoted = false;
  bool isDownvoted = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 23),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/captcha/1.jpg',
                      height: 35,
                      width: 35,
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
                        widget.post.nameUser,
                        style: regularPoppins.copyWith(fontSize: 16),
                      ),
                      Text(
                        DateFormat('d MMM y HH:mm')
                            .format(widget.post.timestamp.toDate()),
                        style: regularPoppins.copyWith(fontSize: 10),
                      )
                    ],
                  ),
                ],
              ),
              const Icon(Icons.bookmark_border_outlined)
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.post.content,
                  style: regularPoppins.copyWith(fontSize: 12),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                                  widget.post.votes++;
                                } else {
                                  widget.post.votes--;
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
                          widget.post.votes.toString(),
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
                                  widget.post.votes--;
                                } else {
                                  widget.post.votes++;
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
        ],
      ),
    );
  }
}
