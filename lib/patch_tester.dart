import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsappclone/controllers/register_controller.dart';
import 'package:whatsappclone/handlers/http_handler.dart';


class PatchTester extends StatelessWidget {
   PatchTester({super.key});

  XFile? file;

  String status = "nothing";

  final HttpHandler httpHandler = HttpHandler();

  final TextEditingController pcontroller = TextEditingController();

  final TextEditingController dcontroller = TextEditingController();
  static RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.grey[300],
              child: TextField(
                controller: dcontroller,
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: TextField(
                controller: pcontroller,
              ),
            ),
            ElevatedButton(onPressed: 
              (){
              
              }
            , child: const Text("ADD"))
          ],
        ),
      ),
    );
  }
}
