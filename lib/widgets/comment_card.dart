import 'package:flutter/material.dart';
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

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final int timestampInSeconds = widget.comment.timeStamp;
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);
    final String formattedDate =
        '${dateTime.day} ${_getMonth(dateTime.month)} ${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
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
                    formattedDate,
                    style: regularPoppins.copyWith(fontSize: 10),
                  )
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.comment.content,
                      style: regularPoppins.copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ],
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
