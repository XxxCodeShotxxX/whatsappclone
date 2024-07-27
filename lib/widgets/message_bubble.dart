import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.isSenderByCurrentUser,
    required this.messageContent,
    required this.messageDate,
    required this.isImage,
    this.imagePath,
    this.imageName,
    this.isOpened = false,
    this.isReceived = false,
  }) : super(key: key);

  final bool isSenderByCurrentUser;
  final bool isImage;
  final String? imagePath;
  final String? imageName;
  final String messageContent;
  final bool isOpened;
  final bool isReceived;
  final DateTime messageDate;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          isSenderByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSenderByCurrentUser
                ? const Color.fromARGB(255, 225, 252, 196)
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (isImage)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.5,
                      ),
                      child: isSenderByCurrentUser
                          ? Image.file(
                              File(imagePath!),
                              fit: BoxFit.contain,
                            )
                          : Image.network(
                              imagePath!,
                              fit: BoxFit.contain,
                            ),
                    ),
                    const SizedBox(height: 5),
                    if (messageContent.isNotEmpty)
                      Text(
                        messageContent, // Caption for the image
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black87),
                      ),
                  ],
                )
              else
                Text(
                  messageContent,
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat("hh:mm a").format(messageDate),
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 5),
                  if (isSenderByCurrentUser)
                    if (isOpened)
                      const Icon(Icons.done_all, size: 14.0, color: Colors.blue)
                    else if (isReceived)
                      const Icon(Icons.done_all, size: 14.0)
                    else
                      const Icon(Icons.check, size: 14.0)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
