import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:oyee11/Widgets/bottom_navbar.dart';
import 'package:oyee11/pages/newloginui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;

  void checkLogin() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      token = sharedPreferences.getString('token');
      Constants.token = sharedPreferences.getString('token');
      Constants.user_id = sharedPreferences.getString('userid');
      Constants.mobilenumber = sharedPreferences.getString('mobilenumber');
      Constants.email = sharedPreferences.getString('email');
    });
    print(token);
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.redAccent,
            centerTitle: true,
            titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        textTheme: TextTheme(
          bodySmall: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w900, color: Colors.black),
          headlineSmall: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          titleLarge: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
          displayLarge: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          displayMedium: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
          displaySmall: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 10, color: Colors.grey),
          headlineMedium: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          bodyLarge: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          bodyMedium: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
        primarySwatch: Colors.red,
        fontFamily: 'ProductSans-Thin',
      ),
      home: AnimatedSplashScreen(
        centered: true,
        splashIconSize: 1000,
        duration: 300,
        splash: 'assets/splash.jpeg',
        nextScreen: token != null ? NavBar() : NewLoginUi(),
      ),
    );
  }
}
