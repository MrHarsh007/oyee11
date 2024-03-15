import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/pages/home.dart';

import '../../models/massagemodel.dart';

class Contact extends StatefulWidget {
  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  Future<Msgmodel> contact() async {
    var url = Uri.parse(Constants.contacturl);
    var response = await http.post(url, body: {
      "name": nameController.text,
      "email": emailController.text,
      "subject": subjectController.text,
      "description": descController.text,
    });
    if (response.statusCode == 200) {
      return Msgmodel.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
    }
    throw Exception('Exception');
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            'Contact us',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'ProductSans-Thin'),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      labelText: 'Your name',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: emailController,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      labelText: 'Your Email',
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: subjectController,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      labelText: 'Your Issue',
                      prefixIcon: Icon(Icons.report_problem_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: descController,
                  maxLines: 5,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                      labelText: 'Explain issue(optional)',
                      prefixIcon: Icon(Icons.description),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 7.0,
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {
                        contact().then((value) {
                          if (value.error == false) {
                            Fluttertoast.showToast(msg: value.message);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new Home()));
                          } else {
                            Fluttertoast.showToast(msg: value.message);
                            //print(value.error);
                          }
                        });
                      },
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 4.0),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
