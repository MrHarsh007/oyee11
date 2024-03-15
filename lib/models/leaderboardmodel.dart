
import 'dart:convert';

Leadermodel leadermodelFromJson(String str) => Leadermodel.fromJson(json.decode(str));

String leadermodelToJson(Leadermodel data) => json.encode(data.toJson());

class Leadermodel {
  Leadermodel({
    required this.error,
    required this.loginUserData,
    required this.otherUserData,
  });

  bool error;
  List<UserDatum> loginUserData;
  List<UserDatum> otherUserData;

  factory Leadermodel.fromJson(Map<String, dynamic> json) => Leadermodel(
    error: json["error"],
    loginUserData: List<UserDatum>.from(json["login_user_data"].map((x) => UserDatum.fromJson(x))),
    otherUserData: List<UserDatum>.from(json["other_user_data"].map((x) => UserDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "login_user_data": List<dynamic>.from(loginUserData.map((x) => x.toJson())),
    "other_user_data": List<dynamic>.from(otherUserData.map((x) => x.toJson())),
  };
}

class UserDatum {
  UserDatum({
    required this.rank,
    required this.tokenLimit,
    required this.point,
    required this.team,
    required this.amount,
    required this.userName,
    required this.image,
  });

  String rank;
  String tokenLimit;
  String point;
  String team;
  String? amount;
  String userName;
  dynamic image;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
    rank: json["rank"],
    tokenLimit: json["tokenLimit"],
    point: json["point"],
    team: json["team"],
    amount: json["amount"] == null ? null : json["amount"],
    userName: json["user_name"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "tokenLimit": tokenLimit,
    "point": point,
    "team": team,
    "amount": amount,
    "user_name": userName,
    "image": image,
  };
}
