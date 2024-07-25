import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/handlers/sharedpref_handler.dart';
import 'package:whatsappclone/keys/sharedpref_keys.dart';
import 'package:whatsappclone/screens/authentification/terms_condition_screen.dart';
import 'package:whatsappclone/screens/home.dart';

class IndexController extends GetxController {
  var mainWidget = Rx<Widget?>(null);

  @override
  void onInit() {
    super.onInit();
    checkUp();
  }

  Future<void> checkUp() async {
    String authToken = await SharedprefHandler().readString(SharedPrefKeys.authToken);
    log("authToken: $authToken");
    if (authToken.isNotEmpty) {
      mainWidget.value = const HomeScreen();
    } else {
      mainWidget.value = const TermsConditionScreen();
    }
  }
}
