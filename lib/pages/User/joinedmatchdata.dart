import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oyee11/Widgets/displaypredictions.dart';
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/models/commentarymodel.dart';
import 'package:oyee11/models/matchdetailsmodelapp.dart';
import 'package:oyee11/models/matchlistmodel.dart';
import 'package:oyee11/models/mycontests.dart';
import 'package:oyee11/models/mypredictionteamsmodel.dart';
import 'package:oyee11/pages/Contests/contestdetails.dart';

class JoinedMatchDetails extends StatefulWidget {
  const JoinedMatchDetails({Key? key}) : super(key: key);

  @override
  State<JoinedMatchDetails> createState() => _JoinedMatchDetailsState();
}

class _JoinedMatchDetailsState extends State<JoinedMatchDetails>
    with SingleTickerProviderStateMixin {
  Map? mapResponse;
  Map? mapResponse2;
  List? listOffResponse;
  List? listOffResponse2;

  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.parse('${Constants.matchdetail + Constants.matchid}'));
    var response2 = await http.get(Uri.parse(
        '${Constants.livematch+Constants.matchkey}/'),headers: {'rs-token': Constants.apitoken});
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        mapResponse2 = json.decode(response2.body);
        print(response.body);
        listOffResponse = mapResponse![''];
      });
    }
  }

  Future<Matchdetailsapp> fetchmatchdetails() async {
    var uri = Constants.matchdetail + Constants.matchid;
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return Matchdetailsapp.fromJson(jsonDecode(response.body));
    } else {
      print('Error');
    }
    throw Exception('print nothing');
  }

  Future<Mycontests> fetchContests() async {
    var uri = Constants.mycontests + Constants.matchid;
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return Mycontests.fromJson(jsonDecode(response.body));
    } else {
      print('Error');
    }
    throw Exception('print nothing');
  }

  Future<Myteams> fetchTeams() async {
    var uri = Constants.mypredictions + Constants.matchid;
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      return Myteams.fromJson(jsonDecode(response.body));
    } else {
      print('Error');
    }
    throw Exception('print nothing');
  }

  Future<Commentarymodel> fetchCommentary() async {
    http.Response response;
    response = await http.get(
        Uri.parse('${Constants.matchcommentary}${Constants.matchkey}/ball-by-ball/'),
        headers: {'rs-token': Constants.apitoken});
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return Commentarymodel.fromJson(json.decode(response.body));
    } else {
      print('Error');
    }
    throw Exception();
  }

  Future<Matchdetailsmodel> fetchDetails() async {
    http.Response response;
    response = await http.get(Uri.parse('${Constants.livematch+Constants.matchkey}/'),
        headers: {'rs-token': Constants.apitoken});
    if (response.statusCode == 200) {
      return Matchdetailsmodel.fromJson(json.decode(response.body));
    } else {
      print('Error');
    }
    throw Exception();
  }

  TabController? _tabController;

  @override
  void initState() {
    fetchData();
    _tabController = TabController(length: 5, vsync: this);
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
        title: mapResponse == null
            ? Text('Match Details')
            : Text(
                '${mapResponse!['data']['shortname_one']} v/s ${mapResponse!['data']['shortname_two']}'),
      ),
      body: mapResponse == null
          ? LinearProgressIndicator()
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    FutureBuilder<Matchdetailsapp>(
                      future: fetchmatchdetails(),
                      builder: (context,snapshot){
                        if(snapshot.hasData){
                          return Container(
                            child: Stack(
                              children: [
                                ColorFiltered(colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.8),
                                BlendMode.dstATop,
                                ),
                                    child: Image.asset(
                                      'assets/black.png',
                                    )
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 40),
                                  child: Center(child: Text(snapshot.data!.data.leagueName.toUpperCase(),style: TextStyle(color: Colors.white,fontSize: 16.0),)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 100,left: 20,right: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(mapResponse2!['data']['teams']
                                          ['a']['name']
                                              .toString(),style: TextStyle(color: Colors.white,fontSize: 10.0),),
                                          SizedBox(height: 10,),
                                          mapResponse2!['data']['play'] == null ? Text('0/0 (0.0)',style: TextStyle(color: Colors.white,fontSize: 18.0),) : Text(mapResponse2!['data']['play']['innings']['a_1']['score_str'],style: TextStyle(color: Colors.white,fontSize: 18.0),),
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      ),
                                      Text('V/S',style: TextStyle(color: Colors.white,fontSize: 14.0),),
                                      Column(
                                        children: [
                                          Text(mapResponse2!['data']['teams']
                                          ['b']['name']
                                              .toString(),style: TextStyle(color: Colors.white,fontSize: 10.0),),
                                          SizedBox(height: 10,),
                                          mapResponse2!['data']['play'] == null ? Text('0/0 (0.0)',style: TextStyle(color: Colors.white,fontSize: 18.0),) : Text(mapResponse2!['data']['play']['innings']['b_1']['score_str'],style: TextStyle(color: Colors.white,fontSize: 18.0),),
                                        ],
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 150,),
                                  child: mapResponse2!['data']['play'] == null ? Center(child: Text('Upcoming',style: TextStyle(color: Colors.blue),)) : mapResponse2!['data']['status'] == 'completed' ? Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left:150.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.circle,size: 8.0,color: Colors.green,),
                                            SizedBox(width: 6.0,),
                                            Text('Completed',style: TextStyle(fontSize: 12.0,color: Colors.green),)
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                        child: Divider(thickness: 1,color: Colors.grey.withOpacity(0.4),),
                                      ),
                                      Text(mapResponse2!['data']['play']['result']['msg'],style: TextStyle(color: Colors.white,fontSize: 10.0),)
                                    ],
                                  ) : Padding(
                                    padding: const EdgeInsets.only(left: 170.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.circle,size: 8.0,color: Colors.red,),
                                        SizedBox(width: 6.0,),
                                        Text('Live',style: TextStyle(fontSize: 12.0,color: Colors.red),),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                          child: Divider(thickness: 1,color: Colors.grey.withOpacity(0.4),),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                        else if(snapshot.hasError){
                          return Center(child: CircularProgressIndicator());
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                    TabBar(
                      isScrollable: true,
                      physics: ScrollPhysics(),
                      labelStyle: TextStyle(
                          fontFamily: "ProductSans",
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                      labelColor: Colors.black,
                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: 'My contests',
                        ),
                        Tab(
                          text: 'My predictions',
                        ),
                        Tab(
                          text: 'Commentary',
                        ),
                        Tab(
                          text: 'Scorecard',
                        ),
                        Tab(
                          text: 'Playing11',
                        ),
                      ],
                    ),
                    Container(
                      height: 800,
                      child: TabBarView(controller: _tabController, children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: FutureBuilder<Mycontests>(
                            future: fetchContests(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              List items = snapshot.data!.data;
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    primary: true,
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: (){
                                          Constants.contestid = snapshot.data!.data[index].id;
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => new ConDetails()));
                                          print(Constants.contestid);
                                        },
                                        child: Card(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Prize Pool',
                                                          style: TextStyle(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontFamily:
                                                                  "ProductSans",
                                                              color: Colors.grey),
                                                        ),
                                                        Text(
                                                          '${snapshot.data!.data[index].prizePool}',
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontFamily:
                                                                  "ProductSans",
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Spots',
                                                          style: TextStyle(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontFamily:
                                                                  "ProductSans",
                                                              color: Colors.grey),
                                                        ),
                                                        Text(
                                                          '${snapshot.data!.data[index].totalSpots}',
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontFamily:
                                                                  "ProductSans",
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Entry',
                                                          style: TextStyle(
                                                              fontSize: 10.0,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontFamily:
                                                                  "ProductSans",
                                                              color: Colors.grey),
                                                        ),
                                                        Text(
                                                          '${snapshot.data!.data[index].entryFees}',
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontFamily:
                                                                  "ProductSans",
                                                              color:
                                                                  Colors.black),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                thickness: 1,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.trending_up),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),
                                                        Text(
                                                          '${snapshot.data!.data[index].firstPrize}',
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontFamily:
                                                                  "ProductSans",
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons.leaderboard),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),
                                                        Text(
                                                          '${snapshot.data!.data[index].winningPercentage}%',
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontFamily:
                                                                  "ProductSans",
                                                              color:
                                                                  Colors.black),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(Icons
                                                            .verified_user_outlined),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),
                                                        Text(
                                                          '${snapshot.data!.data[index].decision}',
                                                          style: TextStyle(
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              fontFamily:
                                                                  "ProductSans",
                                                              color:
                                                                  Colors.black),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              } else if (snapshot.hasError) {
                                return LinearProgressIndicator();
                              }
                              return LinearProgressIndicator();
                            },
                          ),
                        ),
                        FutureBuilder<Myteams>(
                          future: fetchTeams(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.data.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        Constants.tokenLimit = snapshot
                                            .data!.data[index].tokenLimit;
                                        Constants.contestid = snapshot
                                            .data!.data[index].contestid;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    new DiaplayPreds()));
                                      },
                                      leading: Text('#${index + 1}'),
                                      title: Text(
                                        'Prediction Card',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                      subtitle: Text(
                                        'Tap to get all cards in this team',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    );
                                  });
                            } else if (snapshot.hasError) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              FutureBuilder<Commentarymodel>(
                                  future: fetchCommentary(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<Ball> balls =
                                          snapshot.data!.data.over.balls;
                                      //List<> overs = snapshot.data!.data.over.balls;
                                      return Card(
                                        child: ListView.builder(
                                            itemCount: snapshot
                                                .data!.data.over.balls.length,
                                            shrinkWrap: true,
                                            primary: true,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: balls[index]
                                                                        .bowler
                                                                        .isWicket !=
                                                                    true
                                                                ? Text(
                                                                    balls[index]
                                                                        .teamScore
                                                                        .runs
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  )
                                                                : Text(
                                                                    'W',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: balls[index]
                                                                        .bowler
                                                                        .isWicket ==
                                                                    true
                                                                ? Colors
                                                                    .redAccent
                                                                : balls[index]
                                                                            .batsman
                                                                            .isSix ==
                                                                        true
                                                                    ? Colors
                                                                        .green
                                                                    : balls[index].batsman.isFour ==
                                                                            true
                                                                        ? Colors
                                                                            .yellow
                                                                        : Colors
                                                                            .blue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              child: Text(balls[
                                                                      index]
                                                                  .comment
                                                                  .toString()),
                                                              width: 300,
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              balls[index]
                                                                  .overs
                                                                  .toString()
                                                                  .substring(
                                                                      1, 6)
                                                                  .replaceAll(
                                                                      ',', '.'),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displayMedium,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                ],
                                              );
                                            }),
                                      );
                                    } else if (snapshot.hasError) {
                                      //print(e);
                                      print(snapshot.error);
                                    }
                                    return CircularProgressIndicator();
                                  })
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: FutureBuilder<Matchdetailsmodel>(
                              future: fetchDetails(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  Map<String, PlayerValue> players =
                                      snapshot.data!.data.players;
                                  //Map<String, PlayerValue> items = snapshot.data!.data.players;
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    mapResponse2!['data']
                                                                ['teams']['a']
                                                            ['code']
                                                        .toString(),
                                                    style: TextStyle(

                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  mapResponse2!['data']['play'] == null ? Text('0/0 (0.0)',style: TextStyle(color: Colors.black,fontSize: 18.0),) : Text(
                                                    '${snapshot.data!.data.play!.innings.a1.score.runs.toString()} / ${snapshot.data!.data.play!.innings.a1.wickets.toString()} (${snapshot.data!.data.play!.innings.a1.overs.toString().substring(1, 6).replaceAll(',', '.')})',
                                                    style: TextStyle(
                                                        color: snapshot
                                                                    .data!
                                                                    .data
                                                                    .play!
                                                                    .innings
                                                                    .a1
                                                                    .isCompleted ==
                                                                true
                                                            ? Colors.green
                                                            : Colors.redAccent,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    mapResponse2!['data']
                                                                ['teams']['b']
                                                            ['code']
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  mapResponse2!['data']['play'] == null ? Text('0/0 (0.0)',style: TextStyle(color: Colors.black,fontSize: 18.0),) : Text(
                                                    '${snapshot.data!.data.play!.innings.b1.score.runs.toString()} / ${snapshot.data!.data.play!.innings.b1.wickets.toString()} (${snapshot.data!.data.play!.innings.b1.overs.toString().substring(1, 6).replaceAll(',', '.')})',
                                                    style: TextStyle(
                                                        color: snapshot
                                                                    .data!
                                                                    .data
                                                                    .play!
                                                                    .innings
                                                                    .b1
                                                                    .isCompleted ==
                                                                true
                                                            ? Colors.green
                                                            : Colors.redAccent,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        snapshot.data!.data.status == 'completed' ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text('${snapshot.data!.data.play!.result!.msg}'),
                                              Divider(thickness: 1,),
                                            ],
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                          ),
                                        ) : Text(''),
                                        ExpansionTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(mapResponse2!['data']['teams']
                                                      ['a']['name']
                                                  .toString()),
                                              mapResponse2!['data']['play'] == null ? Text('0/0 (0.0)',style: TextStyle(color: Colors.black,fontSize: 18.0),) : Text(snapshot.data!.data.play!
                                                  .innings.a1.scoreStr
                                                  .toString())
                                            ],
                                          ),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  bottom: 8.0,
                                                  left: 8.0,
                                                  right: 20.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Batsman',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                  ),
                                                  Text(
                                                    'R',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    'B',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    '4s',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    '6s',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    'SR',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //Text(snapshot.data!.data.players.toString()),
                                            Divider(
                                              thickness: 1,
                                            ),
                                            ListView.builder(
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0,
                                                            right: 20.0,
                                                            bottom: 4.0,
                                                            left: 4.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                                width: 100,
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .data
                                                                      .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .a1
                                                                          .battingOrder[index]]!
                                                                      .player
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )),
                                                            SizedBox(
                                                              width: 50,
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .a1
                                                                          .battingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .batting!
                                                                  .score
                                                                  .runs
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                            //SizedBox(width: 20,),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .a1
                                                                          .battingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .batting!
                                                                  .score
                                                                  .balls
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            //SizedBox(width: 20,),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .a1
                                                                          .battingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .batting!
                                                                  .score
                                                                  .fours
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            //SizedBox(width: 20,),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .a1
                                                                          .battingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .batting!
                                                                  .score
                                                                  .sixes
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            //SizedBox(width: 20,),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .a1
                                                                          .battingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .batting!
                                                                  .score
                                                                  .strikeRate
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ],
                                                        ),
                                                        snapshot
                                                                    .data!
                                                                    .data
                                                                    .players[snapshot
                                                                            .data!
                                                                            .data
                                                                            .play!
                                                                            .innings
                                                                            .a1
                                                                            .battingOrder[
                                                                        index]]!
                                                                    .score
                                                                    .the1!
                                                                    .batting!
                                                                    .dismissal !=
                                                                null
                                                            ? Text(
                                                                snapshot
                                                                    .data!
                                                                    .data
                                                                    .players[snapshot
                                                                        .data!
                                                                        .data
                                                                        .play!
                                                                        .innings
                                                                        .a1
                                                                        .battingOrder[index]]!
                                                                    .score
                                                                    .the1!
                                                                    .batting!
                                                                    .dismissal!
                                                                    .msg,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .grey),
                                                              )
                                                            : Text('not out',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10)),
                                                        Divider(
                                                          thickness: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: snapshot
                                                  .data!
                                                  .data
                                                  .play == null ? 0 : snapshot
                                                  .data!
                                                  .data
                                                  .play!
                                                  .innings
                                                  .a1
                                                  .battingOrder
                                                  .length,
                                              shrinkWrap: true,
                                              primary: true,
                                              physics: ScrollPhysics(),
                                            ),
                                            Divider(
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          'Extras'
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      mapResponse2!['data']['play'] == null ? Container() : Text(
                                                          '${snapshot.data!.data.play!.innings.a1.extraRuns.extra.toString()} runs'),
                                                    ],
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                  ),
                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  snapshot.data!.data.play == null ? Container() : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          '${snapshot.data!.data.play!.innings.a1.extraRuns.wide.toString()} W'),
                                                      Text(
                                                          '${snapshot.data!.data.play!.innings.a1.extraRuns.bye.toString()} B'),
                                                      Text(
                                                          '${snapshot.data!.data.play!.innings.a1.extraRuns.noBall.toString()} N'),
                                                      Text(
                                                          '${snapshot.data!.data.play!.innings.a1.extraRuns.legBye.toString()} Lbyes'),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Total',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  snapshot.data!.data.play == null ? Container() : Text(
                                                      '${snapshot.data!.data.play!.innings.a1.score.runs.toString()} / ${snapshot.data!.data.play!.innings.a1.wickets.toString()} (${snapshot.data!.data.play!.innings.a1.overs.toString().substring(1, 6).replaceAll(',', '.')})'),
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0,
                                                  right: 20.0,
                                                  bottom: 4.0,
                                                  left: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Bowler',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SizedBox(
                                                    width: 110,
                                                  ),
                                                  Text(
                                                    'O',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    'W',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    'R',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    'M',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    'ER',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                            ),
                                            ListView.builder(
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0,
                                                            bottom: 4.0,
                                                            left: 4.0,
                                                            right: 20.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                                width: 100,
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .data
                                                                      .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .b1
                                                                          .bowlingOrder[index]]!
                                                                      .player
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )),
                                                            SizedBox(
                                                              width: 50,
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .b1
                                                                          .bowlingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .bowling!
                                                                  .score
                                                                  .overs
                                                                  .toString()
                                                                  .substring(
                                                                      1, 5)
                                                                  .replaceAll(
                                                                      ',', '.'),
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .b1
                                                                          .bowlingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .bowling!
                                                                  .score
                                                                  .wickets
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .b1
                                                                          .bowlingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .bowling!
                                                                  .score
                                                                  .runs
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .b1
                                                                          .bowlingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .bowling!
                                                                  .score
                                                                  .maidenOvers
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .b1
                                                                          .bowlingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .bowling!
                                                                  .score
                                                                  .economy
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ],
                                                        ),
                                                        Divider(
                                                          thickness: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              physics: ScrollPhysics(),
                                              primary: true,
                                              shrinkWrap: true,
                                              itemCount: snapshot
                                                  .data!
                                                  .data
                                                  .play == null ? 0 : snapshot
                                                  .data!
                                                  .data
                                                  .play!
                                                  .innings
                                                  .b1
                                                  .bowlingOrder
                                                  .length,
                                            )
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(mapResponse2!['data']['teams']
                                                      ['b']['name']
                                                  .toString()),
                                              mapResponse2!['data']['play'] == null ? Text('0/0 (0.0)',style: TextStyle(color: Colors.black,fontSize: 18.0),) : Text(snapshot.data!.data.play!
                                                  .innings.b1.scoreStr)
                                            ],
                                          ),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0,
                                                  right: 20.0,
                                                  bottom: 8.0,
                                                  left: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Batsman',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                  ),
                                                  Text(
                                                    'R',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    'B',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    '4s',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    '6s',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    'SR',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //Text(snapshot.data!.data.players.toString()),
                                            Divider(
                                              thickness: 1,
                                            ),
                                            ListView.builder(
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0,
                                                            right: 20.0,
                                                            bottom: 4.0,
                                                            left: 4.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                                width: 100,
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .data
                                                                      .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .b1
                                                                          .battingOrder[index]]!
                                                                      .player
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )),
                                                            SizedBox(
                                                              width: 50,
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .b1
                                                                          .battingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .batting!
                                                                  .score
                                                                  .runs
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                            //SizedBox(width: 20,),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .b1
                                                                          .battingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .batting!
                                                                  .score
                                                                  .balls
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            //SizedBox(width: 20,),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .b1
                                                                          .battingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .batting!
                                                                  .score
                                                                  .fours
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            //SizedBox(width: 20,),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .b1
                                                                          .battingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .batting!
                                                                  .score
                                                                  .sixes
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            //SizedBox(width: 20,),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .b1
                                                                          .battingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .batting!
                                                                  .score
                                                                  .strikeRate
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ],
                                                        ),
                                                        snapshot
                                                                    .data!
                                                                    .data
                                                                    .players[snapshot
                                                                            .data!
                                                                            .data
                                                                            .play!
                                                                            .innings
                                                                            .b1
                                                                            .battingOrder[
                                                                        index]]!
                                                                    .score
                                                                    .the1!
                                                                    .batting!
                                                                    .dismissal !=
                                                                null
                                                            ? Text(
                                                                snapshot
                                                                    .data!
                                                                    .data
                                                                    .players[snapshot
                                                                        .data!
                                                                        .data
                                                                        .play!
                                                                        .innings
                                                                        .b1
                                                                        .battingOrder[index]]!
                                                                    .score
                                                                    .the1!
                                                                    .batting!
                                                                    .dismissal!
                                                                    .msg,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .grey),
                                                              )
                                                            : Text('not out',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10)),
                                                        Divider(
                                                          thickness: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: snapshot
                                                  .data!
                                                  .data
                                                  .play == null ? 0 : snapshot
                                                  .data!
                                                  .data
                                                  .play!
                                                  .innings
                                                  .b1
                                                  .battingOrder
                                                  .length,
                                              shrinkWrap: true,
                                              primary: true,
                                              physics: ScrollPhysics(),
                                            ),
                                            Divider(
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                          'Extras'
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                      snapshot.data!.data.play == null ? Container() : Text(
                                                          '${snapshot.data!.data.play!.innings.b1.extraRuns.extra.toString()} runs'),
                                                    ],
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                  ),
                                                  SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  snapshot.data!.data.play == null ? Container() : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          '${snapshot.data!.data.play!.innings.b1.extraRuns.wide.toString()} W'),
                                                      Text(
                                                          '${snapshot.data!.data.play!.innings.b1.extraRuns.bye.toString()} B'),
                                                      Text(
                                                          '${snapshot.data!.data.play!.innings.b1.extraRuns.noBall.toString()} N'),
                                                      Text(
                                                          '${snapshot.data!.data.play!.innings.b1.extraRuns.legBye.toString()} Lbyes'),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Total',
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                  snapshot.data!.data.play == null ? Container() : Text(
                                                      '${snapshot.data!.data.play!.innings.b1.score.runs.toString()} / ${snapshot.data!.data.play!.innings.a1.wickets.toString()} (${snapshot.data!.data.play!.innings.a1.overs.toString().substring(1, 6).replaceAll(',', '.')})'),
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0,
                                                  right: 20.0,
                                                  bottom: 4.0,
                                                  left: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Bowler',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  SizedBox(
                                                    width: 110,
                                                  ),
                                                  Text(
                                                    'O',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    'W',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    'R',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    'M',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                  Text(
                                                    'ER',
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              thickness: 1,
                                            ),
                                            ListView.builder(
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0,
                                                            bottom: 4.0,
                                                            left: 4.0,
                                                            right: 20.0),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                                width: 100,
                                                                child: Text(
                                                                  snapshot
                                                                      .data!
                                                                      .data
                                                                      .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .a1
                                                                          .bowlingOrder[index]]!
                                                                      .player
                                                                      .name,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )),
                                                            SizedBox(
                                                              width: 50,
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .a1
                                                                          .bowlingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .bowling!
                                                                  .score
                                                                  .overs
                                                                  .toString()
                                                                  .substring(
                                                                      1, 5)
                                                                  .replaceAll(
                                                                      ',', '.'),
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .a1
                                                                          .bowlingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .bowling!
                                                                  .score
                                                                  .wickets
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .a1
                                                                          .bowlingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .bowling!
                                                                  .score
                                                                  .runs
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .a1
                                                                          .bowlingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .bowling!
                                                                  .score
                                                                  .maidenOvers
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .data
                                                                  .players[snapshot
                                                                          .data!
                                                                          .data
                                                                          .play!
                                                                          .innings
                                                                          .a1
                                                                          .bowlingOrder[
                                                                      index]]!
                                                                  .score
                                                                  .the1!
                                                                  .bowling!
                                                                  .score
                                                                  .economy
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ],
                                                        ),
                                                        Divider(
                                                          thickness: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              physics: ScrollPhysics(),
                                              primary: true,
                                              shrinkWrap: true,
                                              itemCount: snapshot
                                                  .data!
                                                  .data
                                                  .play == null ? 0 : snapshot
                                                  .data!
                                                  .data
                                                  .play!
                                                  .innings
                                                  .a1
                                                  .bowlingOrder
                                                  .length,
                                            )
                                          ],
                                        ),
                                      ]);
                                } else if (snapshot.hasError) {
                                  //print(e);
                                  print(snapshot.error);
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              }),
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
                                          Text(mapResponse2!['data']['teams']['a']['name'].toString()),
                                          Divider(thickness: 1,),
                                          FutureBuilder<Matchdetailsmodel>(
                                              future: fetchDetails(),
                                              builder: (context,snapshot){
                                                if(snapshot.hasData){
                                                  return ListView.builder(
                                                      itemCount: snapshot.data!.data.squad!.a.playingXi.length == 0 ? 0 : 11,
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
                                          Text(mapResponse2!['data']['teams']['b']['name'].toString()),
                                          Divider(thickness: 1,),
                                          FutureBuilder<Matchdetailsmodel>(
                                              future: fetchDetails(),
                                              builder: (context,snapshot){
                                                if(snapshot.hasData){
                                                  return ListView.builder(
                                                      itemCount: snapshot.data!.data.squad!.b.playingXi.length == 0 ? 0 : 11,
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
                      ]),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
