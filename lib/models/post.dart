class Post {
  String idPost;
  String idTopic;
  String profileUser;
  String nameUser;
  String content;
  int votes;
  int timestamp;

  Post({
    required this.idPost,
    required this.idTopic,
    required this.profileUser,
    required this.nameUser,
    required this.content,
    required this.votes,
    required this.timestamp,
  });
}
