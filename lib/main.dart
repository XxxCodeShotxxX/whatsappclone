import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/screens/home.dart';
import 'package:whatsappclone/screens/login_screen.dart';
import 'package:whatsappclone/screens/socket_test.dart';
late List<CameraDescription> cameras;

Future<void> main  () async{
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "OpenSans",
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF075E54),
            secondary: Color(0xFF128C7E),
          )),
      home: const LoginScreen(),
    );
  }
}
