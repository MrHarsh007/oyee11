import 'package:flutter/material.dart';

class Slide extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        image: DecorationImage(
          image: AssetImage('assets/1.jpeg'),
          fit: BoxFit.contain
        )
      ),
    );
    throw UnimplementedError();
  }

}