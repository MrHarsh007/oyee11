import 'package:http/http.dart' as http;
import 'dart:convert';


class ProfileApiServices{
  Future<ProfileApiResponse> apiCallpro_img(Map<String , dynamic>param) async{

    var url = Uri.parse('http://starpaneldevelopers.com/api/profile_image.php?u_e_id=43');
    var response = await http.post(url,body: param);
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    return ProfileApiResponse(error: data["error"],message: data["message"]);
  }
}

class ProfileApiResponse{
  bool? error;
  String? message;

  ProfileApiResponse({this.message,this.error});
}