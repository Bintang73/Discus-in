class Comment {
  int idComment;
  int idPost;
  int idUser;
  String content;
  int likes;
  int dislike;

  Comment({
    required this.idComment,
    required this.idPost,
    required this.idUser,
    required this.content,
    required this.likes,
    required this.dislike,
  });
}
