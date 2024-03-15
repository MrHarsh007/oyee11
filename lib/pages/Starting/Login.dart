import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oyee11/Widgets/backgroundauth.dart';
import 'package:oyee11/Widgets/bottom_navbar.dart';
import 'package:oyee11/Widgets/rounded_input_field.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/models/login_model.dart';
import 'package:oyee11/pages/Starting/Register.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? message;

  Future<Loginmodel> apiCallTLogin() async {
    var url = Uri.parse(Constants.loginurl);
    var response = await http.post(url, body: {
      "email": emailController.text,
      "password": passController.text,
    });
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Loginmodel.fromJson(json.decode(response.body));
    } else {
      print('Failed');
    }
    throw Exception("its null");
    //return TLoginApiResponse(error: data["error"],message: data["message"]);
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  /*callTestLoginApi(){
    final service = TApiServices();

    service.apiCallTLogin({
      "email": emailController.text,
      "password": passController.text,
    },).then((value){
      if(value.error != false){
        setState(() {
          Constants.islogedin = false;
        });
        Fluttertoast.showToast(
            msg: '${value.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print("get data >>>>>>" + value.message!);
      }else{
        setState(() {
          Constants.islogedin = true;
          message = value.message;
        });
        Fluttertoast.showToast(
            msg: '${value.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) => new NavBar()));
        Constants.apimessage = value.message!;
        print(Constants.apimessage);
        print(Constants.islogedin);
      }
      message == value.message;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login To Your Account,',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'ProductSans-Thin'),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    child: RoundedInputField(
                  hintText: 'Enter Your Email',
                  controller: emailController,
                  icon: Icons.mail,
                )),
                Container(
                    child: RoundedInputField(
                  hintText: 'Enter Your Password',
                  controller: passController,
                  icon: Icons.vpn_key_outlined,
                )),
                Container(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      backgroundColor: Colors.redAccent,
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'ProductSans-Thin',
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      apiCallTLogin().then((value) async {
                        if (value.error != true) {
                          Fluttertoast.showToast(
                              msg: value.message,
                              backgroundColor: Colors.green,
                              textColor: Colors.white);
                        } else {
                          final sharedPreferences =
                              await SharedPreferences.getInstance();
                          //sharedPreferences.setBool('isLoggedin', true);
                          sharedPreferences.setString(
                              'token', value.user!.token);
                          sharedPreferences.setString(
                              'userid', value.user!.userId);
                          Constants.token =
                              sharedPreferences.getString('token');
                          Constants.user_id =
                              sharedPreferences.getString('userid');
                          //print(sharedPreferences.get('token'));
                          Fluttertoast.showToast(
                              msg: value.message,
                              backgroundColor: Colors.green,
                              textColor: Colors.white);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new NavBar()));
                        }
                      });
                      print(message);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new Register()));
                        },
                        child: Text(
                          'New User? Try Signup',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                //Constants.islogedin == false ? Text('User Not Found',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.redAccent)) : Container()
              ],
            ),
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
