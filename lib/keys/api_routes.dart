class Api {
  static const baseUrl = 'http://192.168.1.69:5000/';
  static const String myDetails = "${baseUrl}auth/MyDetails";
  static const String usersList = "${baseUrl}getUsers";
  static const String userStatus = "${baseUrl}user/updateUserStatus";
  static const String getUserStatus = "${baseUrl}user/getUserStatus";
  static const String sendMessage = "${baseUrl}message/sendMessage";
  static const String receivedMessageUpdate = "${baseUrl}message/messageReceivedUpdate";
  static const String openedMessageUpdate = "${baseUrl}message/messageOpenedUpdate";
  static const String userDetails = "${baseUrl}user/";
  static const String userDetailsById = "${baseUrl}user/getUserDetailsById/";
  static const String profileImage = "${baseUrl}user/profileImage";
  static const String userName = "${baseUrl}user/updateUserName";
  static const String userRegistration = "${baseUrl}auth/userRegistration";
}
