import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:whatsappclone/handlers/http_handler.dart';
import 'package:whatsappclone/handlers/sharedpref_handler.dart';
import 'package:whatsappclone/keys/api_routes.dart';
import 'package:whatsappclone/keys/db_cnames.dart';
import 'package:whatsappclone/keys/sharedpref_keys.dart';
import 'package:whatsappclone/models/localdbmodel/db_chat_list_model.dart';
import 'package:whatsappclone/models/localdbmodel/db_user_model.dart';
import 'package:whatsappclone/models/servermodel/user/user_model.dart';
import 'package:whatsappclone/repository/user_repo.dart';

class UserController extends GetxController {
  UserRepo userRepo = UserRepo();
  SharedprefHandler sharedPref = SharedprefHandler();
  HttpHandler _httpHandler = HttpHandler();

  Rx<UserModel> userData = UserModel().obs;
  RxString userId = "".obs;

  Box<DbUserModel> userBox = Hive.box<DbUserModel>(DbCnames.user);
  Box<DbChatListModel> chatList = Hive.box<DbChatListModel>(DbCnames.chatList);
  RxList<DbChatListModel> chatListData = <DbChatListModel>[].obs;

  void getChatList() {
    chatListData.clear();
    chatList.toMap().forEach((key, value) => chatListData.add(value));
    chatListData.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  void updateUserStatus(bool status) {
    userRepo.updateUserStatus(status);
  }

  Future<void> getMyDetails() async {
    var result = await userRepo.getMyDetails();

    try {
      if (result.runtimeType.toString() == 'UserModel') {
        UserModel data = result;
        userData.value = data;
        userId.value = data.userId ?? "";

        sharedPref.writeString(SharedPrefKeys.userId, userId.value);
        sharedPref.writeString(
            SharedPrefKeys.userDetails, data.toJson().toString());
      } else {
        log("something wrong --> getMyDetails : $result");
      }
    } catch (e) {
      log("error getMyDetails $e");
    }
  }

  Future<void> updateProfileById(String userId) async {
    var result = await userRepo.getUserDetailsById(userId);

    if (result.runtimeType.toString() == "UserModel") {
      UserModel data = result;

      String imagePath = userBox.get(userId)?.imagePath ?? "";



      if (imagePath != data.userImage) {
        chatListData.singleWhere((element) => element.userId == userId);
      }

      DbUserModel dbUserModel = DbUserModel(
          id: data.userId ?? "",
          name: data.userName ?? "",
          about: data.userBio ?? "",
          imagePath: data.userImage ?? "",
          phone: data.phoneNumber ?? "");

      userBox.put(userId, dbUserModel);
    }
  }

  List<String> getUserNameImage(String userId) {
    DbUserModel? userData = userBox.get(userId);

    if (userData != null) {
    log("profileImage : " + userData.imagePath);
      return [
        userData.name.isEmpty ? userData.phone.toString() : userData.name,
        userData.imagePath
      ];
    } else {
      return ["", ""];
    }
  }
}
