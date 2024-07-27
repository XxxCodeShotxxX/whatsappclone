import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/controllers/chat_controller.dart';
import 'package:whatsappclone/widgets/show_modal_sheet.dart';

class MessageSendTile extends StatelessWidget {
  const MessageSendTile({
    super.key,
    required this.chatController,
    required this.userId,
  });
  
  final ChatController chatController;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 55,
              child: Card(
                margin: const EdgeInsets.only(right: 2, left: 2, bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextFormField(
                onChanged:(value){
                  if(value.isNotEmpty){
                    chatController.mic.value = false;
                  } else {
                    chatController.mic.value = true ;
                  }
                },
                  controller: chatController.messageTextField,
                  textAlignVertical: TextAlignVertical.center,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    prefixIcon: const IconButton(
                      onPressed: null,
                      icon: Icon(Icons.emoji_emotions),
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (builder) =>  ShowModalSheet(
                            userId: userId,
                           
                              ),
                            );
                          },
                          icon: const Icon(Icons.attach_file),
                        ),
                        const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.camera_alt),
                        ),
                      ],
                    ),
                    border: InputBorder.none,
                    hintText: "Write a message ...",
                    contentPadding: const EdgeInsets.all(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 2),
              child: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                radius: 25,
                child: IconButton(
                  onPressed: () {
                    if (chatController.textControllerValue.isEmpty) {
                      // Handle mic action
                      log("MICE ACTION");
                    } else {
                      chatController.sendMessage(userId);

                    }
                  },
                  icon: Obx(()=>Icon(
                      chatController.mic.value
                          ? Icons.mic
                          : Icons.send,
                      color: Colors.white,
                   
                  ),)
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
