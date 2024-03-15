// To parse required this JSON data, do
//
//     final matchdetailsmodel = matchdetailsmodelFromJson(jsonString);

import 'dart:convert';

Matchdetailsmodel matchdetailsmodelFromJson(String str) => Matchdetailsmodel.fromJson(json.decode(str));

String matchdetailsmodelToJson(Matchdetailsmodel data) => json.encode(data.toJson());

class Matchdetailsmodel {
  Matchdetailsmodel({
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

  factory Matchdetailsmodel.fromJson(Map<String, dynamic> json) => Matchdetailsmodel(
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
    required this.key,
    required this.name,
    required this.shortName,
    required this.subTitle,
    required this.teams,
    required this.startAt,
    required this.venue,
    required this.tournament,
    required this.association,
    required this.metricGroup,
    required this.status,
    required this.winner,
    required this.messages,
    required this.gender,
    required this.sport,
    required this.format,
    required this.title,
    required this.playStatus,
    required this.startAtLocal,
    required this.toss,
    required this.play,
    required this.players,
    required this.notes,
    required this.dataReview,
    required this.squad,
    required this.estimatedEndDate,
    required this.completedDateApproximate,
    required this.umpires,
  });

  String key;
  String name;
  String shortName;
  String subTitle;
  Teams teams;
  double startAt;
  Venue venue;
  Tournament tournament;
  Association association;
  String metricGroup;
  String status;
  Winner? winner;
  List<dynamic> messages;
  Gender? gender;
  String sport;
  String format;
  String title;
  String playStatus;
  double startAtLocal;
  Toss? toss;
  Play? play;
  Map<String, PlayerValue> players;
  List<dynamic> notes;
  DataReview dataReview;
  Squad? squad;
  String? estimatedEndDate;
  String? completedDateApproximate;
  Umpires umpires;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    key: json["key"],
    name: json["name"],
    shortName: json["short_name"],
    subTitle: json["sub_title"],
    teams: Teams.fromJson(json["teams"]),
    startAt: json["start_at"],
    venue: Venue.fromJson(json["venue"]),
    tournament: Tournament.fromJson(json["tournament"]),
    association: Association.fromJson(json["association"]),
    metricGroup: json["metric_group"],
    status: json["status"],
    winner: winnerValues.map[json["winner"]],
    messages: List<dynamic>.from(json["messages"].map((x) => x)),
    gender: genderValues.map[json["gender"]],
    sport: json["sport"],
    format: json["format"],
    title: json["title"],
    playStatus: json["play_status"],
    startAtLocal: json["start_at_local"],
    toss: json["toss"] == null ? null : Toss.fromJson(json["toss"]),
    play: json["play"] == null ? null : Play.fromJson(json["play"]),
    players: Map.from(json["players"]).map((k, v) => MapEntry<String, PlayerValue>(k, PlayerValue.fromJson(v))),
    notes: List<dynamic>.from(json["notes"].map((x) => x)),
    dataReview: DataReview.fromJson(json["data_review"]),
    squad: json["squad"] == null ? null : Squad.fromJson(json["squad"]),
    estimatedEndDate: json["estimated_end_date"].toString(),
    completedDateApproximate: json["completed_date_approximate"].toString(),
    umpires: Umpires.fromJson(json["umpires"]),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
    "short_name": shortName,
    "sub_title": subTitle,
    "teams": teams.toJson(),
    "start_at": startAt,
    "venue": venue.toJson(),
    "tournament": tournament.toJson(),
    "association": association.toJson(),
    "metric_group": metricGroup,
    "status": status,
    "winner": winnerValues.reverse[winner],
    "messages": List<dynamic>.from(messages.map((x) => x)),
    "gender": genderValues.reverse[gender],
    "sport": sport,
    "format": format,
    "title": title,
    "play_status": playStatus,
    "start_at_local": startAtLocal,
    "toss": toss == null ? null : toss!.toJson(),
    "play": play == null ? null : play!.toJson(),
    "players": Map.from(players).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "notes": List<dynamic>.from(notes.map((x) => x)),
    "data_review": dataReview.toJson(),
    "squad": squad == null ? null : squad!.toJson(),
    "estimated_end_date": estimatedEndDate,
    "completed_date_approximate": completedDateApproximate,
    "umpires": umpires.toJson(),
  };
}

class Association {
  Association({
    required this.key,
    required this.code,
    required this.name,
    required this.country,
    required this.parent,
  });

