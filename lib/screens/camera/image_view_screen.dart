import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsappclone/controllers/chat_controller.dart';
import 'package:whatsappclone/controllers/media_view_controller.dart';
import 'package:whatsappclone/controllers/user_controller.dart';
import 'dart:developer';

import '../../widgets/caption_box.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({super.key, required this.image, required this.userId});
  final XFile image;
  final String userId;
  static final MediaViewController controller = Get.put(MediaViewController());
  static final ChatController chatController = Get.put(ChatController());
  static final UserController userController = Get.put( UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.crop_rotate,
                size: 27,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.emoji_emotions_outlined,
                size: 27,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.title,
                size: 27,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: const Icon(
                Icons.edit,
                size: 27,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
      body: Stack(children: [
        Container(
          color: Colors.black,
          width: Get.width,
          height: Get.height,
          child: Image.file(
            File(image.path),
            fit: BoxFit.contain,
          ),
        ),
        CaptionBox(
          controller: controller.captionBoxController,
          onTap: () {
            try {
              log(controller.captionBoxController.text);
              controller.sendImage(userId, image.path);
              
            } catch (e) {
              log(e.toString());
            }
          },
        )
      ]),
    );
  }
}
