import 'package:flutter/material.dart';
import 'package:whatsappclone/widgets/icon_placeholder.dart';

class ShowModalSheet extends StatelessWidget {
  const ShowModalSheet({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(0, 0, 0, 0),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      child: const Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     IconPlaceholder(
                        color: Colors.indigo,
                        icon: Icons.insert_drive_file,
                        title: "Documents"),
                    IconPlaceholder(
                        color: Colors.amber,
                        icon: Icons.headset,
                        title: "Audio"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconPlaceholder(
                        color: Colors.pink,
                        icon: Icons.camera_alt,
                        title: "Camera"),
                    IconPlaceholder(
                        color: Colors.lime,
                        icon: Icons.location_pin,
                        title: "Location"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconPlaceholder(
                        color: Colors.purple,
                        icon: Icons.insert_photo,
                        title: "Gallery"),
                    IconPlaceholder(
                        color: Colors.blue,
                        icon: Icons.person,
                        title: "Contact"),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
