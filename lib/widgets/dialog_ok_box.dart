import 'package:flutter/material.dart';
import 'package:get/get.dart';

void dialogOkBox(String title, bool getBack) {
  Get.dialog(AlertDialog(
    title: Text(title,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal)),
    actions: [
      if (getBack)
        TextButton(
          child: const Text("Ok"),
          onPressed: () {
            Get.back();
          },
        )
    ],
  ));
}
