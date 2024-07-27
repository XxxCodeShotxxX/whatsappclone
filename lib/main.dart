import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/controllers/camera_controller.dart';
import 'package:whatsappclone/handlers/local_database_handler.dart';
import 'package:whatsappclone/routes/app_routes.dart';
import 'package:whatsappclone/routes/routes_names.dart';

import 'package:whatsappclone/theme/light_theme.dart';


Future<void> main  () async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabaseHandler().initDb();
//  await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   await FirebaseAppCheck.instance.activate(
//     webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
//     androidProvider: AndroidProvider.debug,
//     appleProvider: AppleProvider.appAttest,
//   );
  CameraGetController.cameras = await availableCameras();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      defaultTransition: Transition.downToUp,
      initialRoute: RoutesNames.indexPage,
      //initialRoute: RoutesNames.indexPage,
      getPages: AppRoutes.routes,
    );
  }
}
