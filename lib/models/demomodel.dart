// To parse this JSON data, do
//
//     final demomodel = demomodelFromJson(jsonString);

import 'dart:convert';

Demomodel demomodelFromJson(String str) => Demomodel.fromJson(json.decode(str));

String demomodelToJson(Demomodel data) => json.encode(data.toJson());

class Demomodel {
  Demomodel({
    required this.error,
    required this.message,
  });

  String error;
  String message;

  factory Demomodel.fromJson(Map<String, dynamic> json) => Demomodel(
    error: json["error"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
  };
}
