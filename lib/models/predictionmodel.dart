// To parse required this JSON data, do
//
//     final predictionmodel = predictionmodelFromJson(jsonString);

import 'dart:convert';

Predictionmodel predictionmodelFromJson(String str) => Predictionmodel.fromJson(json.decode(str));

String predictionmodelToJson(Predictionmodel data) => json.encode(data.toJson());

class Predictionmodel {
  Predictionmodel({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  List<Datum>? data;

  factory Predictionmodel.fromJson(Map<String, dynamic> json) => Predictionmodel(
    error: json["error"],
    message: json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.userid,
    required this.contestid,
    required this.team,
    required this.side,
    required this.player,
    required this.type,
    required this.value,
    required this.created,
    required this.status,
  });

  String id;
  String userid;
  String contestid;
  String team;
  String side;
  String player;
  String type;
  String value;
  DateTime created;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"].toString(),
    userid: json["userid"].toString(),
    contestid: json["contestid"].toString(),
    team: json["team"].toString(),
    side: json["side"].toString(),
    player: json["player"].toString(),
    type: json["type"].toString(),
    value: json["value"].toString(),
    created: DateTime.parse(json["created"]),
    status: json["status"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "contestid": contestid,
    "team": team,
    "side": side,
    "player": player,
    "type": type,
    "value": value,
    "created": created.toIso8601String(),
    "status": status,
  };
}
