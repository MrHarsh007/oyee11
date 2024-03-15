import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/models/login_model.dart';
import 'package:oyee11/pages/SportsdataPages/Point_system.dart';
import 'package:oyee11/pages/home.dart';

class testlogin extends StatefulWidget {
  @override
  State<testlogin> createState() => _testloginState();
}

Future<Loginmodel> createUser(
  String email,
  String password,
) async {
  final String apiUrl = 'http://starpaneldevelopers.com/api/login.php';

  var response = await http.post(Uri.parse(apiUrl), body: {
    "email": email,
    "password": password,
  });
  if (response.statusCode == 200) {
    print(response.body);
    final data = jsonDecode(response.body);
  }
  if (response.statusCode == 200) {
    return loginmodelFromJson(response.body);
  } else {
    throw UnimplementedError();
  }
}

class _testloginState extends State<testlogin> {
  Loginmodel? _loginmodel;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Enter Your Email'),
              ),
              TextFormField(
                controller: passController,
                decoration: InputDecoration(labelText: 'Enter Your Password'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final String email = emailController.text;
                  final String password = passController.text;

                  final Loginmodel user = await createUser(email, password);
                  _loginmodel == null
                      ? Navigator.push(context,
                          MaterialPageRoute(builder: (context) => new Home()))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new Pointsystem()));
                  print(_loginmodel!.message);
                },
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
