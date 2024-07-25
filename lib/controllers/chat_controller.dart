import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:hive/hive.dart';
import 'package:whatsappclone/controllers/socket_controller.dart';
import 'package:whatsappclone/controllers/user_controller.dart';
import 'package:whatsappclone/keys/db_cnames.dart';
import 'package:whatsappclone/models/localdbmodel/db_chat_list_model.dart';
import 'package:whatsappclone/models/localdbmodel/db_message_model.dart';
import 'package:whatsappclone/models/localdbmodel/db_pending_message_model.dart';
import 'package:whatsappclone/models/servermodel/message_model.dart';
import 'package:whatsappclone/repository/chat_repo.dart';
import 'package:whatsappclone/repository/user_repo.dart';
import 'package:whatsappclone/screens/chat_screen.dart';

class ChatController extends GetxController {
  UserController userController = Get.put(UserController());
 // 

  Box<DbPendingMessageModel> pendingMessageBox =
      Hive.box<DbPendingMessageModel>(DbCnames.pendingMessage);
  Box<DbMessageModel> messageBox = Hive.box<DbMessageModel>(DbCnames.message);
  Box chatListBox = Hive.box<DbChatListModel>(DbCnames.chatList);

  ChatRepo chatRepo = ChatRepo();
 UserRepo userRepo = UserRepo();

  RxBool userStatus = false.obs;
  RxBool mic = true.obs;
  TextEditingController messageTextField = TextEditingController();
RxString textControllerValue = "".obs;
  Future<void> pendingMessageCheck() async {
     List<DbPendingMessageModel> pendingData = pendingMessageBox.values.toList();
     log("${pendingData.length}");
     for(var message in pendingData){
        DbMessageModel? messageData = messageBox.get(message.messageId);

         MessageModel body = MessageModel(
        id: messageData!.id,
        message: messageData.message.isEmpty ? " " : messageData.message,
        senderId: messageData.senderId,
        receiverId: messageData.receiverId,
        createdAt: messageData.createdAt,
        messageType: "text",
      );

      var response = await chatRepo.sendMessage(body.toMap());

      if (response.runtimeType.toString() == "Response")
        pendingMessageBox.delete(messageData.id);
        log(messageData.id + " deleted from pendingMessageBox");
    }
  }

  void navigateToChatDetailsScreen(String id, List<String> userImageName) {
      setUnreadMessageToZero(id);
      checkUserStatus(id);

      messageTextField.text = "";
      messageTextField.clear();

      Get.to(() => ChatScreen(userId: id, userName: userImageName[0],image: userImageName[1]));
  }

  void setUnreadMessageToZero(String userId) {
    DbChatListModel? chatData = chatListBox.get(userId);

    if (chatData != null) {
      chatData.unreadCount = 0;
      chatListBox.put(userId, chatData);
    }

    userController.getChatList();
  }

  Future<void> checkUserStatus(String id) async { 

    SocketController socketController = Get.put(SocketController());
      
      var result = await userRepo.getUserStatus(id);

      try {
        if (result.runtimeType.toString() == 'Response') {
          var data = jsonDecode(result.body);
          userStatus.value = data["status"] ?? false;
        } else
          log(result.runtimeType.toString());
      } catch (e) {
        log("error usersList $e");
      }
      try {
        String eventString = '/user_status$id';

        socketController.socket
            .on(eventString, (data) => userStatus.value = data ?? false);
      } catch (e) {
        log("status socket error $e");
      }
  }

  void openedMessageUpdate(String id, from) {}





  Future<void> sendMessage(String userId) async {
    if (messageTextField.text.isEmpty)
      sendVoice();
    else
      sendTextMessage(userId);
  }
  
  void sendVoice() {}
  
  
  


  Future<void>  sendTextMessage(String userId)async{
      String messageId =
        "${userController.userId.value}$userId${DateTime.now().microsecondsSinceEpoch}";

    String messageText = messageTextField.text;
    messageTextField.text = "";
    textControllerValue.value = "";

    DateTime currentDate = DateTime.now();
      addToMessageDb(messageId, messageText, userId, currentDate);

    addToPendingDb(messageId);

    addToChatListDb(messageId, messageText, userId, currentDate);

    addToServer(messageId, messageText, userId, currentDate);
  }

   void addToMessageDb(
    String messageId,
    String messageText,
    String userId,
    DateTime currentDate,
  ) {
    DbMessageModel data = DbMessageModel(
      id: messageId,
      message: messageText,
      senderId: userController.userId.value,
      receiverId: userId,
      createdAt: currentDate,
      receivedAt: null,
      openedAt: null,
      messageType: "text",
      filePath: "",
    );
    messageBox.put(messageId, data);
  }
  void addToPendingDb(String messageId) {
    DbPendingMessageModel pendingMessageModel =
        DbPendingMessageModel(messageId);

    pendingMessageBox.put(messageId, pendingMessageModel);
  }

   void addToChatListDb(
    String messageId,
    String messageText,
    String userId,
    DateTime currentDate,
  ) {
    DbChatListModel dbChatListModel = DbChatListModel(
        message: messageText,
        createdAt: currentDate,
        messageId: messageId,
        userId: userId,
        unreadCount: 0,
        messageType: "text",
        filePath: "",
        tickCount: 1);

    chatListBox.put(userId, dbChatListModel);
  }


Future<void> addToServer(
    String messageId,
    String messageText,
    String userId,
    DateTime currentDate,
  ) async {
    MessageModel body = MessageModel(
      id: messageId,
      message: messageText,
      senderId: userController.userId.value,
      receiverId: userId,
      createdAt: currentDate,
      messageType: "text",
    );

    var response = await chatRepo.sendMessage(body.toMap());

    if (response.runtimeType.toString() == "Response")
      pendingMessageBox.delete(messageId);
  }


























    @override
  void onInit() {
 messageTextField.addListener(() {
      textControllerValue.value = messageTextField.text;
    });
    super.onInit();
  }

  @override
  void dispose() {
    messageTextField.dispose();
    super.dispose();
  }
}
