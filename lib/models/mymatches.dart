import 'dart:convert';

Myjoinedmatches myjoinedmatchesFromJson(String str) => Myjoinedmatches.fromJson(json.decode(str));

String myjoinedmatchesToJson(Myjoinedmatches data) => json.encode(data.toJson());

class Myjoinedmatches {
  Myjoinedmatches({
    required this.error,
    required this.data,
  });

  bool error;
  List<Datum> data;

  factory Myjoinedmatches.fromJson(Map<String, dynamic> json) => Myjoinedmatches(
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
    required this.matchKey,
    required this.liveauthToken,
    required this.teamOne,
    required this.teamTwo,
    required this.shortnameOne,
    required this.shortnameTwo,
    required this.contestType,
    required this.totalWinningPrice,
    required this.leagueName,
    required this.leagueType,
    required this.image,
    required this.imageTwo,
    required this.status,
    required this.updateDate,
    required this.createDate,
    required this.contestId,
  });

  String id;
  String matchKey;
  String liveauthToken;
  String teamOne;
  String teamTwo;
  String shortnameOne;
  String shortnameTwo;
  String contestType;
  String totalWinningPrice;
  String leagueName;
  String leagueType;
  String image;
  String imageTwo;
  String status;
  DateTime updateDate;
  DateTime createDate;
  String contestId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    matchKey: json["match_key"],
    liveauthToken: json["liveauth_token"],
    teamOne: json["team_one"],
    teamTwo: json["team_two"],
    shortnameOne: json["shortname_one"],
    shortnameTwo: json["shortname_two"],
    contestType: json["contest_type"],
    totalWinningPrice: json["total_winning_price"],
    leagueName: json["league_name"],
    leagueType: json["league_type"],
    image: json["image"],
    status: json["status"],
    imageTwo: json["image_two"],
    updateDate: DateTime.parse(json["update_date"]),
    createDate: DateTime.parse(json["create_date"]),
    contestId: json["contestId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "match_key": matchKey,
    "liveauth_token": liveauthToken,
    "team_one": teamOne,
    "team_two": teamTwo,
    "shortname_one": shortnameOne,
    "shortname_two": shortnameTwo,
    "contest_type": contestType,
    "total_winning_price": totalWinningPrice,
    "league_name": leagueName,
    "league_type": leagueType,
    "image": image,
    "status": status,
    "image_two": imageTwo,
    "update_date": updateDate.toIso8601String(),
    "create_date": createDate.toIso8601String(),
    "contestId": contestId,
  };
}
