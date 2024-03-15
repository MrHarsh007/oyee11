import 'dart:convert';

Myteams myteamsFromJson(String str) => Myteams.fromJson(json.decode(str));

String myteamsToJson(Myteams data) => json.encode(data.toJson());

class Myteams {
  Myteams({
    required this.error,
    required this.data,
  });

  bool error;
  List<Datum> data;

  factory Myteams.fromJson(Map<String, dynamic> json) => Myteams(
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
    required this.tokenLimit,
    required this.id,
    required this.userid,
    required this.matchid,
    required this.contestid,
    required this.team,
    required this.side,
    required this.player,
    required this.type,
    required this.value,
    required this.point,
    required this.created,
    required this.status,
  });

  String tokenLimit;
  String id;
  String userid;
  String matchid;
  String contestid;
  String team;
  String side;
  String player;
  String type;
  String value;
  String point;
  DateTime created;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    tokenLimit: json["tokenLimit"],
    id: json["id"],
    userid: json["userid"],
    matchid: json["matchid"],
    contestid: json["contestid"],
    team: json["team"],
    side: json["side"],
    player: json["player"],
    type: json["type"],
    value: json["value"],
    point: json["point"],
    created: DateTime.parse(json["created"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "tokenLimit": tokenLimit,
    "id": id,
    "userid": userid,
    "matchid": matchid,
    "contestid": contestid,
    "team": team,
    "side": side,
    "player": player,
    "type": type,
    "value": value,
    "point": point,
    "created": created.toIso8601String(),
    "status": status,
  };
}
