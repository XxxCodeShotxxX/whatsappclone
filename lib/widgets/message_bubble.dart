import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.isSenderByCurrentUser,
    required this.messageContent,
    required this.messageStatus,
    required this.messageDate,
    required this.isImage,
    this.imagePath,
    this.imageName,
  });
  final bool isSenderByCurrentUser;
  final bool isImage;
  final String? imagePath;
  final String? imageName;
  final String messageContent;
  final int messageStatus;
  final DateTime messageDate;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isSenderByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        child: Stack(children: [
          Card(
            elevation: 1,
            color: isSenderByCurrentUser
                ? const Color.fromARGB(255, 225, 252, 196)
                : Colors.white,
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 40, top: 5, bottom: 20),
                // ignore: prefer_const_constructors
                child: isSenderByCurrentUser
                    ? !isImage
                        ? Text(messageContent,
                            style: const TextStyle(fontSize: 16))
                        : Image.file(
                            File(imagePath!),
                            fit: BoxFit.contain,
                          )
                    : !isImage
                        ? Text(messageContent,
                            style: const TextStyle(fontSize: 16))
                        : Image.network(
                            "http://192.168.1.69:5000/images/$imageName",
                            fit: BoxFit.contain,
                          )),
          ),
          Positioned(
            bottom: 4,
            right: 10,
            child: Row(
              children: [
                Text(DateFormat("hh:ss").format(messageDate),
                    style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                const SizedBox(
                  width: 2,
                ),
                isSenderByCurrentUser
                    ? messageStatus == 0
                        ? const Icon(
                            Icons.error_outline,
                            size: 20,
                          )
                        : messageStatus == 1
                            ? const Icon(
                                Icons.done,
                                size: 20,
                              )
                            : const Icon(
                                Icons.done_all,
                                size: 20,
                              )
                    : Container(),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
