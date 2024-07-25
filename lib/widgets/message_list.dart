import 'package:flutter/material.dart';
import 'package:whatsappclone/widgets/message_bubble.dart';

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      bottom: MediaQuery.of(context).size.height * 0.08,
      child: ListView.builder(
        reverse: true,
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return MessageBubble(
            isSenderByCurrentUser: index % 2 == 0,
            messageContent: 'message',
            messageDate: DateTime.now(),
            messageStatus: 2,
            isImage: false,
            imagePath: "p",
            imageName: "v",
          );
        },
      ),
    );
  }
}
