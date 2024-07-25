import 'package:get/get.dart';
import 'package:whatsappclone/patch_tester.dart';
import 'package:whatsappclone/routes/routes_names.dart';
import 'package:whatsappclone/screens/authentification/index_page.dart';
import 'package:whatsappclone/screens/authentification/otp_screen.dart';
import 'package:whatsappclone/screens/authentification/phone_number_screen.dart';
import 'package:whatsappclone/screens/authentification/terms_condition_screen.dart';
import 'package:whatsappclone/screens/home.dart';
import 'package:whatsappclone/screens/profile/initial_profile_screen.dart';

class AppRoutes {
  static List<GetPage<dynamic>> routes = [

    GetPage(name: RoutesNames.home, page: () => const HomeScreen()),
    GetPage(name: RoutesNames.enterNumberScreen, page: () => const PhoneNumberScreen ()),
    GetPage(name: RoutesNames.termsCondition, page: () => const TermsConditionScreen  ()),
    GetPage(name: RoutesNames.initialProfileScreen, page: () => const InitialProfileScreen  ()),
    GetPage(name: RoutesNames.indexPage, page: () => const IndexPage ()),
    GetPage(name: RoutesNames.otpScreen, page: () => const OtpScreen ()),
    GetPage(name: RoutesNames.testPage, page: () =>  PatchTester ()),
  ];
}