  String key;
  String code;
  String name;
  dynamic country;
  dynamic parent;

  factory Association.fromJson(Map<String, dynamic> json) => Association(
    key: json["key"],
    code: json["code"],
    name: json["name"],
    country: json["country"],
    parent: json["parent"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "code": code,
    "name": name,
    "country": country,
    "parent": parent,
  };
}

class DataReview {
  DataReview({
    required this.schedule,
    required this.venue,
    required this.result,
    required this.pom,
    required this.score,
    required this.players,
    required this.playingXi,
    required this.scoreReviewedBallIndex,
    required this.teamA,
    required this.teamB,
    required this.goodToClose,
    required this.note,
  });

  bool schedule;
  bool venue;
  bool result;
  bool pom;
  bool score;
  bool players;
  bool playingXi;
  List<dynamic>? scoreReviewedBallIndex;
  bool teamA;
  bool teamB;
  bool goodToClose;
  dynamic note;

  factory DataReview.fromJson(Map<String, dynamic> json) => DataReview(
    schedule: json["schedule"],
    venue: json["venue"],
    result: json["result"],
    pom: json["pom"],
    score: json["score"],
    players: json["players"],
    playingXi: json["playing_xi"],
    scoreReviewedBallIndex: json["score_reviewed_ball_index"] == null ? null : List<dynamic>.from(json["score_reviewed_ball_index"].map((x) => x)),
    teamA: json["team_a"],
    teamB: json["team_b"],
    goodToClose: json["good_to_close"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "schedule": schedule,
    "venue": venue,
    "result": result,
    "pom": pom,
    "score": score,
    "players": players,
    "playing_xi": playingXi,
    "score_reviewed_ball_index": scoreReviewedBallIndex == null ? null : List<dynamic>.from(scoreReviewedBallIndex!.map((x) => x)),
    "team_a": teamA,
    "team_b": teamB,
    "good_to_close": goodToClose,
    "note": note,
  };
}

enum InningsOrder { B_1, A_1 }

final inningsOrderValues = EnumValues({
  "a_1": InningsOrder.A_1,
  "b_1": InningsOrder.B_1
});

enum Gender { MALE }

final genderValues = EnumValues({
  "male": Gender.MALE
});

class Play {
  Play({
    required this.firstBatting,
    required this.dayNumber,
    required this.oversPerInnings,
    required this.reducedOvers,
    required this.target,
    required this.result,
    required this.inningsOrder,
    required this.innings,
    required this.live,
    required this.relatedBalls,
  });

  Winner? firstBatting;
  int dayNumber;
  List<int> oversPerInnings;
  dynamic reducedOvers;
  Target? target;
  Result? result;
  List<InningsOrder> inningsOrder;
  Innings innings;
  dynamic live;
  Map<String, RelatedBall> relatedBalls;

