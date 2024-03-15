import 'dart:convert';

Userdetailsmodel userdetailsmodelFromJson(String str) => Userdetailsmodel.fromJson(json.decode(str));

String userdetailsmodelToJson(Userdetailsmodel data) => json.encode(data.toJson());

class Userdetailsmodel {
  Userdetailsmodel({
    required this.error,
    required this.data,
  });

  bool error;
  Data data;

  factory Userdetailsmodel.fromJson(Map<String, dynamic> json) => Userdetailsmodel(
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
    required this.token,
    required this.userId,
    required this.ownReferCode,
    required this.userName,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.email,
    required this.mobileNumber,
    required this.birthDate,
    required this.gender,
    required this.referCode,
    required this.password,
    required this.panName,
    required this.panNumber,
    required this.panImage,
    required this.bankImage,
    required this.bankName,
    required this.bankAccountNumber,
    required this.bankIfsc,
    required this.isVerified,
    required this.status,
    required this.createDate,
  });

  String token;
  String userId;
  String ownReferCode;
  String userName;
  dynamic firstName;
  dynamic lastName;
  String image;
  String email;
  String mobileNumber;
  dynamic birthDate;
  String gender;
  dynamic referCode;
  String password;
  dynamic panName;
  dynamic panNumber;
  dynamic panImage;
  dynamic bankImage;
  dynamic bankName;
  dynamic bankAccountNumber;
  dynamic bankIfsc;
  String isVerified;
  String status;
  DateTime createDate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    userId: json["user_id"],
    ownReferCode: json["own_refer_code"],
    userName: json["user_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    image: json["image"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
    birthDate: json["birth_date"],
    gender: json["gender"],
    referCode: json["refer_code"],
    password: json["password"],
    panName: json["pan_name"],
    panNumber: json["pan_number"],
    panImage: json["pan_image"],
    bankImage: json["bank_image"],
    bankName: json["bank_name"],
    bankAccountNumber: json["bank_account_number"],
    bankIfsc: json["bank_ifsc"],
    isVerified: json["is_verified"],
    status: json["status"],
    createDate: DateTime.parse(json["create_date"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user_id": userId,
    "own_refer_code": ownReferCode,
    "user_name": userName,
    "first_name": firstName,
    "last_name": lastName,
    "image": image,
    "email": email,
    "mobile_number": mobileNumber,
    "birth_date": birthDate,
    "gender": gender,
    "refer_code": referCode,
    "password": password,
    "pan_name": panName,
    "pan_number": panNumber,
    "pan_image": panImage,
    "bank_image": bankImage,
    "bank_name": bankName,
    "bank_account_number": bankAccountNumber,
    "bank_ifsc": bankIfsc,
    "is_verified": isVerified,
    "status": status,
    "create_date": createDate.toIso8601String(),
  };
}
