import 'package:flutter/material.dart';
import 'package:whatsappclone/data/fake_chats.dart';
import 'package:whatsappclone/screens/contacts_screen.dart';

import '../../widgets/chat_tile.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => const ContactsScreen()));
          },
          child: const Icon(Icons.chat),
        ),
        body: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              return ChatTile(
                chatModel: chats[index],
              );
            }));
  }
}
