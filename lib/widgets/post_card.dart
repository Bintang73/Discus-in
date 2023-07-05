import 'package:flutter/material.dart';
import 'package:stalkin/pages/comment_page.dart';
import '../models/post.dart';
import '../theme.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard(this.post, {super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isUpvoted = false;
  bool isDownvoted = false;

  // ignore: no_leading_underscores_for_local_identifiers
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
    final int timestampInSeconds = widget.post.timestamp;
    final DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);
    final String formattedDate =
        '${dateTime.day} ${_getMonth(dateTime.month)} ${dateTime.year} - ${dateTime.hour}:${dateTime.minute}';

    return Container(
      margin: const EdgeInsets.only(left: 32, right: 32, bottom: 26),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      widget.post.profileUser,
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
                        widget.post.nameUser,
                        style: regularPoppins.copyWith(fontSize: 16),
                      ),
                      Text(
                        formattedDate,
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
            child: Row(
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.post.content,
                      style: regularPoppins.copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CommentPage(
                      name: widget.post.nameUser,
                      content: widget.post.content,
                      votes: widget.post.votes,
                      idPost: widget.post.idPost,
                      idTopic: widget.post.idTopic,
                      profileUser: widget.post.profileUser,
                      timestamp: 1688127705,
                    );
                  }));
                },
                child: Row(
                  children: [
                    const Icon(Icons.chat_bubble_outline_rounded),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Lihat',
                      style: boldPoppins.copyWith(fontSize: 14),
                    )
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
