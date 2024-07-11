import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsappclone/handlers/network_handler.dart';
import 'package:whatsappclone/widgets/icon_placeholder.dart';

class PatchTester extends StatefulWidget {
  const PatchTester({super.key});

  @override
  _PatchTesterState createState() => _PatchTesterState();
}

class _PatchTesterState extends State<PatchTester> {
  XFile? file;
  String status = "nothing";
  final NetworkHandler networkHandler = NetworkHandler();
  final TextEditingController controller = TextEditingController();
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    file = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      status = file != null ? "Image selected" : "No image selected";
    });
  }

  Future<void> uploadImage() async {
    if (file == null) {
      setState(() {
        status = "Please select an image first";
      });
      return;
    }

    try {
      var response = await networkHandler.postImage("routes/addImage", file!.path, file!.name);
      if (response.statusCode == 200) {
        setState(() {
          status = "Image uploaded successfully";
        });
      } else {
        setState(() {
          status = "Failed to upload image: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        status = "Error: $e ";
        controller.text = e.toString();
      });
    }
  }


  Future<void> online(String uid) async {


    networkHandler.setOnline(uid);
  }
  Future<void> offline(String uid) async {


    networkHandler.setOffline(uid);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Patch Tester'),
            IconPlaceholder(
              color: Colors.purple,
              icon: Icons.insert_photo,
              title: "Gallery",
              onTap: pickImage,
            ),
            TextButton(
              onPressed: uploadImage,
              child: const Text("Upload!"),
            ),
            Text(
              status,
            ),
            TextField(controller: controller),
            TextButton(
              onPressed: (){
               if (controller.text.isNotEmpty) online(controller.text);
              },
              child: const Text("setOnline"),
            ),
            TextButton(
              onPressed: (){
               if (controller.text.isNotEmpty) offline(controller.text);
              },
              child: const Text("setOffline"),
            ),
          ],
        ),
      ),
    );
  }
}
