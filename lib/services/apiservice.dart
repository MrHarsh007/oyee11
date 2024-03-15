import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices{
  Future<LoginApiResponse> apiCallLogin(Map<String , dynamic>param) async{

    var url = Uri.parse('http://starpaneldevelopers.com/api/login.php');
    var response = await http.post(url,body: param);
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    return LoginApiResponse(error: data["error"],message: data["message"],user: data["user"]);
  }
}

class LoginApiResponse{
  bool? error;
  String? message;
  Map? user;

  LoginApiResponse({this.message,this.error,this.user});
}