import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/routes/routes_names.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          SizedBox(
              width: Get.width * 0.9,
              child: FittedBox(
                child: Text(
                  "Welcome to WhatsApp",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Expanded(
            child: Image.asset(
              "assets/images/landing_background.png",
              width: Get.width / 1.5,
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Read our",
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                    text: " Privacy Policy.",
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () {}),
                const TextSpan(
                  text: " Tap \"Agree and continue\" to accept the",
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                    text: " Terms of Service.",
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () {}),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
            child: ElevatedButton(
                onPressed: () => Get.toNamed(RoutesNames.enterNumberScreen),
                style: ButtonStyle(
                  shape: WidgetStateProperty.resolveWith(
                    (states) => RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  backgroundColor: WidgetStateColor.resolveWith(
                      (states) => Theme.of(context).colorScheme.secondary),
                  padding: WidgetStateProperty.resolveWith((states) =>
                      const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 52.0)),
                ),
                child: const Text(
                  "AGREE AND CONTINUE",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ]));
  }
}
