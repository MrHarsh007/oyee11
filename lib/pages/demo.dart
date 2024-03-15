import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget{
  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Container(
        height: 800,
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Player 1'),
                        Text('R'),
                        Text('B'),
                        Text('4s'),
                        Text('6s'),
                      ],
                    ),
                    Divider(thickness: 1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ODD            '),
                        Transform.scale(
                          scale: 0.5,
                          child: CupertinoSwitch(value: true,onChanged: (value){
                          },activeColor: Colors.greenAccent,),
                        ),
                        Transform.scale(
                          scale: 0.5,
                          child: CupertinoSwitch(value: true,onChanged: (value){},activeColor: Colors.greenAccent,),
                        ),
                        Transform.scale(
                          scale: 0.5,
                          child: CupertinoSwitch(value: true,onChanged: (value){},activeColor: Colors.greenAccent,),
                        ),
                        Transform.scale(
                          scale: 0.5,
                          child: CupertinoSwitch(value: true,onChanged: (value){},activeColor: Colors.greenAccent,),
                        ),
                      ],
                    ),
                    Divider(thickness: 1,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('EVEN           '),
                        Transform.scale(
                          scale: 0.5,
                          child: CupertinoSwitch(value: true,onChanged: (value){},activeColor: Colors.greenAccent,),
                        ),
                        Transform.scale(
                          scale: 0.5,
                          child: CupertinoSwitch(value: true,onChanged: (value){},activeColor: Colors.greenAccent,),
                        ),
                        Transform.scale(
                          scale: 0.5,
                          child: CupertinoSwitch(value: true,onChanged: (value){},activeColor: Colors.greenAccent,),
                        ),
                        Transform.scale(
                          scale: 0.5,
                          child: CupertinoSwitch(value: true,onChanged: (value){},activeColor: Colors.greenAccent,),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}