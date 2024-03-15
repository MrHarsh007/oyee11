import 'package:flutter/material.dart';
import 'package:oyee11/models/update_usermodel.dart';
import 'package:http/http.dart' as http;

class UpdateProfile extends StatefulWidget {
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

Future<UpdateUserModel> updateUser(
    String userName,
    String email,
    String gender,
    String password,
    String firstname,
    String lastname,
    String mobilenumber,
    String birthdate) async {
  final String apiUrl = 'http://starpaneldevelopers.com/api/edit_profile.php';

  final response = await http.post(Uri.parse(apiUrl), body: {
    "user_name": userName,
    "email": email,
    "gender": gender,
    "password": password,
    "firstname": firstname,
    "lastname": lastname,
    "mobilenumber": mobilenumber,
    "birthdate": birthdate,
  });

  if (response.statusCode == 201) {
    final String responseString = response.body;

    return updateUserModelFromJson(responseString);
  } else {
    throw UnimplementedError();
  }
}

class _UpdateProfileState extends State<UpdateProfile> {
  UpdateUserModel? _updateUserModel;
  final TextEditingController fnController = TextEditingController();
  final TextEditingController lnController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController unController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController mnController = TextEditingController();
  final TextEditingController bdController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter Firstname',
                    focusedBorder: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    ),
                    border: InputBorder.none),
                controller: fnController,
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter Lastname',
                    focusedBorder: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    ),
                    border: InputBorder.none),
                controller: lnController,
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter gmail',
                    focusedBorder: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    ),
                    border: InputBorder.none),
                controller: mailController,
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter Username',
                    focusedBorder: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    ),
                    border: InputBorder.none),
                controller: unController,
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter gender',
                    focusedBorder: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    ),
                    border: InputBorder.none),
                controller: genderController,
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter mobilenumber',
                    focusedBorder: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    ),
                    border: InputBorder.none),
                controller: mnController,
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter password',
                    focusedBorder: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    ),
                    border: InputBorder.none),
                controller: passController,
              ),
              TextField(
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter birthdate',
                    focusedBorder: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Colors.redAccent,
                    ),
                    border: InputBorder.none),
                controller: bdController,
              ),
              ElevatedButton(
                onPressed: () async {
                  final String userName = mnController.text;
                  final String gender = genderController.text;
                  final String firstname = fnController.text;
                  final String lastname = lnController.text;
                  final String email = mailController.text;
                  final String mobilenumber = unController.text;
                  final String birthdate = bdController.text;
                  final String password = passController.text;

                  final UpdateUserModel updateuser = await updateUser(
                      userName,
                      email,
                      gender,
                      password,
                      firstname,
                      lastname,
                      mobilenumber,
                      birthdate);

                  setState(() {
                    _updateUserModel = _updateUserModel;
                  });
                },
                child: Text('Update User Details'),
              ),
              _updateUserModel == null
                  ? Container()
                  : Text(_updateUserModel!.message),
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
