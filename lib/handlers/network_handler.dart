import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:whatsappclone/models/user_model.dart';

class NetworkHandler {
  String baseurl = "http://192.168.1.69:5000/";
  Future<http.StreamedResponse> postImage(
      String url, String filepath, String imageName) async {
    url = formater(url);

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath,
        filename: basename(imageName)));
    request.fields['imageName'] = imageName; // Add the imageName field
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });

    try {
      var response = await request.send();
      return response;
    } catch (e) {
      throw Exception("Failed to send request: $e");
    }
  }

  Future<void> setOnline(String userId) async {
    final response =
        await http.post(Uri.parse(formater("api/status/setOnline")), body: 
      jsonEncode({"userId": userId})
    , headers: {
      'Content-Type': 'application/json'
    });
   log(response.statusCode.toString());
    if (response.statusCode != 201) {
      throw Exception("Failed to set online");
    }
    log(response.body);
  }
    Future<void> setOffline(String userId) async {
    final response =
        await http.post(Uri.parse(formater("api/status/setOffline")), body: 
      jsonEncode({"userId": userId})
    , headers: {
      'Content-Type': 'application/json'
    });
   log(response.statusCode.toString());
    if (response.statusCode != 201) {
      throw Exception("Failed to set offline");
    }
        log(response.body);

  }

  Future<List<User>> getUsers() async {

final response = await http.get(Uri.parse('http://192.168.1.69:5000/api/status/getUsers'));

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    List<User> users = body.map((dynamic item) => User.fromJson(item)).toList();
    return users;
  } else {
    throw Exception('Failed to load users');
  }
  }


  String formater(String url) {
    return baseurl + url;
  }
}
