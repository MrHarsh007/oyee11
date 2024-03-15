import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Settings extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings',style: Theme.of(context).textTheme.headlineSmall,),
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              title: Text('Allow App To Send Notifications'),
              trailing: CupertinoSwitch(value: false, onChanged: (value) {

              }, activeColor: Colors.green,),
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

}