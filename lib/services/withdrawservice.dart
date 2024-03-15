import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawApiServices{
  Future<WithdrawApiResponse> apiCallWithdraw(Map<String , dynamic>param) async{
    final sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    var url = Uri.parse(Constants.withdrawurl);
    var response = await http.post(url,body: param);
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    return WithdrawApiResponse(error: data["error"],message: data["message"]);
  }
}

class WithdrawApiResponse{
  bool? error;
  String? message;

  WithdrawApiResponse({this.message,this.error});
}