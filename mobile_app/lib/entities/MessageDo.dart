class MessageDo {
  String? roomId;
  String? createdAt;
  int? fromUser;
  String? message;
  String? status;

  MessageDo(
      {required this.roomId,
      required this.createdAt,
      required this.fromUser,
      required this.message,
      required this.status});

  MessageDo.fromJson(Map<String, dynamic> json) {
    roomId = json["id"];
    createdAt = json["created_at"].toString();
    fromUser = json["from_user"];
    message = json["message"];
    status = json["status"];
  }
}
