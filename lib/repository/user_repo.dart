import 'dart:convert';
import 'dart:developer';

import 'package:whatsappclone/handlers/http_handler.dart';
import 'package:whatsappclone/keys/api_routes.dart';
import 'package:whatsappclone/models/servermodel/user/user_login_registration_model.dart';
import 'package:whatsappclone/models/servermodel/user/user_model.dart';

class UserRepo{


  final HttpHandler _httpHandler = HttpHandler();



  Future<dynamic> userLoginRegister(String phoneNumber,String dialCode)async{

    var response = await _httpHandler.post(Api.userRegistration, {"phoneNumber":phoneNumber,"dialCode":dialCode},auth: false);


    if(response.statusCode == 200){
      UserLoginRegistrationModel userauth = userLoginRegistrationModelFromJson(response.body);
      return userauth;
    }
 
    return response;


}



      Future<dynamic> profileImageUpload(String imagePath) async {
    var response = await _httpHandler.multipart(
        url: Api.profileImage, fieldName: "image",filePath: imagePath);

    return response;
  }



   Future<dynamic> userNameUpdate(String userName) async {
  try {
    var response = await _httpHandler.put(Api.userName, {"newName": userName});
    return response;
  } catch (e) {
    log("Error updating username: $e");
    return {"error": "Failed to update username"};
  }
}

  Future<dynamic> updateUserStatus(bool status) async =>
      await _httpHandler.put(Api.userStatus, {"status": "$status"});



  Future<dynamic> getMyDetails() async {
    var response = await _httpHandler.get(Api.myDetails);

    if (response.runtimeType.toString() == "Response") {
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body));
      return userModel;
    }
    return response;
  }

Future<dynamic> getUserDetailsById(String userId) async {
    var response = await _httpHandler.get(Api.userDetailsById + userId);

    if (response.runtimeType.toString() == "Response") {
      UserModel userStatusModel = UserModel.fromJson(jsonDecode(response.body));
      return userStatusModel;
    }
    return response;
  }


    Future<dynamic> getUserStatus(String id) async 
      {
      log("${Api.getUserStatus}/$id");
    await _httpHandler.get("${Api.getUserStatus}/$id");}
  }
