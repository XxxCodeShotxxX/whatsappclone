import 'dart:math';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:whatsappclone/screens/camera/image_view_screen.dart';
import 'package:whatsappclone/screens/camera/video_view_screen.dart';

class CameraGetController extends GetxController {
  static late List<CameraDescription> cameras;

  static late CameraController controller;
  late Future<void> cameraValue;
  RxBool isRecording = false.obs;
  RxBool flash = false.obs;
  RxDouble angle = 0.2.obs;

  @override
  void onInit() async {
    controller = CameraController(cameras[0], ResolutionPreset.medium);

    cameraValue = controller.initialize();
    super.onInit();
  }

  @override
  void onClose() {
    controller.setFlashMode(FlashMode.off);
    flash.value = false;
    controller.dispose();
    super.onClose();
  }


  void takePic() async {
    XFile image = await controller.takePicture();
    Get.to(() => ImageViewScreen(image: image,userId: "id",));
  }

  void startRec() async {
    await controller.startVideoRecording();
    isRecording.value = true;
  }

  void stopRec() async {
    isRecording.value = false;
    XFile video = await controller.stopVideoRecording();
    Get.to(() => VideoViewScreen(path: video.path));
  }

  void rotateCamera() {
    angle.value = (angle.value + pi / 2) % (2 * pi);
  }

  void toggleFlash() {
    if (flash.value) {
turnOffFlash();
    } else {
      controller.setFlashMode(FlashMode.torch);
      flash.value = true;
    }
  }

  void turnOffFlash() {
        controller.setFlashMode(FlashMode.off);
      flash.value = false;}
}
