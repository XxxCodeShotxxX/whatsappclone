import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/controllers/camera_controller.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});
  static CameraGetController cameraController = Get.put(CameraGetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Stack(children: [
        FutureBuilder(
            future: cameraController.cameraValue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(CameraGetController.controller);
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
            width: Get.width,
            height: Get.height / 6.5,
            child: Column(
              children: [
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Obx(()=>IconButton(
                          onPressed: cameraController.toggleFlash,
                          icon: Icon(
                            cameraController.flash.value ? Icons.flash_on : Icons.flash_off,
                            size: 28,
                            color: Colors.white,
                          )),),
                      GestureDetector(
                        onTap: cameraController.takePic,
                        onLongPress: cameraController.startRec,
                        onLongPressUp: cameraController.stopRec,
                        child: Obx(() => Icon(
                          cameraController.isRecording.value
                              ? Icons.radio_button_on
                              : Icons.panorama_fisheye,
                          size: 70,
                          color:!cameraController.isRecording.value
                              ? Colors.white : Colors.red,
                        ),),
                      ),
                       Obx(()=>Transform.rotate(
                       angle: cameraController.angle.value,
                         child: IconButton(
                            onPressed: cameraController.rotateCamera,
                            icon: const Icon(
                              Icons.flip_camera_android,
                              size: 28,
                              color: Colors.white,
                            )),
                       )),
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
