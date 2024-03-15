import 'package:flutter/material.dart';
import 'package:oyee11/constants/constants.dart';
class Success extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
            child: Center(
              child: Image.asset(
                'assets/designtop.png',
                height: 140,
                width: 140,
              ),
            ),
        ),
          ),
          Positioned(child: Center(child: Image.asset('assets/correct.png',height: 70,width: 70,)),),
          SizedBox(height: 20,),
          Positioned(
              child: Center(child: Text('You Have Successfully Added ${Constants.addamount}'),))
        ]
      ),
    );
    throw UnimplementedError();
  }
}
