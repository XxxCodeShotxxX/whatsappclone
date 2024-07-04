import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsappclone/main.dart';
import 'package:whatsappclone/screens/camera/image_view_screen.dart';
import 'package:whatsappclone/screens/camera/video_view_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController cameraController;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool flash = true;
  double angle  = 0.2;
  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraValue = cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  void takePic() async {
    XFile image = await cameraController.takePicture();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => ImageViewScreen(path: image.path)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(children: [
        FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(cameraController);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: const Color.fromARGB(255, 0, 0, 0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6.5,
            child: Column(
              children: [
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (!flash){
                            cameraController.setFlashMode(FlashMode.torch);
                            setState(() {
                              flash = true;
                            });
                            }
                            else {
                            cameraController.setFlashMode(FlashMode.off);
                            setState(() {
                              flash=false;
                            });
                            }

                          },
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            size: 28,
                            color: Colors.white,
                          )),
                      GestureDetector(
                        onTap: () {
                          if (!isRecording) takePic();
                        },
                        onLongPress: () async {
                          await cameraController.startVideoRecording();
                          setState(() {
                            isRecording = true;
                          });
                        },
                        onLongPressUp: () async {
                          setState(() {
                            isRecording = false;
                          });
                          XFile video =
                              await cameraController.stopVideoRecording();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      VideoViewScreen(path: video.path)));
                        },
                        child: Icon(
                          isRecording
                              ? Icons.radio_button_on
                              : Icons.panorama_fisheye,
                          size: 70,
                          color: Colors.white,
                        ),
                      ),
                       Transform.rotate(
                       angle: angle,
                         child: IconButton(
                            onPressed: (){
                            setState(() {
                              angle = angle + pi/2;
                            });},
                            icon: const Icon(
                              Icons.flip_camera_android,
                              size: 28,
                              color: Colors.white,
                            )),
                       ),
                    ]),
                const Text(
                  "Hold for video , tap for photo",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        )
      ]),
    );
  }
}
