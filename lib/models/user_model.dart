// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.error,
    required this.message,
    required this.user,
  });

  bool error;
  String message;
  User user;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    error: json["error"],
    message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.mail,
  });

  String id;
  String name;
  String mail;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    mail: json["mail"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "mail": mail,
  };
}
