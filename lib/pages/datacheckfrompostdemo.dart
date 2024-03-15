import 'package:flutter/material.dart';

class MyData extends StatefulWidget{
  @override
  State<MyData> createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checking'),),
      body: Container(
        child: Text(''),
      ),

    );
    throw UnimplementedError();
  }
}