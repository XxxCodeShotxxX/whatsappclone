import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsappclone/handlers/sharedpref_handler.dart';

import 'package:whatsappclone/repository/user_repo.dart';
import 'package:whatsappclone/routes/routes_names.dart';
import 'package:whatsappclone/widgets/dialog_ok_box.dart';

class ProfileController extends GetxController {
  UserRepo userRepo = UserRepo();
  TextEditingController username = TextEditingController();
  RxString imageUrl =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png"
          .obs;

  Future<void> uploadProfileImage() async {
    SharedprefHandler().writeString("authToken",
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Njk2YzFhMWNiNTMxOWQzOTk1NjcxNjciLCJpYXQiOjE3MjExNTYwMDF9.agmid6rRHalCuVsED4nhKzr-7f_mtKQmFrY6-fqMbaM");
    XFile? imagePicker = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 30);

    if (imagePicker != null) {
      dynamic response = await userRepo.profileImageUpload(imagePicker.path);

      if (response.runtimeType.toString() == "Response") {
        try {
          Map<String, dynamic> responseBody = jsonDecode(response.body);
          if (responseBody.containsKey("ImageUrl")) {
            imageUrl.value = responseBody["ImageUrl"].toString();
            log(responseBody.toString());
          } else {
            log("Key 'ImageUrl' not found in response body");
          }
        } catch (e) {
          log("Error: $e");
        }
      }
    }
  }


 Future<void> navTOHomeScreen() async {
    if (username.text.isEmpty) {
      dialogOkBox("Enter Username", true);
    } else {
      dynamic result = await userRepo.userNameUpdate(username.text);
      if (result == null) {
        dialogOkBox("Update failed. Please try again.", true);
      } else if (result.runtimeType.toString() == "Response") {
        if (result.body != null && jsonDecode(result.body)["error"] == null) {
          Get.offAllNamed(RoutesNames.indexPage);
        } else {
          dialogOkBox(jsonDecode(result.body)["error"] ?? "Unknown error", true);
        }
      } else {
        dialogOkBox("Unexpected error. Please try again.", true);
      }
    }
  }
}
