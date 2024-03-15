
import 'package:flutter/material.dart';
import 'package:oyee11/Widgets/backgroundauth.dart';
import 'package:oyee11/pages/Starting/Login.dart';
import 'package:oyee11/pages/Starting/Register.dart';

class Ask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome To The,',
              style: TextStyle(
                  fontFamily: 'ProductSans-Thin',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/ui.png',
              height: 200,
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: Colors.redAccent)),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Login()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'ProductSans-Thin',
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                ),
              ),
            ),
            Container(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: Colors.redAccent)),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new Register()));
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'ProductSans-Thin',
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
