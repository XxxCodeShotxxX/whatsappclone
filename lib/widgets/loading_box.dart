import 'package:flutter/material.dart';
import 'package:get/get.dart';

void loadingBox() {
  Get.dialog(const AlertDialog(
    title: Row(
      children: [
        CircularProgressIndicator(),
        SizedBox(
          width: 10,
        ),
        Text("Please wait...")
      ],
    ),
  ));
}
