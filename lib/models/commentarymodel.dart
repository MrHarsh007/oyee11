// To parse required this JSON data, do
//
//     final commentarymodel = commentarymodelFromJson(jsonString);

import 'dart:convert';

Commentarymodel commentarymodelFromJson(String str) => Commentarymodel.fromJson(json.decode(str));

String commentarymodelToJson(Commentarymodel data) => json.encode(data.toJson());

class Commentarymodel {
  Commentarymodel({
    required this.data,
    required this.cache,
    required this.schema,
    required this.error,
    required this.httpStatusCode,
  });

  Data data;
  Cache cache;
  Schema schema;
  dynamic error;
  int httpStatusCode;

  factory Commentarymodel.fromJson(Map<String, dynamic> json) => Commentarymodel(
    data: Data.fromJson(json["data"]),
    cache: Cache.fromJson(json["cache"]),
    schema: Schema.fromJson(json["schema"]),
    error: json["error"],
    httpStatusCode: json["http_status_code"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "cache": cache.toJson(),
    "schema": schema.toJson(),
    "error": error,
    "http_status_code": httpStatusCode,
  };
}

class Cache {
  Cache({
    required this.key,
    required this.expires,
    required this.etag,
    required this.maxAge,
  });

  String key;
  double expires;
  String etag;
  int maxAge;

  factory Cache.fromJson(Map<String, dynamic> json) => Cache(
    key: json["key"],
    expires: json["expires"].toDouble(),
    etag: json["etag"],
    maxAge: json["max_age"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "expires": expires,
    "etag": etag,
    "max_age": maxAge,
  };
}

class Data {
  Data({
    required this.over,
    required this.previousOverIndex,
    required this.nextOverIndex,
    required this.previousOverKey,
    required this.nextOverKey,
  });

  Over over;
  Index previousOverIndex;
  Index? nextOverIndex;
  String previousOverKey;
  String? nextOverKey;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    over: Over.fromJson(json["over"]),
    previousOverIndex: Index.fromJson(json["previous_over_index"]),
    nextOverIndex: json["next_over_index"] == null ? null : Index.fromJson(json["next_over_index"]),
    previousOverKey: json["previous_over_key"],
    nextOverKey: json["next_over_key"] == null ? null : json["next_over_key"],
  );

  Map<String, dynamic> toJson() => {
    "over": over.toJson(),
    "previous_over_index": previousOverIndex.toJson(),
    "next_over_index": nextOverIndex == null ? null : nextOverIndex!.toJson(),
    "previous_over_key": previousOverKey,
    "next_over_key": nextOverKey == null ? null : nextOverKey,
  };
}

class Index {
  Index({
    required this.innings,
    required this.overNumber,
  });

  String innings;
  int overNumber;

  factory Index.fromJson(Map<String, dynamic> json) => Index(
    innings: json["innings"],
    overNumber: json["over_number"],
  );

  Map<String, dynamic> toJson() => {
    "innings": innings,
    "over_number": overNumber,
  };
}

class Over {
  Over({
    required this.index,
    required this.balls,
  });

  Index index;
  List<Ball> balls;

  factory Over.fromJson(Map<String, dynamic> json) => Over(
    index: Index.fromJson(json["index"]),
    balls: List<Ball>.from(json["balls"].map((x) => Ball.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "index": index.toJson(),
    "balls": List<dynamic>.from(balls.map((x) => x.toJson())),
  };
}

class Ball {
  Ball({
    required this.key,
    required this.ballType,
    required this.battingTeam,
    required this.comment,
    required this.innings,
    required this.overs,
    required this.batsman,
    required this.bowler,
    required this.teamScore,
    required this.fielders,
    required this.wicket,
    required this.nonStrikerKey,
    required this.entryTime,
  });

  String key;
  String ballType;
  String battingTeam;
  String comment;
  String innings;
  List<int> overs;
  Batsman batsman;
  Bowler bowler;
  Bowler teamScore;
  List<dynamic> fielders;
  dynamic wicket;
  String nonStrikerKey;
  double entryTime;

  factory Ball.fromJson(Map<String, dynamic> json) => Ball(
    key: json["key"],
    ballType: json["ball_type"],
    battingTeam: json["batting_team"],
    comment: json["comment"],
    innings: json["innings"],
    overs: List<int>.from(json["overs"].map((x) => x)),
    batsman: Batsman.fromJson(json["batsman"]),
    bowler: Bowler.fromJson(json["bowler"]),
    teamScore: Bowler.fromJson(json["team_score"]),
    fielders: List<dynamic>.from(json["fielders"].map((x) => x)),
    wicket: json["wicket"],
    nonStrikerKey: json["non_striker_key"],
    entryTime: json["entry_time"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "ball_type": ballType,
    "batting_team": battingTeam,
    "comment": comment,
    "innings": innings,
    "overs": List<dynamic>.from(overs.map((x) => x)),
    "batsman": batsman.toJson(),
    "bowler": bowler.toJson(),
    "team_score": teamScore.toJson(),
    "fielders": List<dynamic>.from(fielders.map((x) => x)),
    "wicket": wicket,
    "non_striker_key": nonStrikerKey,
    "entry_time": entryTime,
  };
}

class Batsman {
  Batsman({
    required this.playerKey,
    required this.ballCount,
    required this.runs,
    required this.isDotBall,
    required this.isFour,
    required this.isSix,
  });

  String playerKey;
  int ballCount;
  int runs;
  bool isDotBall;
  bool isFour;
  bool isSix;

  factory Batsman.fromJson(Map<String, dynamic> json) => Batsman(
    playerKey: json["player_key"],
    ballCount: json["ball_count"],
    runs: json["runs"],
    isDotBall: json["is_dot_ball"],
    isFour: json["is_four"],
    isSix: json["is_six"],
  );

  Map<String, dynamic> toJson() => {
    "player_key": playerKey,
    "ball_count": ballCount,
    "runs": runs,
    "is_dot_ball": isDotBall,
    "is_four": isFour,
    "is_six": isSix,
  };
}

class Bowler {
  Bowler({
    required this.playerKey,
    required this.ballCount,
    required this.runs,
    required this.extras,
    required this.isWicket,
  });

  String? playerKey;
  int ballCount;
  int runs;
  int extras;
  bool isWicket;

  factory Bowler.fromJson(Map<String, dynamic> json) => Bowler(
    playerKey: json["player_key"] == null ? null : json["player_key"].toString(),
    ballCount: json["ball_count"],
    runs: json["runs"],
    extras: json["extras"],
    isWicket: json["is_wicket"],
  );

  Map<String, dynamic> toJson() => {
    "player_key": playerKey == null ? null : playerKey,
    "ball_count": ballCount,
    "runs": runs,
    "extras": extras,
    "is_wicket": isWicket,
  };
}

class Schema {
  Schema({
    required this.majorVersion,
    required this.minorVersion,
  });

  String majorVersion;
  String minorVersion;

  factory Schema.fromJson(Map<String, dynamic> json) => Schema(
    majorVersion: json["major_version"],
    minorVersion: json["minor_version"],
  );

  Map<String, dynamic> toJson() => {
    "major_version": majorVersion,
    "minor_version": minorVersion,
  };
}
