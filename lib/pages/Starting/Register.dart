import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyee11/Widgets/backgroundauth.dart';
import 'package:oyee11/Widgets/or_Divider.dart';
import 'package:oyee11/Widgets/rounded_input_field.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/pages/Starting/Login.dart';
import 'package:oyee11/services/registerservice.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  String? message;
  bool? islogedin;

  callRegisterApi() {
    final service = RApiServices();

    service.apiCallRegister(
      {
        "email": emailController.text,
        "user_name": usernameController.text,
        "gender": genderController.text,
        "mobile_number": mobileController.text,
        "password": passController.text,
      },
    ).then((value) {
      if (value.error != false) {
        setState(() {
          islogedin = false;
        });
        Fluttertoast.showToast(
            msg: '${value.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print("get data >>>>>>" + value.message!);
      } else {
        setState(() {
          islogedin = true;
          message = value.message;
        });
        Fluttertoast.showToast(
            msg: '${value.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Login()));
        Constants.apimessage = value.message!;
        print(Constants.apimessage);
        print(message);
      }
      message == value.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    'Register With Us,',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'ProductSans-Thin'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            RoundedInputField(
              hintText: 'Name',
              icon: Icons.person,
              controller: usernameController,
            ),
            RoundedInputField(
              hintText: 'Email',
              icon: Icons.mail,
              controller: emailController,
            ),
            RoundedInputField(
                hintText: 'Mobile Number',
                icon: Icons.mobile_friendly,
                controller: mobileController),
            RoundedInputField(
              hintText: 'Gender',
              icon: Icons.transgender_sharp,
              controller: genderController,
            ),
            RoundedInputField(
                hintText: 'Enter Password',
                icon: Icons.security,
                controller: passController),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Colors.grey[100],
                ),
                onPressed: () {
                  callRegisterApi();
                  print(message);
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'ProductSans-Thin',
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                )),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Already have an account? Sign IN',
                style: TextStyle(
                  fontFamily: 'ProductSans-Thin',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            OrDivider(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140.0),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  FaIcon(
                    FontAwesomeIcons.twitter,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
    throw UnimplementedError();
  }
}
