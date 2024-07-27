import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/controllers/chat_controller.dart';

class ChatUserHeader extends StatelessWidget {
  const ChatUserHeader({
    super.key,
    required this.userName,
    required this.chatController,
  });

  final String userName;

  final ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userName, style: const TextStyle(fontSize: 16,color: Colors.white)),
        Obx(() => chatController.userStatus.value
            ? const Text("Online",
                style: TextStyle(fontSize: 12.0, color: Colors.white))
            : 
             Text(chatController.lastSeenTime.value,
                style: const TextStyle(fontSize: 12.0, color: Colors.white))),
      ],
    );
  }
}
