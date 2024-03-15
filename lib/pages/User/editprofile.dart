import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oyee11/models/userdetailsmodel.dart';
import 'dart:convert';


import '../../constants/constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  Future<Userdetailsmodel> fetchData() async {
    var url = Uri.parse(Constants.userprofile);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return Userdetailsmodel.fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
    }
    throw Exception('If Error');
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();
  String? gender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder<Userdetailsmodel>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey.shade300,
                          image: DecorationImage(
                              image: AssetImage('assets/vk.jpg'))),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 5,
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal details',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: usernamecontroller,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: snapshot.data!.data.userName,
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: usernamecontroller,
                          decoration: InputDecoration(
                            labelText: 'First name',
                            prefixIcon: Icon(Icons.info),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          controller: usernamecontroller,
                          decoration: InputDecoration(
                            labelText: 'Last name',
                            hintText: '',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        TextFormField(
                          controller: mailcontroller,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: snapshot.data!.data.email,
                            prefixIcon: Icon(Icons.mail),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText:
                                '+91 ${snapshot.data!.data.mobileNumber}',
                            prefixIcon: Icon(Icons.phone_android),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 7.0,
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 3.0,
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            );
          } else {
            return Center(child: LinearProgressIndicator());
          }
        },
      )),
    );
  }
}
