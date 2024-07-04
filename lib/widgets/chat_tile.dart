import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:whatsappclone/models/chat_model.dart';
import 'package:whatsappclone/screens/chat_screen.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.chatModel,
  });
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  ChatScreen(
              targetId: chatModel.id,
            )));
      },
      child: Column(
        children: [
          ListTile(
            title: Text(
              chatModel.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Icons.done_all,
                  size: 13,
                ),
                Flexible(
                    child: Text(
                  chatModel.lastMessage,
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                chatModel.isGroup
                    ? "assets/icons/groups.svg"
                    : "assets/icons/person.svg",
                // ignore: deprecated_member_use
                color: Colors.white,
                height: 38,
                width: 38,
              ),
            ),
            trailing: Text(DateFormat('hh:mm').format(chatModel.time)),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              color: Color.fromARGB(199, 158, 158, 158),
              thickness: 1,
            ),
          )
        ],
      ),
    );
  }
}
