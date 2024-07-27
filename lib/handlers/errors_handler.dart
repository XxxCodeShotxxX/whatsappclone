





import 'package:get/get.dart';

class AppException implements Exception {
  final String _message;

  AppException(this._message);

  @override
  String toString() {
    return " $_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException(String message) : super(message) {
    Get.snackbar(message, "", snackPosition: SnackPosition.BOTTOM);
  }
}