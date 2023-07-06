import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/comment.dart';
import '../theme.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;
  final String name;
  final String urlProfile;

  const CommentCard(this.comment,
      {super.key, required this.name, required this.urlProfile});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isUpvoted = false;
  bool isDownvoted = false;

  @override
  void initState() {
    super.initState();
    if (currentUser.email != null) {
      setState(() {
        checkStringInArrayField("likedBy", widget.comment.idPost,
            widget.comment.idComment, currentUser.email!);
        checkStringInArrayField("dislikedBy", widget.comment.idPost,
            widget.comment.idComment, currentUser.email!);
      });
    }
  }

  void checkStringInArrayField(String fieldName, String documentId,
      String commentId, String searchString) {
    FirebaseFirestore.instance
        .collection('User Post')
        .doc(documentId)
        .collection('Comments')
        .doc(commentId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        if (data.containsKey(fieldName) && data[fieldName] is List) {
          final arrayField = data[fieldName] as List<dynamic>;
          if (arrayField.contains(searchString)) {
            setState(() {
              if (fieldName == "likedBy") {
                isUpvoted = true;
                isDownvoted = false;
              } else {
                isUpvoted = false;
                isDownvoted = true;
              }
              print('String found in array field!');
            });
          } else {
            setState(() {
              if (fieldName == "likedBy") {
                isUpvoted = false;
              } else {
                isDownvoted = false;
              }
            });
          }
        } else {
          print('Field $fieldName is not an array field in the document.');
        }
      } else {
        print('Document not found.');
      }
    }).catchError((error) {
      print('Failed to search field in array: $error');
    });
  }

  void pushToArrayField(
      String fieldName, String documentId, String commentId, String element) {
    FirebaseFirestore.instance
        .collection('User Post')
        .doc(documentId)
        .collection('Comments')
        .doc(commentId)
        .update({
      fieldName: FieldValue.arrayUnion([element]),
    }).then((value) {
      print('Element pushed successfully to array field!');
    }).catchError((error) {
      print('Failed to push element to array field: $error');
    });
  }

  void removeFromArrayField(
      String fieldName, String documentId, String commentId, String element) {
    FirebaseFirestore.instance
        .collection('User Post')
        .doc(documentId)
        .collection('Comments')
        .doc(commentId)
        .update({
      fieldName: FieldValue.arrayRemove([element]),
    }).then((value) {
      print('Element removed successfully from array field!');
    }).catchError((error) {
      print('Failed to remove element from array field: $error');
    });
  }

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
                child: Image.network(
                  widget.urlProfile,
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
                            removeFromArrayField(
                                "dislikedBy",
                                widget.comment.idPost,
                                widget.comment.idComment,
                                currentUser.email!);
                            if (isUpvoted) {
                              pushToArrayField("likedBy", widget.comment.idPost,
                                  widget.comment.idComment, currentUser.email!);
                              widget.comment.votes = widget.comment.votes == -1
                                  ? widget.comment.votes += 2
                                  : widget.comment.votes += 1;
                              ;
                            } else {
                              removeFromArrayField(
                                  "likedBy",
                                  widget.comment.idPost,
                                  widget.comment.idComment,
                                  currentUser.email!);
                              widget.comment.votes = widget.comment.votes == 1
                                  ? widget.comment.votes -= 1
                                  : widget.comment.votes -= 1;
                              ;
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
                            removeFromArrayField(
                                "likedBy",
                                widget.comment.idPost,
                                widget.comment.idComment,
                                currentUser.email!);
                            if (isDownvoted) {
                              pushToArrayField(
                                  "dislikedBy",
                                  widget.comment.idPost,
                                  widget.comment.idComment,
                                  currentUser.email!);
                              widget.comment.votes = widget.comment.votes == 1
                                  ? widget.comment.votes -= 2
                                  : widget.comment.votes -= 1;
                              ;
                            } else {
                              removeFromArrayField(
                                  "dislikedBy",
                                  widget.comment.idPost,
                                  widget.comment.idComment,
                                  currentUser.email!);
                              widget.comment.votes = widget.comment.votes == -1
                                  ? widget.comment.votes += 1
                                  : widget.comment.votes += 1;
                              ;
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
