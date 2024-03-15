// To parse this JSON data, do
//
//     final msgmodel = msgmodelFromJson(jsonString);

import 'dart:convert';

Msgmodel msgmodelFromJson(String str) => Msgmodel.fromJson(json.decode(str));

String msgmodelToJson(Msgmodel data) => json.encode(data.toJson());

class Msgmodel {
  Msgmodel({
    required this.error,
    required this.message,
  });

  bool error;
  String message;

  factory Msgmodel.fromJson(Map<String, dynamic> json) => Msgmodel(
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };
}
