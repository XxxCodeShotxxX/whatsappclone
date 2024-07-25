import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/controllers/register_controller.dart';
import 'package:whatsappclone/widgets/country_list.dart';

class PhoneNumberScreen extends StatelessWidget {
  const PhoneNumberScreen({super.key});
  static RegisterController registerController = Get.put(RegisterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Enter Your Phone Number",
          style: TextStyle(
              // fontSize: 18,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                      text: "WhatsApp will need to verify your phone number."),
                  TextSpan(
                      text: " What's my number?",
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()..onTap = () {}),
                ],
                style: const TextStyle(color: Colors.black, fontSize: 13.0),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: Get.width * 0.75,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.06,
                  child: InkWell(
                    onTap: () => Get.to(() => const CountryList()),
                    child: Row(
                      children: [
                        Obx(() => Text(
                            registerController.isInvalidCode.value
                                ? "Invalide Country Code"
                                : registerController.selectedCountry.value.name,
                            style: const TextStyle(fontSize: 18))),
                        const Spacer(),
                        Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                      ],
                    ),
                  ),
                ),
                Divider(
                    color: Theme.of(context).colorScheme.secondary,
                    height: 5.0,
                    thickness: 1.5),
                Container(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Row(children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const Text(
                                '+',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: registerController.dialCode,
                                  onChanged:
                                      registerController.onDialCodeChange,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: false, signed: false),
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          ),
                          Divider(
                              color: Theme.of(context).colorScheme.secondary,
                              height: 5.0,
                              thickness: 1.5),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        flex: 7,
                        child: TextField(
                          controller: registerController.phoneNumber,
                          keyboardType: TextInputType.phone,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: "phone number",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 1.5),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  width: 1.5),
                            ),
                          ),
                        )
                        )
                  ]),
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
                  onPressed: () => registerController.navToOtpScreen(),
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
                    "NEXT",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
