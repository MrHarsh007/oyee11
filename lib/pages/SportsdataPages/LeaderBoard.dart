import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LeaderBoard'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 150,),
              Text('Coming soon')
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }

}