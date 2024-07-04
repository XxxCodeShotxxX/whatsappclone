

class MessageModel {
  
  String messageContent;
  DateTime messageDate;
  bool isSendedByCurrentUser;
  int messageStatus;


  MessageModel(this.messageContent,this.messageDate,this.messageStatus,this.isSendedByCurrentUser);
}