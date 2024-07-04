import 'package:flutter/material.dart';
import 'package:whatsappclone/data/fake_chats.dart';
import 'package:whatsappclone/models/chat_model.dart';
import 'package:whatsappclone/screens/home.dart';
import 'package:whatsappclone/widgets/contact_tile.dart';

  late  ChatModel sourceChat;
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (BuildContext context, int index) {
            return ContactTile(
              chatModel: chats[index],
              selectable: false,
              onTap: () {
                sourceChat = chats.removeAt(index);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>HomeScreen()));
              },
            );
          }),
    );
  }
}
