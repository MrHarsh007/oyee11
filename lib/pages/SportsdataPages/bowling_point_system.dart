import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';

class Bowling extends StatefulWidget{
  @override
  State<Bowling> createState() => _BowlingState();
}

class _BowlingState extends State<Bowling> {


  String? stringResponse;
  List? listResponse;
  late Map mapResponse;
  List? listOffResponse;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        '${Constants.bowlingpointurl}'));
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
        title: Text('Bowling Point System'),
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
                              image: AssetImage('assets/bowling_points.png'),
                              fit: BoxFit.contain
                          )
                      ),
                    ),
                    ExpansionTile(
                        title: Text('Bowling Point Syatem',style: Theme.of(context).textTheme.displayLarge),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Bowlers Name',style: Theme.of(context).textTheme.displayMedium,),
                                Text('Overs',style: Theme.of(context).textTheme.displayMedium,),
                                Text('Runs',style: Theme.of(context).textTheme.displayMedium,),
                                Text('Maidens',style: Theme.of(context).textTheme.displayMedium,),
                                Text('Wickets',style: Theme.of(context).textTheme.displayMedium,),
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
                                      Text(listOffResponse![index]['bowler_name'],style: Theme.of(context).textTheme.displayLarge,),
                                      Text(listOffResponse![index]['over_point'],style: Theme.of(context).textTheme.displayMedium,),
                                      Text(listOffResponse![index]['bowler_run_point'],style: Theme.of(context).textTheme.displayMedium,),
                                      Text(listOffResponse![index]['maiden_point'],style: Theme.of(context).textTheme.displayMedium,),
                                      Text(listOffResponse![index]['wicket_point'],style: Theme.of(context).textTheme.displayMedium,),
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