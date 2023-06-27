import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  int idComment;
  int idPost;
  int idUser;
  String content;
  int votes;
  Timestamp timeStamp;

  Comment({
    required this.idComment,
    required this.idPost,
    required this.idUser,
    required this.content,
    required this.votes,
    required this.timeStamp,
  });
}
