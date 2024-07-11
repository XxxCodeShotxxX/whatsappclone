import 'package:flutter/material.dart';

import 'package:whatsappclone/models/user_model.dart';
import 'package:whatsappclone/screens/contacts_screen.dart';

import '../../widgets/chat_tile.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key, required this.currentUser, required this.users,});
  final User currentUser;
    final List<User> users;

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
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              return ChatTile(
                friend: users[index],
                currentUser: currentUser,
              );
            }));
  }
}
