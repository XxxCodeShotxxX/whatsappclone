import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/controllers/profile_controller.dart';

class InitialProfileScreen extends StatelessWidget {
  const InitialProfileScreen({super.key});
  static ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Add Profile Information",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              "Please provide your profile information",
              style: TextStyle(color: Colors.grey),
            ),
            GestureDetector(
                onTap: () => profileController.uploadProfileImage(),
                child: Obx(
                  () => 
                  
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey,
                    backgroundImage:profileController.imageUrl.value.isNotEmpty ?  NetworkImage(profileController.imageUrl.value) : null,
                    child:  profileController.imageUrl.value.isNotEmpty
                      ? null
                      : const Icon(Icons.add_a_photo),
                  )
                  
                  
                  
                  
                  
                 
                )),
            SizedBox(
              width: Get.width * 0.75,
              child: TextField(
                controller: profileController.username,
                textAlignVertical: TextAlignVertical.bottom,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  hintText: "Enter your Name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 1.5),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SizedBox(
                width: Get.width / 1.75,
                child: ElevatedButton(
                  onPressed: () => profileController.navTOHomeScreen(),
                  style: ButtonStyle(
                    shape: WidgetStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.resolveWith(
                      (states) => Theme.of(context).colorScheme.secondary,
                    ),
                    padding: WidgetStateProperty.resolveWith((states) =>
                        const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 52.0)),
                  ),
                  child: const Text(
                    "NEXT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
