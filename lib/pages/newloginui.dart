import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:oyee11/Widgets/bottom_navbar.dart';
import 'package:oyee11/constants/constants.dart';
import 'dart:convert';

import 'package:oyee11/models/login_model.dart';
import 'package:oyee11/newregisterui.dart';
import 'package:oyee11/pages/Starting/forgotpassword.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewLoginUi extends StatefulWidget {
  const NewLoginUi({Key? key}) : super(key: key);

  @override
  State<NewLoginUi> createState() => _NewLoginUiState();
}

class _NewLoginUiState extends State<NewLoginUi> {
  Future<Loginmodel> apiCallTLogin() async {
    var url = Uri.parse(Constants.loginurl);
    var response = await http.post(url, body: {
      "mobile_number": mobileController.text,
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

  TextEditingController mobileController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool isSeen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                ),
                height: 460,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 10.0),
              child: Container(
                child: Text(
                  'Welcome, back',
                  style: TextStyle(color: Colors.white, fontSize: 34),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0, left: 10.0),
              child: Container(
                child: Text(
                  'Login and join the fantasy world',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 170.0, left: 10.0, right: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                            letterSpacing: 2.0),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                      child: TextFormField(
                        controller: mobileController,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            labelText: "Enter Mobile Number",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                      child: TextFormField(
                        controller: passController,
                        obscureText: isSeen,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            labelText: "Enter Password",
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: isSeen == false
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isSeen = true;
                                      });
                                    },
                                    icon: Icon(Icons.lock_open_outlined),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isSeen = false;
                                      });
                                    },
                                    icon: Icon(Icons.lock),
                                  ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            new Forgotpassword()));
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            new RegisterUi()));
                              },
                              child: Text(
                                'New User?',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                    Container(
                      width: 250,
                      child: ElevatedButton(
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
                              sharedPreferences.setString(
                                  'email', value.user!.email);
                              sharedPreferences.setString(
                                  'mobilenumber', value.user!.mobileNumber);
                              Constants.token =
                                  sharedPreferences.getString('token');
                              Constants.user_id =
                                  sharedPreferences.getString('userid');
                              Constants.email =
                                  sharedPreferences.getString('email');
                              Constants.mobilenumber =
                                  sharedPreferences.getString('mobilenumber');
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
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: Colors.red,
                        ),
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                              letterSpacing: 3.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 550.0, left: 0.0),
              child: Container(
                child: Center(
                    child: Text(
                  'OYEE 11',
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.5), fontSize: 50),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
