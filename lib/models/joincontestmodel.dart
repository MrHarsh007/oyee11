// To parse this JSON data, do
//
//     final joincontestmodel = joincontestmodelFromJson(jsonString);

import 'dart:convert';

Joincontestmodel joincontestmodelFromJson(String str) => Joincontestmodel.fromJson(json.decode(str));

String joincontestmodelToJson(Joincontestmodel data) => json.encode(data.toJson());

class Joincontestmodel {
  Joincontestmodel({
    required this.error,
    required this.message,
    required this.transactionNumber,
    required this.user,
  });

  bool error;
  String? message;
  String? transactionNumber;
  User? user;

  factory Joincontestmodel.fromJson(Map<String, dynamic> json) => Joincontestmodel(
    error: json["error"],
    message: json["message"] == null ? null : json["message"].toString(),
    transactionNumber: json["transaction_number"] == null ? null : json["transaction_number"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "transaction_number": transactionNumber,
    "user": user!.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.userId,
    required this.totalAmount,
  });

  String id;
  String userId;
  String totalAmount;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userId: json["user_id"],
    totalAmount: json["total_amount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "total_amount": totalAmount,
  };
}
