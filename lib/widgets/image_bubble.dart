import 'package:flutter/material.dart';

class ImageBubble extends StatelessWidget {
  const ImageBubble({
    super.key,
    required this.isSenderByCurrentUser, required this.imagePath, required this.messageStatus, required this.messageDate,
  });

  final bool isSenderByCurrentUser;
  final String imagePath;
  final int messageStatus;
  final DateTime messageDate;
  @override
  Widget build(BuildContext context) {
    return Align(
          alignment:          isSenderByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,

          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
                maxHeight: 200,
            ),
            child: Card(
        
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                )),
          ),
        );
  }
}
