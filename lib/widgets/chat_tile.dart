import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whatsappclone/models/servermodel/user/user_model.dart';
import 'package:whatsappclone/screens/chat_screen.dart';
import 'package:whatsappclone/widgets/no_user_image.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    this.lastMessage,
    required this.userName,
    required this.userImage,
    required this.tickCount,
    required this.unreadCount,
    required this.createdAt, this.onTap,
  });

  final String? lastMessage;
  final String userName;
  final String userImage;
  final int tickCount;
  final int unreadCount;
  final DateTime createdAt;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){onTap!();},
      child: Column(
        children: [
          ListTile(
            minLeadingWidth: 0.0,
            minVerticalPadding: 0.0,
            // contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
            title: Text(
              userName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                if (tickCount != 0)
                  if (tickCount == 3)
                    const Icon(Icons.done_all, size: 14.0, color: Colors.blue)
                  else if (tickCount == 2)
                    const Icon(Icons.done_all, size: 14.0)
                  else
                    const Icon(Icons.check, size: 14.0),
                Expanded(
                    child: Text(
                  lastMessage ?? "",
                  overflow: TextOverflow.ellipsis,
                )),
              ],
            ),
            leading: userImage.isEmpty
                ? const NoUserImage()
                : CircleAvatar(
                    radius: 36,
                    backgroundImage: NetworkImage(
                      userImage,
                    ),
                  ),
            trailing: FittedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "${createdAt.hour}:${createdAt.minute}",
                    style: const TextStyle(fontSize: 12),
                  ),
                  if (unreadCount != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0))),
                      alignment: Alignment.center,
                      child: Text(
                        unreadCount.toString(),
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
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
