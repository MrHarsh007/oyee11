import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyee11/pages/SportsdataPages/Leauges.dart';
import 'package:oyee11/pages/SportsdataPages/Playerslist.dart';
import 'package:oyee11/pages/SportsdataPages/Teams.dart';
import 'package:oyee11/pages/SportsdataPages/venue.dart';

class ExtraAct extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Extra'),
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> new Players()));
              },
              tileColor: Colors.grey[200],
              title: Text('Players From World Cricket',style: Theme.of(context).textTheme.displayLarge,),
              leading: Icon(Icons.person,color: Colors.black,),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(thickness: 2,),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> new Teams()));
              },
              tileColor: Colors.grey[200],
              title: Text('Teams From World Cricket',style: Theme.of(context).textTheme.displayLarge,),
              leading: Icon(Icons.group,color: Colors.black,),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(thickness: 2,),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> new Seasons()));
              },
              tileColor: Colors.grey[200],
              title: Text('Leagues From World Cricket',style: Theme.of(context).textTheme.displayLarge,),
              leading: Icon(FontAwesomeIcons.trophy,color: Colors.black,),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            Divider(thickness: 2,),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> new Venues()));
              },
              tileColor: Colors.grey[200],
              title: Text('Venues From World Cricket',style: Theme.of(context).textTheme.displayLarge,),
              leading: Image.asset('assets/ground.png',height: 40,width: 40,),
              trailing: Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }

}