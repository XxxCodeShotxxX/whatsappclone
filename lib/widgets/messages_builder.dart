import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:whatsappclone/controllers/chat_controller.dart';
import 'package:whatsappclone/controllers/user_controller.dart';
import 'package:whatsappclone/keys/db_cnames.dart';
import 'package:whatsappclone/models/localdbmodel/db_message_model.dart';
import 'package:whatsappclone/widgets/message_bubble.dart';

class MessagesBuilder extends StatelessWidget {
  const MessagesBuilder(
      {super.key,
      required this.userId,
      required this.userController,
      required this.chatController});
  final String userId;
  final UserController userController;
  final ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            Hive.box<DbMessageModel>(DbCnames.message).listenable(),
        builder:
            (BuildContext context, Box<DbMessageModel> value, Widget? child) {
          List<DbMessageModel> fromCurrentUser = value.values
              .where((c) =>
                  c.receiverId.contains(userId) &&
                  c.senderId.contains(userController.userId))
              .toList();

          List<DbMessageModel> fromThisUser = value.values
              .where((c) =>
                  c.receiverId.contains(userController.userId) &&
                  c.senderId.contains(userId))
              .toList();
          List<DbMessageModel> data = [...fromCurrentUser, ...fromThisUser];
          data.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          return data.isEmpty
              ? const Center(child: Text("No Messages"))
              : Positioned(
                  bottom: Get.height * 0.08,
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ListView.separated(
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        int nIndex = data.length - index - 1;
                        DbMessageModel message = data[nIndex];

                        if (message.senderId == userId &&
                            message.openedAt == null) {
                          chatController.openedMessageUpdate(
                              message.id, message.senderId);
                        }
                        return MessageBubble(
                          messageContent: message.message,
                          isSenderByCurrentUser: message.receiverId == userId,
                          messageDate: message.createdAt,
                          isImage:
                              message.messageType == "image" ? true : false,
                          isOpened: message.openedAt != null,
                          isReceived: message.receivedAt != null,
                          imagePath: message.filePath,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 6.0),
                      itemCount: data.length),
                );
        });
  }
}
