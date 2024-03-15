import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:oyee11/constants/constants.dart';
import 'dart:convert';

import 'package:oyee11/models/massagemodel.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = TextEditingController();

  Future<Msgmodel> apiCallUpdatePass() async {
    var url = Uri.parse(Constants.changepasswordurl);
    var response = await http.post(url, body: {
      "password": passwordController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 100.0),
            child: Text(
              'CHANGE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 125.0),
            child: Text(
              'PASSWORD',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 35,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300.0, left: 20.0, right: 20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      'Change Password'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          letterSpacing: 2),
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 12.0, left: 12.0, top: 20.0, bottom: 8.0),
                    child: TextFormField(
                      controller: passwordController,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 12.0, left: 12.0, top: 8.0, bottom: 8.0),
                    child: Container(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          apiCallUpdatePass().then((value) {
                            if (value.error != false) {
                              Fluttertoast.showToast(msg: value.message);
                            } else {
                              Fluttertoast.showToast(msg: value.message);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                              letterSpacing: 2,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
