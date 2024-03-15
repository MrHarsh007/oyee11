import 'dart:convert';

Mycontests mycontestsFromJson(String str) => Mycontests.fromJson(json.decode(str));

String mycontestsToJson(Mycontests data) => json.encode(data.toJson());

class Mycontests {
  Mycontests({
    required this.error,
    required this.data,
  });

  bool error;
  List<Datum> data;

  factory Mycontests.fromJson(Map<String, dynamic> json) => Mycontests(
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
    required this.matchid,
    required this.prizePool,
    required this.entryFees,
    required this.discountEntryFees,
    required this.totalSpots,
    required this.decision,
    required this.maxEntry,
    required this.winningPercentage,
    required this.firstPrize,
    required this.totalUserWin,
    required this.createDate,
  });

  String id;
  String matchid;
  String prizePool;
  String entryFees;
  String discountEntryFees;
  String totalSpots;
  String decision;
  String maxEntry;
  String winningPercentage;
  String firstPrize;
  String totalUserWin;
  DateTime createDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    matchid: json["matchid"],
    prizePool: json["prize_pool"],
    entryFees: json["entry_fees"],
    discountEntryFees: json["discount_entry_fees"],
    totalSpots: json["total_spots"],
    decision: json["decision"],
    maxEntry: json["max_entry"],
    winningPercentage: json["winning_percentage"],
    firstPrize: json["first_prize"],
    totalUserWin: json["total_user_win"],
    createDate: DateTime.parse(json["create_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "matchid": matchid,
    "prize_pool": prizePool,
    "entry_fees": entryFees,
    "discount_entry_fees": discountEntryFees,
    "total_spots": totalSpots,
    "decision": decision,
    "max_entry": maxEntry,
    "winning_percentage": winningPercentage,
    "first_prize": firstPrize,
    "total_user_win": totalUserWin,
    "create_date": createDate.toIso8601String(),
  };
}
