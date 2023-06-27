import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String idPost;
  String idTopic;
  String nameUser;
  String content;
  int votes;
  Timestamp timestamp;

  Post({
    required this.idPost,
    required this.idTopic,
    required this.nameUser,
    required this.content,
    required this.votes,
    required this.timestamp,
  });
}
