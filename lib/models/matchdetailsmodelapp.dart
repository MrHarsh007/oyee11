import 'dart:convert';

Matchdetailsapp matchdetailsappFromJson(String str) => Matchdetailsapp.fromJson(json.decode(str));

String matchdetailsappToJson(Matchdetailsapp data) => json.encode(data.toJson());

class Matchdetailsapp {
  Matchdetailsapp({
    required this.error,
    required this.data,
  });

  bool error;
  Data data;

  factory Matchdetailsapp.fromJson(Map<String, dynamic> json) => Matchdetailsapp(
    error: json["error"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "data": data.toJson(),
  };
}

class Data {
  Data({
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
    required this.matchDate,
    required this.updateDate,
    required this.createDate,
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
  String matchDate;
  DateTime updateDate;
  DateTime createDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    imageTwo: json["image_two"],
    matchDate: json["match_date"],
    updateDate: DateTime.parse(json["update_date"]),
    createDate: DateTime.parse(json["create_date"]),
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
    "image_two": imageTwo,
    "match_date": matchDate,
    "update_date": updateDate.toIso8601String(),
    "create_date": createDate.toIso8601String(),
  };
}
