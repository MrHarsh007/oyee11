import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/models/login_model.dart';

class TApiServices{
  Future<Loginmodel> apiCallTLogin() async{

    var url = Uri.parse('http://starpaneldevelopers.com/api/login.php');
    var response = await http.post(url,body: {});
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    if(response.statusCode == 200){
      return Loginmodel.fromJson(json.decode(response.body));
    }
    else{
      print('Failed');
    }
    throw Exception("its null");
    //return TLoginApiResponse(error: data["error"],message: data["message"]);
  }
}

class TLoginApiResponse{
  bool? error;
  String? message;

  TLoginApiResponse({this.message,this.error});
}