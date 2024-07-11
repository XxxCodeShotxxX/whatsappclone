class User {
  String userId;
  String userName;
  bool isOnline;
  DateTime lastSeen;
  User(this.userId, this.userName, this.isOnline, this.lastSeen);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json["userId"] as String,
      json["userName"] as String,
      json["isOnline"] as bool,
      DateTime.parse(json["lastSeen"]),
    );
  }
}