  factory Play.fromJson(Map<String, dynamic> json) => Play(
    firstBatting: winnerValues.map[json["first_batting"]],
    dayNumber: json["day_number"],
    oversPerInnings: List<int>.from(json["overs_per_innings"].map((x) => x)),
    reducedOvers: json["reduced_overs"],
    target: json["target"] == null ? null : Target.fromJson(json["target"]),
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
    inningsOrder: List<InningsOrder>.from(json["innings_order"].map((x) => inningsOrderValues.map[x])),
    innings: Innings.fromJson(json["innings"]),
    live: json["live"],
    relatedBalls: Map.from(json["related_balls"]).map((k, v) => MapEntry<String, RelatedBall>(k, RelatedBall.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "first_batting": winnerValues.reverse[firstBatting],
    "day_number": dayNumber,
    "overs_per_innings": List<dynamic>.from(oversPerInnings.map((x) => x)),
    "reduced_overs": reducedOvers,
    "target": target == null ? null : target!.toJson(),
    "result": result == null ? null : result!.toJson(),
    "innings_order": List<dynamic>.from(inningsOrder.map((x) => inningsOrderValues.reverse[x])),
    "innings": innings.toJson(),
    "live": live,
    "related_balls": Map.from(relatedBalls).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

enum Winner { B, A }

final winnerValues = EnumValues({
  "a": Winner.A,
  "b": Winner.B
});

class Innings {
  Innings({
    required this.b1,
    required this.a1,
  });

  A1 b1;
  A1 a1;

  factory Innings.fromJson(Map<String, dynamic> json) => Innings(
    b1: A1.fromJson(json["b_1"]),
    a1: A1.fromJson(json["a_1"]),
  );

  Map<String, dynamic> toJson() => {
    "b_1": b1.toJson(),
    "a_1": a1.toJson(),
  };
}

class A1 {
  A1({
    required this.index,
    required this.overs,
    required this.isCompleted,
    required this.scoreStr,
    required this.score,
    required this.wickets,
    required this.extraRuns,
    required this.ballsBreakup,
    required this.battingOrder,
    required this.bowlingOrder,
    required this.wicketOrder,
    required this.partnerships,
  });

  InningsOrder? index;
  List<int> overs;
  bool isCompleted;
  String scoreStr;
  PlayerAScoreClass score;
  int wickets;
  ExtraRuns extraRuns;
  A1BallsBreakup ballsBreakup;
  List<String> battingOrder;
  List<String> bowlingOrder;
  List<String> wicketOrder;
  List<Partnership> partnerships;

  factory A1.fromJson(Map<String, dynamic> json) => A1(
    index: inningsOrderValues.map[json["index"]],
    overs: List<int>.from(json["overs"].map((x) => x)),
    isCompleted: json["is_completed"],
    scoreStr: json["score_str"],
    score: PlayerAScoreClass.fromJson(json["score"]),
    wickets: json["wickets"],
    extraRuns: ExtraRuns.fromJson(json["extra_runs"]),
    ballsBreakup: A1BallsBreakup.fromJson(json["balls_breakup"]),
    battingOrder: List<String>.from(json["batting_order"].map((x) => x)),
    bowlingOrder: List<String>.from(json["bowling_order"].map((x) => x)),
    wicketOrder: List<String>.from(json["wicket_order"].map((x) => x)),
    partnerships: List<Partnership>.from(json["partnerships"].map((x) => Partnership.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "index": inningsOrderValues.reverse[index],
    "overs": List<dynamic>.from(overs.map((x) => x)),
    "is_completed": isCompleted,
    "score_str": scoreStr,
    "score": score.toJson(),
    "wickets": wickets,
    "extra_runs": extraRuns.toJson(),
    "balls_breakup": ballsBreakup.toJson(),
    "batting_order": List<dynamic>.from(battingOrder.map((x) => x)),
    "bowling_order": List<dynamic>.from(bowlingOrder.map((x) => x)),
    "wicket_order": List<dynamic>.from(wicketOrder.map((x) => x)),
    "partnerships": List<dynamic>.from(partnerships.map((x) => x.toJson())),
  };
}

class A1BallsBreakup {
  A1BallsBreakup({
    required this.balls,
    required this.dotBalls,
    required this.wides,
    required this.noBalls,
  });

  int balls;
  int dotBalls;
  int wides;
  int noBalls;

  factory A1BallsBreakup.fromJson(Map<String, dynamic> json) => A1BallsBreakup(
    balls: json["balls"],
    dotBalls: json["dot_balls"],
    wides: json["wides"],
    noBalls: json["no_balls"],
  );

  Map<String, dynamic> toJson() => {
    "balls": balls,
    "dot_balls": dotBalls,
    "wides": wides,
    "no_balls": noBalls,
  };
}

class ExtraRuns {
  ExtraRuns({
    required this.extra,
    required this.bye,
    required this.legBye,
    required this.wide,
    required this.noBall,
    required this.penalty,
  });

  int extra;
  int bye;
  int legBye;
  int wide;
  int noBall;
  dynamic penalty;

  factory ExtraRuns.fromJson(Map<String, dynamic> json) => ExtraRuns(
    extra: json["extra"],
    bye: json["bye"],
    legBye: json["leg_bye"],
    wide: json["wide"],
    noBall: json["no_ball"],
    penalty: json["penalty"],
  );

  Map<String, dynamic> toJson() => {
    "extra": extra,
    "bye": bye,
    "leg_bye": legBye,
    "wide": wide,
    "no_ball": noBall,
    "penalty": penalty,
  };
}

class Partnership {
  Partnership({
    required this.beginOvers,
    required this.endOvers,
    required this.playerAKey,
    required this.playerAScore,
    required this.playerBKey,
    required this.playerBScore,
    required this.score,
    required this.isCompleted,
  });

  List<int> beginOvers;
  List<int> endOvers;
  String playerAKey;
  PlayerAScoreClass playerAScore;
  String playerBKey;
  PlayerAScoreClass playerBScore;
  PlayerAScoreClass score;
  bool isCompleted;

  factory Partnership.fromJson(Map<String, dynamic> json) => Partnership(
    beginOvers: List<int>.from(json["begin_overs"].map((x) => x)),
    endOvers: List<int>.from(json["end_overs"].map((x) => x)),
    playerAKey: json["player_a_key"],
    playerAScore: PlayerAScoreClass.fromJson(json["player_a_score"]),
    playerBKey: json["player_b_key"],
    playerBScore: PlayerAScoreClass.fromJson(json["player_b_score"]),
    score: PlayerAScoreClass.fromJson(json["score"]),
    isCompleted: json["is_completed"],
  );

  Map<String, dynamic> toJson() => {
    "begin_overs": List<dynamic>.from(beginOvers.map((x) => x)),
    "end_overs": List<dynamic>.from(endOvers.map((x) => x)),
    "player_a_key": playerAKey,
    "player_a_score": playerAScore.toJson(),
    "player_b_key": playerBKey,
    "player_b_score": playerBScore.toJson(),
    "score": score.toJson(),
    "is_completed": isCompleted,
  };
}

class PlayerAScoreClass {
  PlayerAScoreClass({
    required this.runs,
    required this.balls,
    required this.fours,
    required this.sixes,
    required this.runRate,
    required this.dotBalls,
    required this.strikeRate,
  });

  int runs;
  int balls;
  int fours;
  int sixes;
  String? runRate;
  String? dotBalls;
  String? strikeRate;

  factory PlayerAScoreClass.fromJson(Map<String, dynamic> json) => PlayerAScoreClass(
    runs: json["runs"],
    balls: json["balls"],
    fours: json["fours"],
    sixes: json["sixes"],
    runRate: json["run_rate"] == null ? null : json["run_rate"].toString(),
    dotBalls: json["dot_balls"] == null ? null : json["dot_balls"].toString(),
    strikeRate: json["strike_rate"] == null ? null : json["strike_rate"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "runs": runs,
    "balls": balls,
    "fours": fours,
    "sixes": sixes,
    "run_rate": runRate == null ? null : runRate.toString(),
    "dot_balls": dotBalls == null ? null : dotBalls.toString(),
    "strike_rate": strikeRate == null ? null : strikeRate.toString(),
  };
}

class RelatedBall {
  RelatedBall({
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
  BallType? ballType;
  Winner? battingTeam;
  String comment;
  InningsOrder? innings;
  List<int> overs;
  Batsman batsman;
  Bowler bowler;
  Bowler teamScore;
  List<Fielder> fielders;
  Wicket? wicket;
  String nonStrikerKey;
  double entryTime;

  factory RelatedBall.fromJson(Map<String, dynamic> json) => RelatedBall(
    key: json["key"],
    ballType: ballTypeValues.map[json["ball_type"]],
    battingTeam: winnerValues.map[json["batting_team"]],
    comment: json["comment"],
    innings: inningsOrderValues.map[json["innings"]],
    overs: List<int>.from(json["overs"].map((x) => x)),
    batsman: Batsman.fromJson(json["batsman"]),
    bowler: Bowler.fromJson(json["bowler"]),
    teamScore: Bowler.fromJson(json["team_score"]),
    fielders: List<Fielder>.from(json["fielders"].map((x) => Fielder.fromJson(x))),
    wicket: json["wicket"] == null ? null : Wicket.fromJson(json["wicket"]),
    nonStrikerKey: json["non_striker_key"],
    entryTime: json["entry_time"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "ball_type": ballTypeValues.reverse[ballType],
    "batting_team": winnerValues.reverse[battingTeam],
    "comment": comment,
    "innings": inningsOrderValues.reverse[innings],
    "overs": List<dynamic>.from(overs.map((x) => x)),
    "batsman": batsman.toJson(),
    "bowler": bowler.toJson(),
    "team_score": teamScore.toJson(),
    "fielders": List<dynamic>.from(fielders.map((x) => x.toJson())),
    "wicket": wicket == null ? null : wicket!.toJson(),
    "non_striker_key": nonStrikerKey,
    "entry_time": entryTime,
  };
}

enum BallType { NORMAL, WIDE }

final ballTypeValues = EnumValues({
  "normal": BallType.NORMAL,
  "wide": BallType.WIDE
});

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

class Fielder {
  Fielder({
    required this.playerKey,
    required this.isRunOut,
    required this.isStumps,
    required this.isCatch,
    required this.isAssists,
  });

  String playerKey;
  bool isRunOut;
  bool isStumps;
  bool isCatch;
  bool isAssists;

  factory Fielder.fromJson(Map<String, dynamic> json) => Fielder(
    playerKey: json["player_key"],
    isRunOut: json["is_run_out"],
    isStumps: json["is_stumps"],
    isCatch: json["is_catch"],
    isAssists: json["is_assists"],
  );

  Map<String, dynamic> toJson() => {
    "player_key": playerKey,
    "is_run_out": isRunOut,
    "is_stumps": isStumps,
    "is_catch": isCatch,
    "is_assists": isAssists,
  };
}

class Wicket {
  Wicket({
    required this.playerKey,
    required this.wicketType,
  });

  String playerKey;
  String wicketType;

  factory Wicket.fromJson(Map<String, dynamic> json) => Wicket(
    playerKey: json["player_key"],
    wicketType: json["wicket_type"],
  );

  Map<String, dynamic> toJson() => {
    "player_key": playerKey,
    "wicket_type": wicketType,
  };
}

class Result {
  Result({
    required this.pom,
    required this.winner,
    required this.resultType,
    required this.msg,
  });

  List<String>? pom;
  Winner? winner;
  String? resultType;
  String? msg;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    pom: json["pom"] == null ? null : List<String>.from(json["pom"].map((x) => x)).toList(),
    winner: winnerValues.map[json["winner"].toString()],
    resultType: json["result_type"].toString(),
    msg: json["msg"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "pom": pom == null ? null : List<dynamic>.from(pom!.map((x) => x)),
    "winner": winnerValues.reverse[winner],
    "result_type": resultType,
    "msg": msg,
  };
}

class Target {
  Target({
    required this.balls,
    required this.runs,
    required this.dlApplied,
  });

  int balls;
  int runs;
  bool dlApplied;

  factory Target.fromJson(Map<String, dynamic> json) => Target(
    balls: json["balls"],
    runs: json["runs"],
    dlApplied: json["dl_applied"],
  );

  Map<String, dynamic> toJson() => {
    "balls": balls,
    "runs": runs,
    "dl_applied": dlApplied,
  };
}

class PlayerValue {
  PlayerValue({
    required this.player,
    required this.score,
  });

  PlayerPlayer player;
  PlayerScore score;

  factory PlayerValue.fromJson(Map<String, dynamic> json) => PlayerValue(
    player: PlayerPlayer.fromJson(json["player"]),
    score: PlayerScore.fromJson(json["score"]),
  );

  Map<String, dynamic> toJson() => {
    "player": player.toJson(),
    "score": score.toJson(),
  };
}

class PlayerPlayer {
  PlayerPlayer({
    required this.key,
    required this.name,
    required this.jerseyName,
    required this.legalName,
    required this.gender,
    required this.nationality,
    required this.dateOfBirth,
    required this.seasonalRole,
    required this.roles,
    required this.battingStyle,
    required this.bowlingStyle,
    required this.skills,
  });

  String key;
  String name;
  String jerseyName;
  String legalName;
  Gender? gender;
  Country? nationality;
  dynamic dateOfBirth;
  Role? seasonalRole;
  List<Role> roles;
  BattingStyle? battingStyle;
  BowlingStyle? bowlingStyle;
  List<Elected> skills;

  factory PlayerPlayer.fromJson(Map<String, dynamic> json) => PlayerPlayer(
    key: json["key"],
    name: json["name"],
    jerseyName: json["jersey_name"],
    legalName: json["legal_name"],
    gender: genderValues.map[json["gender"]],
    nationality: json["nationality"] == null ? null : Country.fromJson(json["nationality"]),
    dateOfBirth: json["date_of_birth"],
    seasonalRole: roleValues.map[json["seasonal_role"]],
    roles: List<Role>.from(json["roles"].map((x) => roleValues.map[x])),
    battingStyle: battingStyleValues.map[json["batting_style"]],
    bowlingStyle: json["bowling_style"] == null ? null : BowlingStyle.fromJson(json["bowling_style"]),
    skills: List<Elected>.from(json["skills"].map((x) => electedValues.map[x])),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
    "jersey_name": jerseyName,
    "legal_name": legalName,
    "gender": genderValues.reverse[gender],
    "nationality": nationality == null ? null : nationality!.toJson(),
    "date_of_birth": dateOfBirth,
    "seasonal_role": roleValues.reverse[seasonalRole],
    "roles": List<dynamic>.from(roles.map((x) => roleValues.reverse[x])),
    "batting_style": battingStyleValues.reverse[battingStyle],
    "bowling_style": bowlingStyle == null ? null : bowlingStyle!.toJson(),
    "skills": List<dynamic>.from(skills.map((x) => electedValues.reverse[x])),
  };
}

enum BattingStyle { LEFT_HAND, RIGHT_HAND }

final battingStyleValues = EnumValues({
  "left_hand": BattingStyle.LEFT_HAND,
  "right_hand": BattingStyle.RIGHT_HAND
});

class BowlingStyle {
  BowlingStyle({
    required this.arm,
    required this.pace,
    required this.bowlingType,
  });

  Arm? arm;
  Pace? pace;
  String? bowlingType;

  factory BowlingStyle.fromJson(Map<String, dynamic> json) => BowlingStyle(
    arm: armValues.map[json["arm"]],
    pace: paceValues.map[json["pace"]],
    bowlingType: json["bowling_type"] == null ? null : json["bowling_type"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "arm": armValues.reverse[arm],
    "pace": paceValues.reverse[pace],
    "bowling_type": bowlingType == null ? null : bowlingType,
  };
}

enum Arm { RIGHT_ARM, LEFT_ARM }

final armValues = EnumValues({
  "left_arm": Arm.LEFT_ARM,
  "right_arm": Arm.RIGHT_ARM
});

enum Pace { SLOW, MEDIUM, FAST, MEDIUM_FAST, FAST_MEDIUM }

final paceValues = EnumValues({
  "fast": Pace.FAST,
  "fast_medium": Pace.FAST_MEDIUM,
  "medium": Pace.MEDIUM,
  "medium_fast": Pace.MEDIUM_FAST,
  "slow": Pace.SLOW
});

class Country {
  Country({
    required this.shortCode,
    required this.code,
    required this.name,
    required this.officialName,
    required this.isRegion,
  });

  ShortCode? shortCode;
  Code? code;
  Name? name;
  OfficialName? officialName;
  bool isRegion;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    shortCode: shortCodeValues.map[json["short_code"]],
    code: codeValues.map[json["code"]],
    name: nameValues.map[json["name"]],
    officialName: officialNameValues.map[json["official_name"]],
    isRegion: json["is_region"],
  );

  Map<String, dynamic> toJson() => {
    "short_code": shortCodeValues.reverse[shortCode],
    "code": codeValues.reverse[code],
    "name": nameValues.reverse[name],
    "official_name": officialNameValues.reverse[officialName],
    "is_region": isRegion,
  };
}

enum Code { BGD, AFG }

final codeValues = EnumValues({
  "AFG": Code.AFG,
  "BGD": Code.BGD
});

enum Name { BANGLADESH, AFGHANISTAN }

final nameValues = EnumValues({
  "Afghanistan": Name.AFGHANISTAN,
  "Bangladesh": Name.BANGLADESH
});

enum OfficialName { PEOPLE_S_REPUBLIC_OF_BANGLADESH, ISLAMIC_REPUBLIC_OF_AFGHANISTAN }

final officialNameValues = EnumValues({
  "Islamic Republic of Afghanistan": OfficialName.ISLAMIC_REPUBLIC_OF_AFGHANISTAN,
  "People's Republic of Bangladesh": OfficialName.PEOPLE_S_REPUBLIC_OF_BANGLADESH
});

enum ShortCode { BD, AF }

final shortCodeValues = EnumValues({
  "AF": ShortCode.AF,
  "BD": ShortCode.BD
});

enum Role { BATSMAN, ALL_ROUNDER, BOWLER, KEEPER }

final roleValues = EnumValues({
  "all_rounder": Role.ALL_ROUNDER,
  "batsman": Role.BATSMAN,
  "bowler": Role.BOWLER,
  "keeper": Role.KEEPER
});

enum Elected { BOWL, BAT, KEEP }

final electedValues = EnumValues({
  "bat": Elected.BAT,
  "bowl": Elected.BOWL,
  "keep": Elected.KEEP
});

class PlayerScore {
  PlayerScore({
    required this.the1,
  });

  The1? the1;

  factory PlayerScore.fromJson(Map<String, dynamic> json) => PlayerScore(
    the1: json["1"] == null ? null : The1.fromJson(json["1"]),
  );

  Map<String, dynamic> toJson() => {
    "1": the1 == null ? null : the1!.toJson(),
  };
}

class The1 {
  The1({
    required this.batting,
    required this.bowling,
    required this.fielding,
  });

  Batting? batting;
  Bowling? bowling;
  Fielding? fielding;

  factory The1.fromJson(Map<String, dynamic> json) => The1(
    batting: json["batting"] == null ? null : Batting.fromJson(json["batting"]),
    bowling: json["bowling"] == null ? null : Bowling.fromJson(json["bowling"]),
    fielding: json["fielding"] == null ? null : Fielding.fromJson(json["fielding"]),
  );

  Map<String, dynamic> toJson() => {
    "batting": batting == null ? null : batting!.toJson(),
    "bowling": bowling == null ? null : bowling!.toJson(),
    "fielding": fielding == null ? null : fielding!.toJson(),
  };
}

class Batting {
  Batting({
    required this.score,
    required this.dismissal,
  });

  PlayerAScoreClass score;
  Dismissal? dismissal;

  factory Batting.fromJson(Map<String, dynamic> json) => Batting(
    score: PlayerAScoreClass.fromJson(json["score"]),
    dismissal: json["dismissal"] == null ? null : Dismissal.fromJson(json["dismissal"]),
  );

  Map<String, dynamic> toJson() => {
    "score": score.toJson(),
    "dismissal": dismissal == null ? null : dismissal!.toJson(),
  };
}

class Dismissal {
  Dismissal({
    required this.overs,
    required this.teamRuns,
    required this.wicketNumber,
    required this.msg,
    required this.ballKey,
  });

  List<int> overs;
  int teamRuns;
  int wicketNumber;
  String msg;
  String ballKey;

  factory Dismissal.fromJson(Map<String, dynamic> json) => Dismissal(
    overs: List<int>.from(json["overs"].map((x) => x)),
    teamRuns: json["team_runs"],
    wicketNumber: json["wicket_number"],
    msg: json["msg"],
    ballKey: json["ball_key"],
  );

  Map<String, dynamic> toJson() => {
    "overs": List<dynamic>.from(overs.map((x) => x)),
    "team_runs": teamRuns,
    "wicket_number": wicketNumber,
    "msg": msg,
    "ball_key": ballKey,
  };
}

class Bowling {
  Bowling({
    required this.score,
  });

  BowlingScore score;

  factory Bowling.fromJson(Map<String, dynamic> json) => Bowling(
    score: BowlingScore.fromJson(json["score"]),
  );

  Map<String, dynamic> toJson() => {
    "score": score.toJson(),
  };
}

class BowlingScore {
  BowlingScore({
    required this.balls,
    required this.runs,
    required this.economy,
    required this.extras,
    required this.wickets,
    required this.maidenOvers,
    required this.overs,
    required this.ballsBreakup,
  });

  int balls;
  int runs;
  double economy;
  int extras;
  int wickets;
  int maidenOvers;
  List<int> overs;
  ScoreBallsBreakup ballsBreakup;

  factory BowlingScore.fromJson(Map<String, dynamic> json) => BowlingScore(
    balls: json["balls"],
    runs: json["runs"],
    economy: json["economy"].toDouble(),
    extras: json["extras"],
    wickets: json["wickets"],
    maidenOvers: json["maiden_overs"],
    overs: List<int>.from(json["overs"].map((x) => x)),
    ballsBreakup: ScoreBallsBreakup.fromJson(json["balls_breakup"]),
  );

  Map<String, dynamic> toJson() => {
    "balls": balls,
    "runs": runs,
    "economy": economy,
    "extras": extras,
    "wickets": wickets,
    "maiden_overs": maidenOvers,
    "overs": List<dynamic>.from(overs.map((x) => x)),
    "balls_breakup": ballsBreakup.toJson(),
  };
}

class ScoreBallsBreakup {
  ScoreBallsBreakup({
    required this.dotBalls,
    required this.wides,
    required this.noBalls,
    required this.fours,
    required this.sixes,
  });

  int dotBalls;
  int wides;
  int noBalls;
  int fours;
  int sixes;

  factory ScoreBallsBreakup.fromJson(Map<String, dynamic> json) => ScoreBallsBreakup(
    dotBalls: json["dot_balls"],
    wides: json["wides"],
    noBalls: json["no_balls"],
    fours: json["fours"],
    sixes: json["sixes"],
  );

  Map<String, dynamic> toJson() => {
    "dot_balls": dotBalls,
    "wides": wides,
    "no_balls": noBalls,
    "fours": fours,
    "sixes": sixes,
  };
}

class Fielding {
  Fielding({
    required this.catches,
    required this.stumpings,
    required this.runouts,
  });

  int catches;
  int stumpings;
  int runouts;

  factory Fielding.fromJson(Map<String, dynamic> json) => Fielding(
    catches: json["catches"],
    stumpings: json["stumpings"],
    runouts: json["runouts"],
  );

  Map<String, dynamic> toJson() => {
    "catches": catches,
    "stumpings": stumpings,
    "runouts": runouts,
  };
}

class Squad {
  Squad({
    required this.a,
    required this.b,
  });

  SquadA a;
  SquadA b;

  factory Squad.fromJson(Map<String, dynamic> json) => Squad(
    a: SquadA.fromJson(json["a"]),
    b: SquadA.fromJson(json["b"]),
  );

  Map<String, dynamic> toJson() => {
    "a": a.toJson(),
    "b": b.toJson(),
  };
}

class SquadA {
  SquadA({
    required this.playerKeys,
    required this.captain,
    required this.keeper,
    required this.playingXi,
  });

  List<String> playerKeys;
  String? captain;
  String? keeper;
  List<String> playingXi;

  factory SquadA.fromJson(Map<String, dynamic> json) => SquadA(
    playerKeys: List<String>.from(json["player_keys"].map((x) => x)),
    captain: json["captain"].toString(),
    keeper: json["keeper"].toString(),
    playingXi: List<String>.from(json["playing_xi"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "player_keys": List<dynamic>.from(playerKeys.map((x) => x)),
    "captain": captain,
    "keeper": keeper,
    "playing_xi": List<dynamic>.from(playingXi.map((x) => x)),
  };
}

class Teams {
  Teams({
    required this.a,
    required this.b,
  });

  TeamsA? a;
  TeamsA? b;

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
    a: json["a"] == null ? null : TeamsA.fromJson(json["a"]),
    b: json["b"] == null ? null : TeamsA.fromJson(json["b"]),
  );

  Map<String, dynamic> toJson() => {
    "a": a == null ? null : a!.toJson(),
    "b": b == null? null : b!.toJson(),
  };
}

class TeamsA {
  TeamsA({
    required this.key,
    required this.code,
    required this.name,
  });

  String key;
  String code;
  String name;

  factory TeamsA.fromJson(Map<String, dynamic> json) => TeamsA(
    key: json["key"],
    code: json["code"],
    name: nameValues.map[json["name"]].toString(),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "code": code,
    "name": nameValues.reverse[name],
  };
}

class Toss {
  Toss({
    required this.called,
    required this.winner,
    required this.elected,
  });

  Winner? called;
  Winner? winner;
  Elected? elected;

  factory Toss.fromJson(Map<String, dynamic> json) => Toss(
    called: winnerValues.map[json["called"].toString()],
    winner: winnerValues.map[json["winner"].toString()],
    elected: electedValues.map[json["elected"].toString()],
  );

  Map<String, dynamic> toJson() => {
    "called": winnerValues.reverse[called],
    "winner": winnerValues.reverse[winner],
    "elected": electedValues.reverse[elected],
  };
}

class Tournament {
  Tournament({
    required this.key,
    required this.name,
    required this.shortName,
  });

  String key;
  String name;
  String shortName;

  factory Tournament.fromJson(Map<String, dynamic> json) => Tournament(
    key: json["key"],
    name: json["name"],
    shortName: json["short_name"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
    "short_name": shortName,
  };
}

class Umpires {
  Umpires({
    required this.matchUmpires,
    required this.tvUmpires,
    required this.reserveUmpires,
    required this.matchReferee,
  });

  dynamic matchUmpires;
  dynamic tvUmpires;
  dynamic reserveUmpires;
  dynamic matchReferee;

  factory Umpires.fromJson(Map<String, dynamic> json) => Umpires(
    matchUmpires: json["match_umpires"],
    tvUmpires: json["tv_umpires"],
    reserveUmpires: json["reserve_umpires"],
    matchReferee: json["match_referee"],
  );

  Map<String, dynamic> toJson() => {
    "match_umpires": matchUmpires,
    "tv_umpires": tvUmpires,
    "reserve_umpires": reserveUmpires,
    "match_referee": matchReferee,
  };
}

class Venue {
  Venue({
    required this.key,
    required this.name,
    required this.city,
    required this.country,
  });

  String key;
  String name;
  String city;
  Country country;

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
    key: json["key"],
    name: json["name"],
    city: json["city"],
    country: Country.fromJson(json["country"]),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
    "city": city,
    "country": country.toJson(),
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    return reverseMap;
  }
}
