class Comment {
  int idComment;
  int idPost;
  int idUser;
  String content;
  int votes;
  int timeStamp;

  Comment({
    required this.idComment,
    required this.idPost,
    required this.idUser,
    required this.content,
    required this.votes,
    required this.timeStamp,
  });
}
