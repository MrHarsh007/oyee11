import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';

class KYCApiServices{
  Future<KYCApiResponse> apiCallKYC(Map<String , dynamic>param) async{

    var url = Uri.parse(Constants.kycurl);
    var response = await http.post(url,body: param);
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    return KYCApiResponse(error: data["error"],message: data["message"]);
  }
}

class KYCApiResponse{
  bool? error;
  String? message;

  KYCApiResponse({this.message,this.error});
}