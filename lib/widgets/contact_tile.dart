import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsappclone/models/servermodel/user/user_model.dart';

class ContactTile extends StatefulWidget {
  const ContactTile({
    super.key,

    this.onTap,
    required this.selectable,
  });


  final bool selectable;
  final Function()? onTap;

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  late bool selected;

  @override
  void initState() {
    super.initState();
    selected = false;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {


        if (widget.selectable) {
          setState(() {
            selected = !selected;
          });
        } else {
          widget.onTap!();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: ListTile(
          leading: FittedBox(
            child: Stack(children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.grey,
                child: SvgPicture.asset(
                  "assets/icons/person.svg",
                  // ignore: deprecated_member_use
                  color: Colors.white,
                  height: 30,
                  width: 30,
                ),
              ),
              selected
                  ? const Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(radius: 12, child: Icon(Icons.check)))
                  : Container(),
            ]),
          ),
          title: Text(
            'widget.user.userName',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text("Labore consequat magna irure excepteur ullamco."),
        ),
      ),
    );
  }
}
