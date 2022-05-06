import 'dart:convert';

/*Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());*/

List<Login> userFromJson(String str) => List<Login>.from(json.decode(str).map((x) => Login.fromJson(x)));
String userToJson(List<Login> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Login {
  Login({
    required this.status,
    required this.msg,
    required this.userId,
    required this.tokenId,
    required this.url,
    required this.userType,
  });

  int status;
  String msg;
  String userId;
  String tokenId;
  String url;
  int userType;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    status: json["status"],
    msg: json["msg"],
    userId: json["userId"],
    tokenId: json["tokenId"],
    url: json["url"],
    userType: json["userType"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "msg": msg,
    "userId": userId,
    "tokenId": tokenId,
    "url": url,
    "userType": userType,
  };
}
