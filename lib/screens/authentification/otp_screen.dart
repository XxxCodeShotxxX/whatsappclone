import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/controllers/register_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});
  static RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Verify Your Phone Number",
          style: TextStyle(
              // fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(children: [
        Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text:
                        "We have sent a SMS message to ${registerController.selectedCountry.value.dialCode}${registerController.phoneNumber.value.text}.\n"),
                TextSpan(
                    text: " Wrong number?",
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()..onTap = () {}),
              ],
              style: const TextStyle(color: Colors.black, fontSize: 13.0),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: Get.width * 0.6,
          child: Column(
            children: [
              TextField(
                controller: registerController.smsCode,
                keyboardType: TextInputType.phone,
                textAlignVertical: TextAlignVertical.center,
                maxLength: 6,
                decoration: InputDecoration(
                  hintText: "OTP Code",
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
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Enter 6-digit code",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: Get.width * 0.9,
          child: const Column(
            children: [
              ListTile(
                leading: Icon(Icons.sms),
                title: Text("Resend Sms"),
                trailing: Text("01:00"),
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.call),
                title: Text("Call me"),
                trailing: Text("01:00"),
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: SizedBox(
            width: Get.width / 1.75,
            child: ElevatedButton(
                onPressed: ()=> registerController.verifyOTP(),
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
                  "Verify",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        )
      ]),
    );
  }
}
