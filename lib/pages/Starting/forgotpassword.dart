import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:oyee11/constants/constants.dart';
import 'dart:convert';

import 'package:oyee11/models/massagemodel.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({Key? key}) : super(key: key);

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  Future<Msgmodel> apiCallTForgot() async {
    var url = Uri.parse(Constants.forgotpassword);
    var response = await http.post(url, body: {
      "email": email.text,
    });
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Msgmodel.fromJson(json.decode(response.body));
    } else {
      print('Failed');
    }
    throw Exception("its null");
    //return TLoginApiResponse(error: data["error"],message: data["message"]);
  }

  TextEditingController email = TextEditingController();
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
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50)),
                    color: Colors.redAccent),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20.0),
              child: Text(
                'Forgot',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 55.0, left: 18.0),
              child: Text(
                'Password.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 100.0, left: 20.0, right: 20.0),
              child: Text(
                'No issue, Just Enter Your Registered Email And get new password on mail,Do not miss the spam folder for new password mail',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 180.0, left: 20.0, right: 20.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        'FORGOT PASSWORD',
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
                        controller: email,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            labelText: "Enter Registered Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            apiCallTForgot().then((value) {
                              Fluttertoast.showToast(msg: value.message);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            backgroundColor: Colors.redAccent,
                          ),
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                                letterSpacing: 3.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
