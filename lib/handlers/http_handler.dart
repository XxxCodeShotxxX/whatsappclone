import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:whatsappclone/handlers/sharedpref_handler.dart';
import 'package:whatsappclone/keys/sharedpref_keys.dart';

class HttpHandler {
  Future<dynamic> get(String url, {bool auth = true}) async {
    try {
      Map<String, String> headers = await _httpHeaders(auth);
      var response = await http.get(Uri.parse(url), headers: headers);

      //log("get url: $url \nheader: $headers \nstatusCode: ${response.statusCode} \nresponse ${response.body} ");
      return response;
    } catch (e) {
      if (e is SocketException) {
        Get.snackbar(e.toString(), "", snackPosition: SnackPosition.BOTTOM);
      }
      log("get error -httpHandler- ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> post(String url, dynamic body, {bool auth = true}) async {
    Map<String, String> headers = await _httpHeaders(auth);

    try {
      var response =
          await http.post(Uri.parse(url), body: body, headers: headers);
      // log("post url: $url \nheader: $headers \nbody: $body \nstatusCode: ${response.statusCode} \nresponse ${response.body} ");

      return response;
    } catch (e) {
      if (e is SocketException) {
        Get.snackbar(e.toString(), "", snackPosition: SnackPosition.BOTTOM);
      }
      log("post error -httpHandler- ${e.toString()}");
      return null;
    }
  }

  Future<dynamic> put(String url, dynamic body, {bool auth = true}) async {
    Map<String, String>? header = await _httpHeaders(auth);

    //log("requesting for put $url \nheader $header \nbody $body");

    try {
      var response =
          await http.put(Uri.parse(url), body: body, headers: header);

      // log("put url: $url \nheader: $header \nbody: $body \nstatusCode: ${response.statusCode} \nresponse ${response.body} ");

      return (response);
    } catch (e) {
      if (e is SocketException) {
        Get.snackbar(e.toString(), "", snackPosition: SnackPosition.BOTTOM);
      }
      log("http catch put $e");
    }

    return null;
  }

  Future<dynamic> delete(String url, {bool auth = true}) async {}

  Future<Map<String, String>> _httpHeaders(bool auth) async {
    Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json'
    };

    if (auth) {
      String authToken =
          await SharedprefHandler().readString(SharedPrefKeys.authToken);
      headers.addAll({HttpHeaders.authorizationHeader: 'Bearer $authToken'});
    }
    return headers;
  }

  Future<dynamic> multipart({
    required String url,
    required String filePath,
    required String fieldName,
    dynamic body,
    bool auth = true,
  }) async {
    Map<String, String> headers = await _httpHeaders(auth);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      log("request");
      request.headers.addAll(headers);
      log("AUTHHEADERS added");

      if (body != null) {
        // Convert body to Map<String, String>
        Map<String, String> stringBody = {};
        body.forEach((key, value) {
          stringBody[key] = value.toString();
        });
        request.fields.addAll(stringBody);
      }

      log("fields added");
      request.files.add(http.MultipartFile.fromBytes(
          fieldName, File(filePath).readAsBytesSync(),
          filename: filePath.split('/').last));
      log("file added");
      var res = await request.send();
      log("sent");
      var response = await http.Response.fromStream(res);
      log("multiple url: $url \nheader: ${headers.toString()} \nfilename : ${filePath.split('/').last} \nstatusCode: ${response.statusCode} \nresponse ${response.body} ");

      return response;
    } catch (e) {
      if (e is SocketException) {
        Get.snackbar(e.toString(), "", snackPosition: SnackPosition.BOTTOM);
      }
      log("Error -multipart- : ${e.toString()}");
      return null;
    }
  }
}
