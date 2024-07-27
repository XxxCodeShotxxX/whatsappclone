import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/controllers/chat_controller.dart';
import 'package:whatsappclone/controllers/user_controller.dart';

class MediaViewController extends GetxController {
  UserController userController = Get.put(UserController());
  ChatController chatController = Get.put(ChatController());

  TextEditingController captionBoxController = TextEditingController();
  RxString captionBoxValue = "".obs;

  void sendImage(String userId, String filePath) async {
    String messageId =
        "${userController.userId.value}$userId${DateTime.now().microsecondsSinceEpoch}";
    String messageText = captionBoxController.text;
    captionBoxController.text = "";
    captionBoxValue.value = "";
    DateTime currentDate = DateTime.now();

    chatController.addToMessageDb(messageId, messageText, userId, currentDate,
        filePath: filePath);

    chatController.addToPendingDb(messageId);

    chatController.addToChatListDb(messageId, messageText, userId, currentDate,
        filePath: filePath);

    chatController.addToServer(messageId, messageText, userId, currentDate,
        filePath: filePath);

    Get.back();
    Get.back();
  }
}
