import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/models/commentarymodel.dart';
import 'package:oyee11/models/massagemodel.dart';
import 'package:oyee11/models/matchlistmodel.dart';

class MatchDatalive extends StatefulWidget {
  const MatchDatalive({Key? key}) : super(key: key);

  @override
  _MatchDataliveState createState() => _MatchDataliveState();
}

class _MatchDataliveState extends State<MatchDatalive> with SingleTickerProviderStateMixin{
  Map? mapResponse;
  Map? mapResponse2;
  List? listOffResponse;
  List? listOffResponse2;

  String? preid;
  String? points;


  bool p1 = true;
  //List battingOrder = [];

  TabController? _tabController;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        '${Constants.livematch}/'),headers: {'rs-token': Constants.apitoken});
    var response2 = await http.get(Uri.parse('https://starpaneldevelopers.com/api/get_bat_predict.php?userId=58&contestId=26&tokenLimit=9845331646315349'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        mapResponse2 = json.decode(response2.body);
        print(response.body);
        listOffResponse2 = mapResponse2!['data'];
        //listOffResponse = mapResponse![''];
      });
    }
    else{
      return CircularProgressIndicator();
    }
  }

  void printsomething(){
    print('something');
  }
   Future<Matchdetailsmodel> fetchDetails() async{
     http.Response response;
     response = await http.get(Uri.parse(
         '${Constants.livematch}/'),headers: {'rs-token': Constants.apitoken});
     if(response.statusCode == 200){
       return Matchdetailsmodel.fromJson(json.decode(response.body));
     }
     else{
       print('Error');
     }
     throw Exception();
   }
  Future<Commentarymodel> fetchCommentary() async{
    http.Response response;
    response = await http.get(Uri.parse(
        '${Constants.matchcommentary}/ball-by-ball/'),headers: {'rs-token': Constants.apitoken});
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      return Commentarymodel.fromJson(json.decode(response.body));
    }
    else{
      print('Error');
    }
    throw Exception();
  }
  Future<Commentarymodel> fetchOverCommentary() async{
    http.Response response;
    response = await http.get(Uri.parse(
        '${Constants.matchcommentary}/ball-by-ball/'),headers: {'rs-token': Constants.apitoken});
    print(response.statusCode);
    print(response.body);
    if(response.statusCode == 200){
      return Commentarymodel.fromJson(json.decode(response.body));
    }
    else{
      print('Error');
    }
    throw Exception();
  }

  Future<Msgmodel> Strorepoints() async{
    var url = Uri.parse(Constants.addpoints);
    var response = await http.post(url,body: {
      "contestId": Constants.contestid,
      "preId": preid,
      "points": points,
    });
    if(response.statusCode == 200){
      return Msgmodel.fromJson(jsonDecode(response.body));
    }
    else{
      print('Exception');
    }
    throw Exception(e);
  }
  @override
  void initState() {
    fetchData();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                fetchDetails();
              });
            },
            icon: Icon(Icons.refresh),
          )
        ],
        title: Text('Live Data'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Commentary',
            ),
            Tab(
              text: 'Scorecard',
            ),
            Tab(
              text: 'Playing 11',
            )
          ],
        ),
      ),
      body: mapResponse == null ? Center(child: CircularProgressIndicator(),) : TabBarView(
        controller: _tabController,
        physics: ScrollPhysics(),
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                FutureBuilder<Commentarymodel>(
                    future: fetchCommentary(),
                    builder: (context,snapshot){
                  if(snapshot.hasData){
                    List<Ball> balls = snapshot.data!.data.over.balls;
                    //List<> overs = snapshot.data!.data.over.balls;
                    return Card(
                      child: ListView.builder(
                          itemCount: snapshot.data!.data.over.balls.length,
                          shrinkWrap: true,
                          primary: true,
                          itemBuilder: (context,index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                children: [
                                  Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: balls[index].bowler.isWicket != true ? Text(balls[index].teamScore.runs.toString(),style: TextStyle(color: Colors.white),) : Text('W',style: TextStyle(color: Colors.white),),
                                      ),
                                    decoration: BoxDecoration(
                                      color: balls[index].bowler.isWicket == true ? Colors.redAccent : balls[index].batsman.isSix == true ? Colors.green : balls[index].batsman.isFour == true ? Colors.yellow : Colors.blue,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text(balls[index].comment.toString()),
                                        width: 300,
                                      ),
                                      SizedBox(height: 8,),
                                      Text(balls[index].overs.toString().substring(1,6).replaceAll(',', '.'),style: Theme.of(context).textTheme.displayMedium,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(thickness: 1,),
                          ],
                        );
                      }),
                    );
                  }
                  else if(snapshot.hasError){
                    //print(e);
                    print(snapshot.error);
                  }
                  return CircularProgressIndicator();
                }
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: FutureBuilder<Matchdetailsmodel>(
                future: fetchDetails(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    Map<String, PlayerValue> players = snapshot.data!.data.players;
                    //Map<String, PlayerValue> items = snapshot.data!.data.players;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(mapResponse!['data']['teams']['a']['code'].toString(),style: TextStyle(color: snapshot.data!.data.play!.innings.a1.isCompleted == true ? Colors.green : Colors.redAccent,fontSize: 22,fontWeight: FontWeight.w600),),
                                  SizedBox(width: 10,),
                                  Text('${snapshot.data!.data.play!.innings.a1.score.runs.toString()} / ${snapshot.data!.data.play!.innings.a1.wickets.toString()} (${snapshot.data!.data.play!.innings.a1.overs.toString().substring(1,6).replaceAll(',', '.')})',style: TextStyle(color: snapshot.data!.data.play!.innings.a1.isCompleted == true ? Colors.green : Colors.redAccent,fontSize: 22,fontWeight: FontWeight.w600),),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Row(
                                children: [
                                  Text(mapResponse!['data']['teams']['b']['code'].toString(),style: TextStyle(color: snapshot.data!.data.play!.innings.b1.isCompleted == true ? Colors.green : Colors.redAccent,fontSize: 22,fontWeight: FontWeight.w600),),
                                  SizedBox(width: 10,),
                                  Text('${snapshot.data!.data.play!.innings.b1.score.runs.toString()} / ${snapshot.data!.data.play!.innings.b1.wickets.toString()} (${snapshot.data!.data.play!.innings.b1.overs.toString().substring(1,6).replaceAll(',', '.')})',style: TextStyle(color: snapshot.data!.data.play!.innings.b1.isCompleted == true ? Colors.green : Colors.redAccent,fontSize: 22,fontWeight: FontWeight.w600),),
                                ],
                              ),
                            ],
                          ),
                        ),
                        snapshot.data!.data.play!.result!.msg != null ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data!.data.play!.result!.msg.toString(),style: TextStyle(fontSize: 12,color: Colors.blue[800]),),
                        ) : Container(),
                        snapshot.data!.data.play!.result!.pom != null ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(thickness: 1,),
                              Text('Player Of The Match',style: TextStyle(fontSize: 8,color: Colors.grey),),
                              ListView.builder(
                                  itemBuilder: (context,index){
                                return Text(snapshot.data!.data.players[snapshot.data!.data.play!.result!.pom![index]]!.player.name.toString());
                              },
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                primary: true,
                                itemCount: 1,
                              ),
                              Divider(thickness: 1,),
                            ],
                          ),
                        ) : Container(),
                        ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(mapResponse!['data']['teams']['a']['name'].toString()),
                              Text(snapshot.data!.data.play!.innings.a1.scoreStr.toString())
                            ],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 8.0,right: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Batsman',style: TextStyle(fontSize: 10),),
                                  SizedBox(width: 100,),
                                  Text('R',style: TextStyle(fontSize: 10),),
                                  Text('B',style: TextStyle(fontSize: 10),),
                                  Text('4s',style: TextStyle(fontSize: 10),),
                                  Text('6s',style: TextStyle(fontSize: 10),),
                                  Text('SR',style: TextStyle(fontSize: 10),),
                                ],
                              ),
                            ),
                            //Text(snapshot.data!.data.players.toString()),
                            Divider(thickness: 1,),
                            ListView.builder(
                              itemBuilder: (context,index){
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0,right: 20.0,bottom: 4.0,left: 4.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:100,
                                                child: Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[index]]!.player.name,style: TextStyle(fontSize: 12),)),
                                            SizedBox(width: 50,),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[index]]!.score.the1!.batting!.score.runs.toString(),style: TextStyle(fontSize: 14),),
                                            //SizedBox(width: 20,),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[index]]!.score.the1!.batting!.score.balls.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                            //SizedBox(width: 20,),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[index]]!.score.the1!.batting!.score.fours.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                            //SizedBox(width: 20,),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[index]]!.score.the1!.batting!.score.sixes.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                            //SizedBox(width: 20,),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[index]]!.score.the1!.batting!.score.strikeRate.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                          ],
                                        ),
                                        snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[index]]!.score.the1!.batting!.dismissal != null ? Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[index]]!.score.the1!.batting!.dismissal!.msg,style: TextStyle(fontSize: 10,color: Colors.grey),) : Text('not out',style: TextStyle(fontSize: 10)),
                                        Divider(thickness: 1,),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.data.play!.innings.a1.battingOrder.length,
                              shrinkWrap: true,
                              primary: true,
                              physics: ScrollPhysics(),
                            ),
                            Divider(thickness: 1,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Extras'.toUpperCase(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                                      Text('${snapshot.data!.data.play!.innings.a1.extraRuns.extra.toString()} runs'),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  ),
                                  SizedBox(height: 8.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${snapshot.data!.data.play!.innings.a1.extraRuns.wide.toString()} W'),
                                      Text('${snapshot.data!.data.play!.innings.a1.extraRuns.bye.toString()} B'),
                                      Text('${snapshot.data!.data.play!.innings.a1.extraRuns.noBall.toString()} N'),
                                      Text('${snapshot.data!.data.play!.innings.a1.extraRuns.legBye.toString()} Lbyes'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(thickness: 1,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('Total',style: TextStyle(fontSize: 14),),
                                  Text('${snapshot.data!.data.play!.innings.a1.score.runs.toString()} / ${snapshot.data!.data.play!.innings.a1.wickets.toString()} (${snapshot.data!.data.play!.innings.a1.overs.toString().substring(1,6).replaceAll(',', '.')})'),
                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                            ),
                            Divider(thickness: 1,),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0,right: 20.0,bottom: 4.0,left: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Bowler',style: TextStyle(fontSize: 10),),
                                  SizedBox(width: 110,),
                                  Text('O',style: TextStyle(fontSize: 10),),
                                  Text('W',style: TextStyle(fontSize: 10),),
                                  Text('R',style: TextStyle(fontSize: 10),),
                                  Text('M',style: TextStyle(fontSize: 10),),
                                  Text('ER',style: TextStyle(fontSize: 10),)
                                ],
                              ),
                            ),
                            Divider(thickness: 1,),
                            ListView.builder(
                              itemBuilder: (context,index){
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0,bottom: 4.0,left: 4.0,right: 20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:100,
                                                child: Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[index]]!.player.name,style: TextStyle(fontSize: 12),)),
                                            SizedBox(width: 50,),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[index]]!.score.the1!.bowling!.score.overs.toString().substring(1,5).replaceAll(',', '.'),style: TextStyle(fontSize: 12),),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[index]]!.score.the1!.bowling!.score.wickets.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[index]]!.score.the1!.bowling!.score.runs.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[index]]!.score.the1!.bowling!.score.maidenOvers.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[index]]!.score.the1!.bowling!.score.economy.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                                          ],
                                        ),
                                        Divider(thickness: 1,),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              physics: ScrollPhysics(),
                              primary: true,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data.play!.innings.b1.bowlingOrder.length,
                            )
                          ],
                        ),
                        ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(mapResponse!['data']['teams']['b']['name'].toString()),
                              Text(snapshot.data!.data.play!.innings.b1.scoreStr)
                            ],
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0,right: 20.0,bottom: 8.0,left: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Batsman',style: TextStyle(fontSize: 10),),
                                  SizedBox(width: 100,),
                                  Text('R',style: TextStyle(fontSize: 10),),
                                  Text('B',style: TextStyle(fontSize: 10),),
                                  Text('4s',style: TextStyle(fontSize: 10),),
                                  Text('6s',style: TextStyle(fontSize: 10),),
                                  Text('SR',style: TextStyle(fontSize: 10),),
                                ],
                              ),
                            ),
                            //Text(snapshot.data!.data.players.toString()),
                            Divider(thickness: 1,),
                            ListView.builder(
                              itemBuilder: (context,index){
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0,right: 20.0,bottom: 4.0,left: 4.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:100,
                                                child: Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[index]]!.player.name,style: TextStyle(fontSize: 12),)),
                                            SizedBox(width: 50,),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[index]]!.score.the1!.batting!.score.runs.toString(),style: TextStyle(fontSize: 14),),
                                            //SizedBox(width: 20,),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[index]]!.score.the1!.batting!.score.balls.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                            //SizedBox(width: 20,),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[index]]!.score.the1!.batting!.score.fours.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                            //SizedBox(width: 20,),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[index]]!.score.the1!.batting!.score.sixes.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                            //SizedBox(width: 20,),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[index]]!.score.the1!.batting!.score.strikeRate.toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                          ],
                                        ),
                                        snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[index]]!.score.the1!.batting!.dismissal != null ? Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[index]]!.score.the1!.batting!.dismissal!.msg,style: TextStyle(fontSize: 10,color: Colors.grey),) : Text('not out',style: TextStyle(fontSize: 10)),
                                        Divider(thickness: 1,),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              itemCount: snapshot.data!.data.play!.innings.b1.battingOrder.length,
                              shrinkWrap: true,
                              primary: true,
                              physics: ScrollPhysics(),
                            ),
                            Divider(thickness: 1,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Extras'.toUpperCase(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
                                      Text('${snapshot.data!.data.play!.innings.b1.extraRuns.extra.toString()} runs'),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  ),
                                  SizedBox(height: 8.0,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${snapshot.data!.data.play!.innings.b1.extraRuns.wide.toString()} W'),
                                      Text('${snapshot.data!.data.play!.innings.b1.extraRuns.bye.toString()} B'),
                                      Text('${snapshot.data!.data.play!.innings.b1.extraRuns.noBall.toString()} N'),
                                      Text('${snapshot.data!.data.play!.innings.b1.extraRuns.legBye.toString()} Lbyes'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(thickness: 1,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text('Total',style: TextStyle(fontSize: 14),),
                                  Text('${snapshot.data!.data.play!.innings.b1.score.runs.toString()} / ${snapshot.data!.data.play!.innings.a1.wickets.toString()} (${snapshot.data!.data.play!.innings.a1.overs.toString().substring(1,6).replaceAll(',', '.')})'),
                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                            ),
                            Divider(thickness: 1,),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0,right: 20.0,bottom: 4.0,left: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Bowler',style: TextStyle(fontSize: 10),),
                                  SizedBox(width: 110,),
                                  Text('O',style: TextStyle(fontSize: 10),),
                                  Text('W',style: TextStyle(fontSize: 10),),
                                  Text('R',style: TextStyle(fontSize: 10),),
                                  Text('M',style: TextStyle(fontSize: 10),),
                                  Text('ER',style: TextStyle(fontSize: 10),)
                                ],
                              ),
                            ),
                            Divider(thickness: 1,),
                            ListView.builder(
                              itemBuilder: (context,index){
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0,bottom: 4.0,left: 4.0,right: 20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:100,
                                                child: Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[index]]!.player.name,style: TextStyle(fontSize: 12),)),
                                            SizedBox(width: 50,),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[index]]!.score.the1!.bowling!.score.overs.toString().substring(1,5).replaceAll(',', '.'),style: TextStyle(fontSize: 12),),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[index]]!.score.the1!.bowling!.score.wickets.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[index]]!.score.the1!.bowling!.score.runs.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[index]]!.score.the1!.bowling!.score.maidenOvers.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                                            Text(snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[index]]!.score.the1!.bowling!.score.economy.toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),),
                                          ],
                                        ),
                                        Divider(thickness: 1,),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              physics: ScrollPhysics(),
                              primary: true,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.data.play!.innings.a1.bowlingOrder.length,
                            )
                          ],
                        ),
                        snapshot.data!.data.status == 'completed' ? Column(
                          children: [
                            for(int index = 0; index < 30; index++)...{
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[1]]!.score.the1!.batting!.score.runs.isOdd ? Text('True') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[1]]!.score.the1!.batting!.score.runs.isEven ? Text('True') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[1]]!.score.the1!.batting!.score.balls.isOdd ? Text('True') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[1]]!.score.the1!.batting!.score.balls.isEven ? Text('True') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[1]]!.score.the1!.batting!.score.fours.isOdd ? Text('True') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[1]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even 4s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[1]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd 6s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[1]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even 6s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[2]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[2]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[2]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[2]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[2]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd 4s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[2]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even 4s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[2]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd 6s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[2]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even 6s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[3]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[3]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[3]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[3]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[3]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd 4s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[3]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even 4s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[3]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd 6s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[3]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even 6s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[4]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[4]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[4]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[4]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[4]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd 4s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[4]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even 4s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[4]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd 6s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[4]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even 6s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[5]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[5]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[5]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[5]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[5]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd 4s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[5]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even 4s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[5]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd 6s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[5]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even 6s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[6]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[6]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[6]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[6]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[6]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd 4s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[6]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even 4s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[6]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd 6s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[6]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even 6s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[7]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[7]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[7]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[7]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[7]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd 4s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[7]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even 4s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[7]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd 6s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[7]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even 6s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[8]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[8]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[8]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[8]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[8]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd 4s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[8]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even 4s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[8]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd 6s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[8]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even 6s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[9]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[9]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[9]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[9]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[9]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd 4s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[9]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even 4s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[9]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd 6s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[9]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even 6s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                               // snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[10]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[10]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                //snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[10]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[10]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                               // snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[10]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd 4s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[10]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even 4s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[10]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd 6s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[10]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even 6s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[11]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[11]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[11]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[11]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[11]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd 4s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[11]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even 4s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[11]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd 6s Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.battingOrder[11]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even 6s Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[1]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[1]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[1]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[1]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[1]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd fours Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[1]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even fours Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[1]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd sixes Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman1' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[1]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even sixes Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[2]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[2]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[2]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[2]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[2]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd fours Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[2]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even fours Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[2]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd sixes Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman2' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[2]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even sixes Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[3]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[3]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[3]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[3]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[3]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd fours Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[3]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even fours Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[3]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd sixes Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman3' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[3]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even sixes Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[4]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[4]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[4]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[4]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[4]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd fours Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[4]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even fours Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[4]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd sixes Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman4' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[4]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even sixes Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[5]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[5]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[5]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[5]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[5]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd fours Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[5]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even fours Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[5]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd sixes Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman5' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[5]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even sixes Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[6]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[6]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[6]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[6]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[6]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd fours Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[6]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even fours Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[6]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd sixes Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman6' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[6]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even sixes Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[7]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[7]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[7]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[7]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[7]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd fours Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[7]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even fours Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[7]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd sixes Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman7' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[7]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even sixes Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[8]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[8]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[8]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[8]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[8]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd fours Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[8]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even fours Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[8]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd sixes Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman8' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[8]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even sixes Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[9]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[9]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[9]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[9]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[9]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd fours Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[9]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even fours Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[9]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd sixes Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman9' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[9]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even sixes Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[10]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[10]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[10]]!.score.the1!.batting!.score.balls.isOdd ? GestureDetector(onTap: (){
                                  setState(() {
                                    Strorepoints();
                                  });
                                },) : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[10]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[10]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd fours Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[10]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even fours Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[10]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd sixes Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman10' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[10]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even sixes Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[11]]!.score.the1!.batting!.score.runs.isOdd ? Text('The Prediction For Odd Runs Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[11]]!.score.the1!.batting!.score.runs.isEven ? Text('The Prediction For Even Runs Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[11]]!.score.the1!.batting!.score.balls.isOdd ? Text('The Prediction For Odd Balls Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == 'balls' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[11]]!.score.the1!.batting!.score.balls.isEven ? Text('The Prediction For Even Balls Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[11]]!.score.the1!.batting!.score.fours.isOdd ? Text('The Prediction For Odd fours Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == '4s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[11]]!.score.the1!.batting!.score.fours.isEven ? Text('The Prediction For Even fours Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[11]]!.score.the1!.batting!.score.sixes.isOdd ? Text('The Prediction For Odd sixes Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'batting' && listOffResponse2![index]['player'] == 'Batsman11' && listOffResponse2![index]['type'] == '6s' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.battingOrder[11]]!.score.the1!.batting!.score.sixes.isEven ? Text('The Prediction For Even sixes Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[1]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[1]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[1]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[1]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[1]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[1]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[1]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[1]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[2]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[2]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[2]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[2]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[2]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[2]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[2]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[2]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[3]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[3]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[3]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[3]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[3]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[3]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[3]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[3]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[4]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[4]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[4]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[4]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[4]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[4]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[4]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[4]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[5]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[5]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[5]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[5]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[5]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[5]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[5]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[5]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[6]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[6]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[6]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[6]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[6]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[6]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[6]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[6]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[7]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[7]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[7]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[7]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[7]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[7]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[7]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[7]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[8]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[8]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[8]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[8]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[8]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[8]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[8]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[8]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.b1.bowlingOrder[1]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[1]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[1]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[1]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[1]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[1]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[1]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler1' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[1]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[2]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[2]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[2]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[2]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[2]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[2]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[2]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[2]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[3]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[3]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[3]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[3]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[3]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[3]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[3]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler3' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[3]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler2' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[4]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[4]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[4]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[4]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[4]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[4]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[4]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler4' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[4]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[5]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[5]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[5]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[5]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[5]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[5]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[5]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler5' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[5]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[6]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[6]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[6]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[6]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[6]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[6]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[6]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler6' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[6]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[7]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[7]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[7]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[7]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[7]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[7]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[7]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler7' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[7]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[8]]!.score.the1!.bowling!.score.runs.isOdd ? Text('The Prediction For Odd Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'runs' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[8]]!.score.the1!.bowling!.score.runs.isEven ? Text('The Prediction For Even Runs Bowler Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[8]]!.score.the1!.bowling!.score.wickets.isOdd ? Text('The Prediction For Odd Wickets Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'wickets' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[8]]!.score.the1!.bowling!.score.wickets.isEven ? Text('The Prediction For Even Wickets Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[8]]!.score.the1!.bowling!.score.maidenOvers.isOdd ? Text('The Prediction For Odd Maidens Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[8]]!.score.the1!.bowling!.score.maidenOvers.isEven ? Text('The Prediction For Even Maidens Wickets Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'Extra' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[8]]!.score.the1!.bowling!.score.extras.isOdd ? Text('The Prediction For Odd Extra Bowler Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'bowling' && listOffResponse2![index]['player'] == 'Bowler8' && listOffResponse2![index]['type'] == 'maidens' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.players[snapshot.data!.data.play!.innings.a1.bowlingOrder[8]]!.score.the1!.bowling!.score.extras.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra1' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.play!.innings.a1.extraRuns.extra.isOdd ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra1' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.play!.innings.a1.extraRuns.extra.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra2' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.play!.innings.a1.extraRuns.wide.isOdd ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra2' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.play!.innings.a1.extraRuns.wide.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra3' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.play!.innings.a1.extraRuns.noBall.isOdd ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra3' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.play!.innings.a1.extraRuns.noBall.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra4' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.play!.innings.a1.extraRuns.legBye.isOdd ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra4' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.play!.innings.a1.extraRuns.legBye.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra5' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.play!.innings.a1.score.runs.isOdd ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra5' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.play!.innings.a1.score.runs.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra6' && listOffResponse2![index]['value'] == 'odd')...{
                                if(snapshot.data!.data.play!.innings.b1.wickets.isOdd)...{
                                  Column(
                                      children: [
                                        preid = listOffResponse2![index]['id'],

                                      ],
                                  )
                                }
                              }
                              else if(listOffResponse2![index]['team'] == '1' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra6' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.play!.innings.b1.wickets.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra1' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.play!.innings.b1.extraRuns.extra.isOdd ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra1' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.play!.innings.b1.extraRuns.extra.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra2' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.play!.innings.b1.extraRuns.wide.isOdd ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra2' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.play!.innings.b1.extraRuns.wide.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra3' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.play!.innings.b1.extraRuns.noBall.isOdd ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra3' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.play!.innings.b1.extraRuns.noBall.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra4' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.play!.innings.b1.extraRuns.legBye.isOdd ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra4' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.play!.innings.b1.extraRuns.legBye.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra5' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.play!.innings.b1.score.runs.isOdd ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra5' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.play!.innings.b1.score.runs.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              },
                              if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra6' && listOffResponse2![index]['value'] == 'odd')...{
                                snapshot.data!.data.play!.innings.b1.wickets.isOdd ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              }
                              else if(listOffResponse2![index]['team'] == '2' && listOffResponse2![index]['side'] == 'extras' && listOffResponse2![index]['player'] == 'Extra6' && listOffResponse2![index]['value'] == 'even')...{
                                snapshot.data!.data.play!.innings.b1.wickets.isEven ? Text('The Prediction For Even Extra Is Correct') : Text('Wrong Prediction'),
                              }
                            }
                          ],
                        ) : Container(),
                      ],
                    );
                  }
                  else if(snapshot.hasError){
                    //print(e);
                    print(snapshot.error);
                  }
                  return Center(child: CircularProgressIndicator());
                }
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(mapResponse!['data']['teams']['a']['name'].toString()),
                            Divider(thickness: 1,),
                            FutureBuilder<Matchdetailsmodel>(
                                future: fetchDetails(),
                                builder: (context,snapshot){
                                  if(snapshot.hasData){
                                    return ListView.builder(
                                        itemCount: 11,
                                        primary: true,
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemBuilder: (context,index){
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  if(snapshot.data!.data.squad!.a.captain == snapshot.data!.data.squad!.a.playingXi[index])...{
                                                    Container(
                                                      width:100,
                                                      child: Text('${snapshot.data!.data.players[snapshot.data!.data.squad!.a.playingXi[index]]!.player.name} (c)',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                                                    )
                                                  }
                                                  else if(snapshot.data!.data.squad!.a.keeper == snapshot.data!.data.squad!.a.playingXi[index])...{
                                                    Container(
                                                      width:100,
                                                      child: Text('${snapshot.data!.data.players[snapshot.data!.data.squad!.a.playingXi[index]]!.player.name} (wk)',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                                                    )
                                                  }
                                                  else...{
                                                      Container(
                                                        width: 100,
                                                        child: Text('${snapshot.data!.data.players[snapshot.data!.data.squad!.a.playingXi[index]]!.player.name}',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                                                      )
                                                    }
                                                ],
                                              ),
                                              Divider(thickness: 1,)
                                            ],
                                          );
                                        });
                                  }
                                  else if(snapshot.hasError){
                                    Center(child: CircularProgressIndicator(),);
                                  }
                                  else{
                                    Center(child: CircularProgressIndicator(),);
                                  }
                                  return Center(child: CircularProgressIndicator(),);
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(mapResponse!['data']['teams']['b']['name'].toString()),
                            Divider(thickness: 1,),
                            FutureBuilder<Matchdetailsmodel>(
                                future: fetchDetails(),
                                builder: (context,snapshot){
                                  if(snapshot.hasData){
                                    return ListView.builder(
                                        itemCount: 11,
                                        primary: true,
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemBuilder: (context,index){
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      if(snapshot.data!.data.squad!.b.captain == snapshot.data!.data.squad!.b.playingXi[index])...{
                                                        Container(
                                                          width:100,
                                                          child: Text('${snapshot.data!.data.players[snapshot.data!.data.squad!.b.playingXi[index]]!.player.name} (c)',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                                                        )
                                                      }
                                                      else if(snapshot.data!.data.squad!.b.keeper == snapshot.data!.data.squad!.b.playingXi[index])...{
                                                        Container(
                                                          width:100,
                                                          child: Text('${snapshot.data!.data.players[snapshot.data!.data.squad!.b.playingXi[index]]!.player.name} (wk)',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                                                        )
                                                      }
                                                      else...{
                                                          Container(
                                                            width: 100,
                                                            child: Text('${snapshot.data!.data.players[snapshot.data!.data.squad!.b.playingXi[index]]!.player.name}',style: TextStyle(fontSize: 12),textAlign: TextAlign.center,),
                                                          )
                                                        }
                                                    ],
                                                  ),
                                              Divider(thickness: 1,),
                                            ],
                                          );
                                        });
                                  }
                                  else if(snapshot.hasError){
                                    Center(child: CircularProgressIndicator(),);
                                  }
                                  else{
                                    Center(child: CircularProgressIndicator(),);
                                  }
                                  return Center(child: CircularProgressIndicator(),);
                                }),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
