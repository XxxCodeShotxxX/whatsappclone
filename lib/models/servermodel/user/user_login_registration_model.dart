import 'dart:convert';

import 'package:whatsappclone/models/servermodel/user/user_model.dart';




UserLoginRegistrationModel userLoginRegistrationModelFromJson(String str) =>
    UserLoginRegistrationModel.fromJson(json.decode(str));

String userLoginRegistrationModelToJson(UserLoginRegistrationModel data) =>
    json.encode(data.toJson());

class UserLoginRegistrationModel {
  UserLoginRegistrationModel({
    this.message,
    this.token,
    this.user,
    this.createdAt,
  });

  String? message;
  String? token;
  UserModel? user;
  DateTime? createdAt;

  factory UserLoginRegistrationModel.fromJson(Map<String, dynamic> json) =>
      UserLoginRegistrationModel(
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "token": token,
        "user": user?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
      };
}