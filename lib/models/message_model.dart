class MessageModel {
  String messageContent;
  String senderId;
  String receiverId;
  bool isImage;
  String? imagePath;
  String? imageName;
  MessageModel(this.messageContent, this.senderId, this.receiverId,
      this.isImage, this.imagePath, this.imageName);

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        json["message"] as String,
        json["senderId"]as String,
        json["receiverId"]as String,
        json["isImage"] as bool,
        json["imagePath"] as String?,
        json["imageName"] as String?);
  }
}
