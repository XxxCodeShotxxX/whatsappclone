import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/data/fake_chats.dart';
import 'package:whatsappclone/screens/login_screen.dart';
import '../widgets/contact_tile.dart';
import '../widgets/new_contact_tile.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

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
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Contact",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "265 Contacts",
              style: TextStyle(color: Colors.white, fontSize: 13),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onSelected: (value) {
                if (kDebugMode) {
                  print(value);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(child: Text("New Group")),
                  const PopupMenuItem(child: Text("New broadcast")),
                  const PopupMenuItem(child: Text("Whatsapp Web")),
                  const PopupMenuItem(child: Text("Starred Messages")),
                  const PopupMenuItem(child: Text("Setting")),
                ];
              })
        ],
      ),
      body: ListView.builder(
          itemCount: chats.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const NewContactTile(
                title: "New Group",
                isGroup: true,
              );
            } else if (index == 1) {
              return const NewContactTile(
                title: "New Contact",
                isGroup: false,
              );
            } else {
              return ContactTile(
                  selectable: false, user: userxs[index - 2]);
            }
          }),
    );
  }
}
