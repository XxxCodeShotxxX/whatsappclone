import 'package:flutter/material.dart';
import 'package:whatsappclone/data/fake_chats.dart';
import 'package:whatsappclone/screens/login_screen.dart';
import 'package:whatsappclone/widgets/contact_tile.dart';

class NewGroupScreen extends StatelessWidget {
  const NewGroupScreen({super.key});

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
              "New Group",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Add members",
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
        ],
      ),
      body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (BuildContext context, int index) {
            return ContactTile(
              user: userxs[index],
              selectable: true,
            );
          }),
    );
  }
}
