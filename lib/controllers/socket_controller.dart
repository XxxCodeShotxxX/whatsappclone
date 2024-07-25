import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:whatsappclone/controllers/chat_controller.dart';
import 'package:whatsappclone/controllers/user_controller.dart';
import 'package:whatsappclone/handlers/sharedpref_handler.dart';
import 'package:whatsappclone/keys/api_routes.dart';
import 'package:whatsappclone/keys/db_cnames.dart';
import 'package:whatsappclone/keys/sharedpref_keys.dart';
import 'package:whatsappclone/models/localdbmodel/db_chat_list_model.dart';
import 'package:whatsappclone/models/localdbmodel/db_message_model.dart';
import 'package:whatsappclone/models/servermodel/message_model.dart';
import 'package:whatsappclone/repository/chat_repo.dart';

class SocketController extends GetxController {
  late Socket socket;
  UserController userController = Get.put(UserController());
  ChatController chatController = Get.put(ChatController());

  Box messageBox = Hive.box<DbMessageModel>(DbCnames.message);
  Box chatListBox = Hive.box<DbChatListModel>(DbCnames.chatList);
  ChatRepo chatRepo= ChatRepo();

  String token = "";

  Future<void> connect() async {
    token = await SharedprefHandler().readString(SharedPrefKeys.authToken);
    socket = io(
        Api.baseUrl,
        OptionBuilder()
            .setTransports(["websocket"])
            .setExtraHeaders({'token': "Bearer $token"})
            .disableAutoConnect()
            .build());

    socket.connect();

    socket.onConnecting((data) => log("Connecting to socket $data"));

    socket.onConnect((data) {
      log("Connected to socket $data");
      userController.getMyDetails();
      chatController.pendingMessageCheck();
      log(SharedprefHandler()
          .readString(SharedPrefKeys.userDetails)
          .toString());
    });

    socket.onConnectError(_connectionError);

    socket.onError(_connectionError);

    socket.on("message", message);
  }

  void _connectionError(dynamic data) {
    log("socket connection error $data");
  }

  Future<void> message(dynamic data) async {
    log("message $data", name: "socket_controller");
    MessageModel messageModel = MessageModel.fromMap(data);
    DateTime currentDateTime = DateTime.now();
    addToMessageDb(messageModel, currentDateTime);
    addToChatList(messageModel, currentDateTime);


    chatRepo.receivedMessageUpdate({
      "id": messageModel.id,
      "receivedAt": currentDateTime.toIso8601String(),
      "fromId": messageModel.senderId
    });
    userController.getChatList();
  }

  void addToMessageDb(MessageModel messageModel, DateTime currentDateTime) {
    DbMessageModel dbMessageModel = DbMessageModel(
      id: messageModel.id!,
      message: messageModel.message!,
      senderId: messageModel.senderId!,
      receiverId: messageModel.receiverId!,
      createdAt: messageModel.createdAt!,
      receivedAt: currentDateTime,
      openedAt: messageModel.openedAt,
      messageType: messageModel.messageType,
      filePath: messageModel.filePath,
    );

    messageBox.put(messageModel.id, dbMessageModel);
  }

  void addToChatList(MessageModel messageModel, DateTime currentDateTime) {
    int messageCount = 1;

    DbChatListModel? chatData = chatListBox.get(messageModel.senderId);

    if (chatData != null) messageCount = chatData.unreadCount + 1;

    DbChatListModel dbChatListModel = DbChatListModel(
        message: messageModel.message!,
        createdAt: currentDateTime,
        messageId: messageModel.id!,
        userId: messageModel.senderId!,
        unreadCount: messageCount,
        messageType: "text",
        filePath: "",
        tickCount: 0);

    chatListBox.put(messageModel.senderId, dbChatListModel);
  }
}
