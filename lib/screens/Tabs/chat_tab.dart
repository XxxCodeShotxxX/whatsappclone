import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whatsappclone/controllers/chat_controller.dart';
import 'package:whatsappclone/controllers/user_controller.dart';
import 'package:whatsappclone/models/localdbmodel/db_chat_list_model.dart';

import 'package:whatsappclone/models/servermodel/user/user_model.dart';
import 'package:whatsappclone/screens/contacts_screen.dart';

import '../../widgets/chat_tile.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});
  static ChatController chatController = Get.put(ChatController());
  static UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    userController.getChatList();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.chat),
        ),
        body: Obx(
          () => userController.chatListData.isEmpty
              ? const Center(child: Text('No Chats'))
              : ListView.builder(
                  itemCount: userController.chatListData.length,
                  itemBuilder: (BuildContext context, int index) {

                    DbChatListModel userChat = userController.chatListData[index];
                  userController.updateProfileById(userChat.userId);
List<String> userNameImage =
                      userController.getUserNameImage(userChat.userId);
            
                    return ChatTile(
                      userName: userNameImage[0],
                      userImage: userNameImage[1],
                      lastMessage: userChat.message,
                      tickCount: userChat.tickCount,
                      unreadCount: userChat.unreadCount,
                      createdAt:userChat.createdAt,
                      onTap: (){
                      log("clicked !!!!");
                      chatController.navigateToChatDetailsScreen(userChat.userId, userNameImage);},
                    );
                  }),
        ));
  }
}
