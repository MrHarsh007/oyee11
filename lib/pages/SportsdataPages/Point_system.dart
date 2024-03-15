import 'package:flutter/material.dart';
import 'package:oyee11/pages/SportsdataPages/batting_point_system.dart';
import 'package:oyee11/pages/SportsdataPages/bowling_point_system.dart';
import 'package:oyee11/pages/SportsdataPages/extra_point_system.dart';

class Pointsystem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Point System'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new Batting()));
                },
                title: Text('Batting Point System',style: Theme.of(context).textTheme.displayLarge,),
                leading: Image.asset('assets/bat.jpg',height: 40,width: 40,),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
              ),
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new Bowling()));
                },
                title: Text('Bowling Point System',style: Theme.of(context).textTheme.displayLarge,),
                leading: Image.asset('assets/bowl.jpg',height: 40,width: 40,),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
              ),
              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new Extras()));
                },
                title: Text('Extra Point System',style: Theme.of(context).textTheme.displayLarge,),
                leading: Image.asset('assets/cr.png',height: 40,width: 40,),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
              )
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }

}