class NotificationModel {
  String idPost;
  String idTopic;
  String profileUser;
  String nameUser;
  String content;
  int votes;
  int timestamp;
  String originalpost;

  NotificationModel({
    required this.idPost,
    required this.idTopic,
    required this.profileUser,
    required this.nameUser,
    required this.content,
    required this.votes,
    required this.timestamp,
    required this.originalpost,
  });
}
