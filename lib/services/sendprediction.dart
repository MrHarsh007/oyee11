import 'package:http/http.dart' as http;
import 'dart:convert';

class SendpApiServices{
  Future<SendpApiResponse> apiCallSendp(Map<String , dynamic>param) async{

    var url = Uri.parse('http://starpaneldevelopers.com/api/register.php');
    var response = await http.post(url,body: param);
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    return SendpApiResponse(error: data["error"],message: data["message"]);
  }
}

class SendpApiResponse{
  bool? error;
  String? message;

  SendpApiResponse({this.message,this.error});
}