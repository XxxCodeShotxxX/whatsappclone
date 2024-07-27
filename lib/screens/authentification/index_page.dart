import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/handlers/sharedpref_handler.dart';
import 'package:whatsappclone/keys/sharedpref_keys.dart';
import 'package:whatsappclone/screens/home.dart'; // Import the controller

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController tokenController = TextEditingController();

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: TextField(
            controller: tokenController,
          ),
        ),
        TextButton(
            onPressed: () async {
              await SharedprefHandler()
                  .writeString(SharedPrefKeys.authToken, tokenController.text);
              Get.to(() => const HomeScreen());
            },
            child: const Text("Login")),
      ],
    ));
  }
}
