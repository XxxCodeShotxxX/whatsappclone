import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsappclone/screens/new_group_screen.dart';

class NewContactTile extends StatelessWidget {
  const NewContactTile({super.key, required this.title, required this.isGroup});

  final String title;
  final bool isGroup;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isGroup) {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => const NewGroupScreen()));
        }
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: Colors.blue,
          child: SvgPicture.asset(
            !isGroup ? "assets/icons/person.svg" : "assets/icons/groups.svg",
            // ignore: deprecated_member_use
            color: Colors.white,
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
