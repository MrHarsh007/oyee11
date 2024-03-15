// To parse this JSON data, do
//
//     final showpredictionsmodel = showpredictionsmodelFromJson(jsonString);

/*import 'dart:convert';

Showpredictionsmodel showpredictionsmodelFromJson(String str) => Showpredictionsmodel.fromJson(json.decode(str));

String showpredictionsmodelToJson(Showpredictionsmodel data) => json.encode(data.toJson());

class Showpredictionsmodel {
  Showpredictionsmodel({
    required this.error,
    required this.data,
  });

  bool error;
  List<Datum> data;

  factory Showpredictionsmodel.fromJson(Map<String, dynamic> json) => Showpredictionsmodel(
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
  Side side;
  String player;
  String type;
  Value value;
  DateTime created;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userid: json["userid"],
    contestid: json["contestid"],
    team: json["team"],
    side: sideValues.map[json["side"]],
    player: json["player"],
    type: json["type"],
    value: valueValues.map![json["value"]],
    created: DateTime.parse(json["created"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "contestid": contestid,
    "team": team,
    "side": sideValues.reverse[side],
    "player": player,
    "type": type,
    "value": valueValues.reverse[value],
    "created": created.toIso8601String(),
    "status": status,
  };
}

enum Side { BATTING, BOWLING, EXTRAS }

late final sideValues = EnumValues({
  "batting": Side.BATTING,
  "bowling": Side.BOWLING,
  "extras": Side.EXTRAS
});

enum Value { ODD, EVEN }

late final valueValues = EnumValues({
  "even": Value.EVEN,
  "odd": Value.ODD
});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}*/
