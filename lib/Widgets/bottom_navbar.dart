import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyee11/pages/SportsdataPages/LeaderBoard.dart';
import 'package:oyee11/pages/User/Mymatches.dart';
import 'package:oyee11/pages/User/User_Profile.dart';
import 'package:oyee11/pages/home.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  GlobalKey _bottomNavigationKey = GlobalKey();

  int _currentIndex = 0;

  final List<Widget> _children = [Home(), Mymatches(), LeaderBoard(), Profile()];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Colors.red,
        height: 55,
        items: [
          Icon(
            Icons.home,
            size: 30,
            color: _currentIndex == 0 ? Colors.white : Colors.black,
          ),
          FaIcon(
            FontAwesomeIcons.trophy,
            size: 20,
            color: _currentIndex == 1 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.leaderboard_outlined,
            size: 40,
            color: _currentIndex == 2 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: _currentIndex == 3 ? Colors.white : Colors.black,
          ),

        ],
        animationDuration: Duration(
          milliseconds: 300,
        ),
        animationCurve: Curves.bounceIn,
        onTap: onTappedBar,
      ),
    );
    throw UnimplementedError();
  }
}
