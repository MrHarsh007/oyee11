import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:oyee11/constants/constants.dart';
import 'dart:convert';

import 'package:oyee11/models/registermodel.dart';
import 'package:oyee11/pages/newloginui.dart';

class RegisterUi extends StatefulWidget {
  const RegisterUi({Key? key}) : super(key: key);

  @override
  State<RegisterUi> createState() => _RegisterUiState();
}

class _RegisterUiState extends State<RegisterUi> {
  Future<Registermodel> apiCallTRegister() async {
    var url = Uri.parse(Constants.registerurl);
    var response = await http.post(url, body: {
      "email": emailController.text,
      "user_name": usernameController.text,
      "gender": gender,
      "mobile_number": mobileController.text,
      "password": passController.text,
    });
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Registermodel.fromJson(json.decode(response.body));
    } else {
      print('Failed');
    }
    throw Exception("its null");
    //return TLoginApiResponse(error: data["error"],message: data["message"]);
  }

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  bool isSeen = true;
  int index = 1;

  String gender = 'male';

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
              padding: const EdgeInsets.only(top: 0.0, left: 10.0),
              child: Container(
                child: Text(
                  'Welcome, champ',
                  style: TextStyle(color: Colors.white, fontSize: 34),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 10.0),
              child: Container(
                child: Text(
                  'join the fantasy world with us',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 80.0, left: 10.0, right: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                            letterSpacing: 2.0),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 4.0, bottom: 4.0),
                      child: TextFormField(
                        controller: usernameController,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            labelText: "Enter Name",
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 4.0, bottom: 4.0),
                      child: TextFormField(
                        controller: emailController,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            labelText: "Enter Email",
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 4.0, bottom: 4.0),
                      child: TextFormField(
                        controller: mobileController,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            labelText: "Enter mobile",
                            prefixIcon: Icon(Icons.mobile_friendly),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 4.0, bottom: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Gender',
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    index == 2 || index == 3
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                index = 1;
                                                gender = 'male';
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .brightness_1_outlined,
                                                      size: 14,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'male',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Icon(Icons
                                                      .brightness_1_outlined),
                                                  Icon(Icons.circle,
                                                      color: Colors.blue,
                                                      size: 14),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'male',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                    index == 1 || index == 3
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                index = 2;
                                                gender = 'female';
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .brightness_1_outlined,
                                                      size: 14,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'female',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Icon(Icons
                                                      .brightness_1_outlined),
                                                  Icon(Icons.circle,
                                                      color: Colors.blue,
                                                      size: 14),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text('female',
                                                  style:
                                                      TextStyle(fontSize: 14)),
                                            ],
                                          ),
                                    index == 1 || index == 2
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                index = 3;
                                                gender = 'rather';
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .brightness_1_outlined,
                                                      size: 14,
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'rather',
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Row(
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Icon(Icons
                                                      .brightness_1_outlined),
                                                  Icon(Icons.circle,
                                                      color: Colors.blue,
                                                      size: 14),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'rather',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 4.0, bottom: 4.0),
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            new NewLoginUi()));
                              },
                              child: Text(
                                'Already have an account?',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          apiCallTRegister().then((value) async {
                            if (value.message == 'Sorry email already found.' ||
                                value.message ==
                                    'Sorry Mobile already found.') {
                              Fluttertoast.showToast(
                                  msg: value.message,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white);
                            } else {
                              if (value.error != true) {
                                Fluttertoast.showToast(
                                    msg: value.message,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white);
                              } else {
                                Fluttertoast.showToast(
                                    msg: value.message,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            new NewLoginUi()));
                              }
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: Colors.red,
                        ),
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                              letterSpacing: 3.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 590.0, left: 0.0),
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
