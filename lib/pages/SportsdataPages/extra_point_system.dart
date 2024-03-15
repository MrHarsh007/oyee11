import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';
class Extras extends StatefulWidget{
  @override
  State<Extras> createState() => _ExtrasState();
}

class _ExtrasState extends State<Extras> {


  String? stringResponse;
  List? listResponse;
  late Map mapResponse;
  List? listOffResponse;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        '${Constants.extrapointurl}'));
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
        title: Text('Extras Point System'),
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
                              image: AssetImage('assets/ground.png'),
                              fit: BoxFit.contain
                          )
                      ),
                    ),
                    ExpansionTile(
                        title: Text('Extras Point Syatem',style: Theme.of(context).textTheme.displayLarge),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Points For',style: Theme.of(context).textTheme.displayMedium,),
                                Text('Points',style: Theme.of(context).textTheme.displayMedium,),
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
                                  title: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Extras',style: Theme.of(context).textTheme.displayLarge,),
                                          Text(listOffResponse![index]['total_extra_point'],style: Theme.of(context).textTheme.displayMedium,),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Wide Balls',style: Theme.of(context).textTheme.displayLarge,),
                                          Text(listOffResponse![index]['wide_ball_point'],style: Theme.of(context).textTheme.displayMedium,),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('No Balls',style: Theme.of(context).textTheme.displayLarge,),
                                          Text(listOffResponse![index]['no_ball_point'],style: Theme.of(context).textTheme.displayMedium,),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Leg Byes',style: Theme.of(context).textTheme.displayLarge,),
                                          Text(listOffResponse![index]['legbye_point'],style: Theme.of(context).textTheme.displayMedium,),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Final Scores',style: Theme.of(context).textTheme.displayLarge,),
                                          Text(listOffResponse![index]['final_score_point'],style: Theme.of(context).textTheme.displayMedium,),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Fall Of Wickets',style: Theme.of(context).textTheme.displayLarge,),
                                          Text(listOffResponse![index]['fall_of_wicket'],style: Theme.of(context).textTheme.displayMedium,),
                                        ],
                                      ),
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