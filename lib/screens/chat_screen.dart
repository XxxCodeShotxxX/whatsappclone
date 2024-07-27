import 'dart:developer';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
// ignore: library_prefixes
import 'package:whatsappclone/controllers/chat_controller.dart';
import 'package:whatsappclone/controllers/user_controller.dart';
import 'package:whatsappclone/keys/db_cnames.dart';
import 'package:whatsappclone/models/localdbmodel/db_message_model.dart';
import 'package:whatsappclone/widgets/chat_user_header.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_list.dart';
import '../widgets/message_send_t_ile.dart';
import '../widgets/messages_builder.dart';
import '../widgets/show_modal_sheet.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen(
      {super.key,
      required this.userId,
      required this.userName,
      required this.image});

  static ChatController chatController = Get.put(ChatController());
  static UserController userController = Get.put(UserController());

  final String userId, userName, image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Row(
            children: [
              IconButton(
                padding: const EdgeInsets.only(right: 0),
                onPressed: () {
                  Get.back();
                },
                icon: 
                
                  const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
         
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: CircleAvatar(
                  maxRadius: 20,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  backgroundImage: NetworkImage(image),
                ),
              ),
              ChatUserHeader(
                  userName: userName, chatController: chatController),
            ],
          ),
        ),
        actions: [
          GestureDetector(
          onTap: () {
                  chatController.checkUserStatus(userId);
                },
            child: const Icon(
              Icons.camera,
              color: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: const Icon(
              Icons.call,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: GestureDetector(
              onTap: () {
                Box<DbMessageModel> messages =
                    Hive.box<DbMessageModel>(DbCnames.message);

                messages.add(DbMessageModel(
                    id: "aa",
                    message: "test",
                    senderId: "66a013ef67325a56b1d2ef34",
                    receiverId:userId,
                    createdAt: DateTime.now()));
              },
              child: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Image.asset(
              "assets/images/chat_background.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            MessagesBuilder(
                userId: userId,
                userController: userController,
                chatController: chatController),
            MessageSendTile(
              chatController: chatController,
              userId: userId,
            ),
          ],
        ),
      ),
    );
  }
}
