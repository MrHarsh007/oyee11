// To parse this JSON data, do
//
//     final rankmodel = rankmodelFromJson(jsonString);

import 'dart:convert';

Rankmodel rankmodelFromJson(String str) => Rankmodel.fromJson(json.decode(str));

String rankmodelToJson(Rankmodel data) => json.encode(data.toJson());

class Rankmodel {
  Rankmodel({
    required this.error,
    required this.data,
  });

  bool error;
  List<Datum> data;

  factory Rankmodel.fromJson(Map<String, dynamic> json) => Rankmodel(
    error: json["error"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.contestId,
    required this.levelSize,
    required this.levelAmount,
    required this.status,
    required this.date,
  });

  String id;
  String contestId;
  String levelSize;
  String levelAmount;
  String status;
  DateTime? date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    contestId: json["contestId"],
    levelSize: json["level_size"],
    levelAmount: json["level_amount"],
    status: json["status"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "contestId": contestId,
    "level_size": levelSize,
    "level_amount": levelAmount,
    "status": status,
    "date": date!.toIso8601String(),
  };
}
