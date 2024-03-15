import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';
class Batting extends StatefulWidget{
  @override
  State<Batting> createState() => _BattingState();
}

class _BattingState extends State<Batting> {

  String? stringResponse;
  List? listResponse;
  late Map mapResponse;
  List? listOffResponse;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        '${Constants.battingpointurl}'));
    if (response.statusCode == 200) {
      setState(() {
        listOffResponse = json.decode(response.body);


      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batting Point System'),
      ),
      body: listOffResponse == null ? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/bat.png'),
                            fit: BoxFit.contain
                        )
                    ),
                  ),
                  ExpansionTile(
                    title: Text('Batting Point Syatem',style: Theme.of(context).textTheme.displayLarge),
                    children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Players Name',style: Theme.of(context).textTheme.displayMedium,),
                          Text('Runs',style: Theme.of(context).textTheme.displayMedium,),
                          Text('Balls',style: Theme.of(context).textTheme.displayMedium,),
                          Text('4s',style: Theme.of(context).textTheme.displayMedium,),
                          Text('6s',style: Theme.of(context).textTheme.displayMedium,),
                          Text('FOW',style: Theme.of(context).textTheme.displayMedium,),
                        ],
                      ),
                    ),
                  SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext, index){
                      return ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(listOffResponse![index]['player_name'],style: Theme.of(context).textTheme.displayLarge,),
                            Text(listOffResponse![index]['run_point'],style: Theme.of(context).textTheme.displayMedium,),
                            Text(listOffResponse![index]['ball_point'],style: Theme.of(context).textTheme.displayMedium,),
                            Text(listOffResponse![index]['four_point'],style: Theme.of(context).textTheme.displayMedium,),
                            Text(listOffResponse![index]['six_point'],style: Theme.of(context).textTheme.displayMedium,),
                            Text(listOffResponse![index]['fow_point'],style: Theme.of(context).textTheme.displayMedium,),
                          ],
                        ),
                      );
                    },
                    itemCount: listOffResponse == null ? 0 : listOffResponse!.length,
                    ),
                  ),
                      ]
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
    throw UnimplementedError();
  }
}