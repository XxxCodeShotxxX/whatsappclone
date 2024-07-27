import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsappclone/screens/camera/camera_screen.dart';
import 'package:whatsappclone/screens/camera/image_view_screen.dart';
import 'package:whatsappclone/widgets/icon_placeholder.dart';

class ShowModalSheet extends StatelessWidget {
  const ShowModalSheet({
    super.key, required this.userId,
  });
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(0, 0, 0, 0),
      height: Get.height / 3,
      width: Get.width,
      // ignore: prefer_const_constructors
      child: SingleChildScrollView(
        child: Card(
          margin: const EdgeInsets.all(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
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
                        title: "Camera",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) => const CameraScreen()));
                        },
                      ),
                      const IconPlaceholder(
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
                        title: "Gallery",
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);

                          if (image != null) {
                            Get.to(() => ImageViewScreen(
                                  image: image,
                                  userId:userId,
                                ));
                          }
                        },
                      ),
                      const IconPlaceholder(
                          color: Colors.blue,
                          icon: Icons.person,
                          title: "Contact"),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
