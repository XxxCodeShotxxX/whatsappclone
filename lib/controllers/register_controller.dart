import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/handlers/sharedpref_handler.dart';
import 'package:whatsappclone/keys/country_list.dart';
import 'package:whatsappclone/keys/sharedpref_keys.dart';
import 'package:whatsappclone/models/servermodel/country_model.dart';
import 'package:whatsappclone/models/servermodel/user/user_login_registration_model.dart';
import 'package:whatsappclone/repository/user_repo.dart';
import 'package:whatsappclone/routes/routes_names.dart';
import 'package:whatsappclone/screens/authentification/otp_screen.dart';
import 'package:whatsappclone/widgets/loading_box.dart';

import '../widgets/dialog_ok_box.dart';

class RegisterController extends GetxController {
  static CountryModel countryModel = CountryModel.fromMap(countryListData);
  FirebaseAuth auth = FirebaseAuth.instance;
  RxString otpValue = "".obs;
  RxBool isInvalidCode = false.obs;
  Rx<Datum> selectedCountry = Datum(
    name: countryModel.data[0].name,
    flag: countryModel.data[0].flag,
    code: countryModel.data[0].code,
    dialCode: countryModel.data[0].dialCode,
  ).obs;

  TextEditingController dialCode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController smsCode = TextEditingController();

late String codeVerificationId;

  // on init
  @override
  void onInit() {
    dialCode.text = selectedCountry.value.dialCode.split("+")[1];
    super.onInit();
  }

  void changeCountry(Datum country) {
    selectedCountry.value = country;
    dialCode.text = country.dialCode.split("+")[1];
    Get.back();
  }

  void onDialCodeChange(String value) {
    CountryModel tempCountryData = countryModel;
    isInvalidCode.value = false;
    Datum? data = tempCountryData.data
        .firstWhereOrNull((element) => element.dialCode.split("+")[1] == value);

    if (data == null) {
      isInvalidCode.value = true;
    } else {
      selectedCountry.value = data;
    }
  }

  Future<void> navToOtpScreen() async {
    if (isInvalidCode.value) {
      dialogOkBox("Invalid Dial Code", true);
    } else if (phoneNumber.text.isEmpty) {
      dialogOkBox("Enter phone number", true);
    } else {
      loadingBox();
      Get.to(() => const OtpScreen());
      await phoneAuth();
    }
  }

  Future<void> phoneAuth() async {
    try {
      log('${selectedCountry.value.dialCode}${phoneNumber.text} <--> phoneNumber');
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${selectedCountry.value.dialCode}${phoneNumber.text}',
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {

          await FirebaseAuth.instance.signInWithCredential(credential);
          log('Phone number automatically verified and user signed in: $credential');
        },
        verificationFailed: (FirebaseAuthException e) {

          if (e.code == 'invalid-phone-number') {
            log('The provided phone number is not valid.');
          } else {
            log('Phone number verification failed. Code: ${e.code}. Message: ${e.message}');
          }
        },
        codeSent: (String verificationId, int? resendToken) {

         codeVerificationId = verificationId;
          Get.to(() => const OtpScreen());
          log('Verification code sent to the phone number.');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          codeVerificationId = verificationId;
          log('Automatic code retrieval timed out.');
        },
      );
    } catch (e) {
      log('Error during phone number verification: $e');
    }
  }

  Future<void> verifyOTP() async {
 if (codeVerificationId.isEmpty) {
  dialogOkBox("Something Wrong !!", true);
 } else if (smsCode.text.length != 6) {
      dialogOkBox("Please Enter 6-digit Code", true);
    } else {
      try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
       verificationId: codeVerificationId,
             smsCode: smsCode.text,
             );
     await auth.signInWithCredential(credential);
        loginTOServer();
      } catch (e) {
        log("error : $e");
      }
    }
  }

  Future<void> loginTOServer() async {
    UserRepo userRepo = UserRepo();
    SharedprefHandler sharedprefHandler = SharedprefHandler();

    try {
      dynamic response =
          await userRepo.userLoginRegister(phoneNumber.text, dialCode.text);
     


       if (response.runtimeType.toString().toLowerCase() ==
           "userloginregistrationmodel") {

         UserLoginRegistrationModel userData = response;
         await sharedprefHandler.writeString(SharedPrefKeys.authToken, userData.token.toString());
         Get.offAllNamed(RoutesNames.initialProfileScreen);
       }
    } catch (e) {
      log("error -LoginToServer- : $e ");
    }
  }
}
