import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Positioned(top: -75, left: -250, child: Image.asset('assets/top.png')),
        Positioned(bottom: -90, child: Image.asset('assets/bottom.png')),
        Positioned(
          top: 85,
          right: 60,
          child: Text(
            'Oyee',
            style: TextStyle(
                fontFamily: 'ProductSans-Thin',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.grey),
          ),
        ),
        Positioned(
            top: 30,
            right: 0,
            child: Text(
              '11',
              style: TextStyle(
                  fontFamily: 'ProductSans-Thin',
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            )),
        Positioned(
            top: 70, right: -250, child: Image.asset('assets/medium.png')),
        child,
      ]),
    );
  }
}
