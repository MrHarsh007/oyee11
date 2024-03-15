// To parse this JSON data, do
//
//     final contactModel = contactModelFromJson(jsonString);

import 'dart:convert';

ContactModel contactModelFromJson(String str) => ContactModel.fromJson(json.decode(str));

String contactModelToJson(ContactModel data) => json.encode(data.toJson());

class ContactModel {
  ContactModel({
    required this.error,
    required this.message,
    required this.subject,
  });

  bool error;
  String message;
  String subject;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    error: json["error"],
    message: json["message"],
    subject: json["subject"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "subject": subject,
  };
}
