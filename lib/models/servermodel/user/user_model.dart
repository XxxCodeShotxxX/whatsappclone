
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());


class UserModel {
  UserModel({this.userId, this.userName, this.userBio, this.lastSeen, this.status,this.phoneNumber,this.dialCode,this.sockedId, this.userImage, this.createdAt});
  String? userId;
  String? userName;
  String? userImage;
  String? userBio;
  String? sockedId;
  String? dialCode;
  String? phoneNumber;
  DateTime? createdAt;
  bool? status;
  DateTime? lastSeen;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId : json["id"] as String,
      userName:json["userName"] as String,
      userImage:json["profilePic"]  ?? "",
      lastSeen:json["lastSeen"] == null? null:DateTime.parse(json["lastSeen"]),
      status:json["onlineStatus"]== null? null:json["onlineStatus"] as bool,
phoneNumber:json["phoneNumber"] as String,
      dialCode:json["dialCode"] as String,
      sockedId:json["socketId"] as String,
      userBio:json["bio"]== null? null :json["bio"]  as String,
      createdAt:json["createdAt"] == null ?null :DateTime.parse(json["createdAt"]),
    );
  }
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "userName": userName,
        "userImage": userImage,
        "userBio": userBio,
        "lastSeen": lastSeen?.toIso8601String(),
        "status": status,
        "sockedId": sockedId,
        "phoneNumber": phoneNumber,

        "dialCode": dialCode,
        "createdAt": createdAt!.toIso8601String(),
      };
}

