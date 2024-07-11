import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:whatsappclone/models/user_model.dart';
import 'package:whatsappclone/screens/chat_screen.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.friend, required this.currentUser,
  });
  final User friend;
  final User currentUser;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>  ChatScreen(
              friend: friend,
              currentUser: currentUser,
            )));
      },
      child: Column(
        children: [
          ListTile(
            title: Text(
              friend.userName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: const Row(
              children: [
                Icon(
                  Icons.done_all,
                  size: 13,
                ),
                Flexible(
                    child: Text(
                  "Culpa eiusmod voluptate exercitation eu officia amet nostrud commodo in sunt aute aliquip reprehenderit.",
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
            leading: Stack(
              children: [CircleAvatar(
                radius: 30,
                child: SvgPicture.asset(
                  false
                      ? "assets/icons/groups.svg"
                      : "assets/icons/person.svg",
                  // ignore: deprecated_member_use
                  color: Colors.white,
                  height: 38,
                  width: 38,
                ),
              ), Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(radius: 12, backgroundColor: friend.isOnline? Colors.green : Colors.grey,))]
            ),
            trailing: Text(DateFormat('hh:mm').format(DateTime.now())),
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
