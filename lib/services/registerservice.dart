import 'package:http/http.dart' as http;
import 'dart:convert';

class RApiServices{
  Future<RegisterApiResponse> apiCallRegister(Map<String , dynamic>param) async{

    var url = Uri.parse('http://starpaneldevelopers.com/api/register.php');
    var response = await http.post(url,body: param);
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    return RegisterApiResponse(error: data["error"],message: data["message"]);
  }
}

class RegisterApiResponse{
  bool? error;
  String? message;

  RegisterApiResponse({this.message,this.error});
}