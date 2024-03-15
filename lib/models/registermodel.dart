import 'dart:convert';

Registermodel registermodelFromJson(String str) => Registermodel.fromJson(json.decode(str));

String registermodelToJson(Registermodel data) => json.encode(data.toJson());

class Registermodel {
  Registermodel({
    required this.error,
    required this.message,
    required this.user,
  });

  bool error;
  String message;
  User? user;

  factory Registermodel.fromJson(Map<String, dynamic> json) => Registermodel(
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
    required this.userId,
    required this.userName,
    required this.email,
  });

  String userId;
  String userName;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["user_id"],
    userName: json["user_name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "email": email,
  };
}
