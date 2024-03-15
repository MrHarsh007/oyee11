// To parse this JSON data, do
//
//     final loginmodel = loginmodelFromJson(jsonString);

import 'dart:convert';

Loginmodel loginmodelFromJson(String str) => Loginmodel.fromJson(json.decode(str));

String loginmodelToJson(Loginmodel data) => json.encode(data.toJson());

class Loginmodel {
  Loginmodel({
    required this.error,
    required this.message,
    required this.user,
  });

  bool error;
  String message;
  User? user;

  factory Loginmodel.fromJson(Map<String, dynamic> json) => Loginmodel(
    error: json["error"],
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "user": user!.toJson(),
  };
}

class User {
  User({
    required this.token,
    required this.userId,
    required this.userName,
    required this.email,
    required this.mobileNumber,
  });

  String token;
  String userId;
  String userName;
  String email;
  String mobileNumber;

  factory User.fromJson(Map<String, dynamic> json) => User(
    token: json["token"],
    userId: json["user_id"],
    userName: json["user_name"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user_id": userId,
    "user_name": userName,
    "email": email,
    "mobile_number": mobileNumber,
  };
}



