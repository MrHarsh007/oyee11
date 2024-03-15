import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oyee11/Widgets/homeshimmer.dart';

import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/models/mymatches.dart';
import 'package:oyee11/pages/User/joinedmatchdata.dart';

class Mymatches extends StatefulWidget {
  @override
  State<Mymatches> createState() => _MymatchesState();
}

class _MymatchesState extends State<Mymatches>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
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

  Future<Myjoinedmatches> fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(Constants.mymatches));
    if (response.statusCode == 200) {
      return Myjoinedmatches.fromJson(jsonDecode(response.body));
    } else {
      print("False");
    }
    throw Exception('Error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Matches'),
        bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.titleLarge,
            indicatorColor: Colors.white,
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  'Upcoming',
                ),
              ),
              Tab(
                child: Text(
                  'Live',
                ),
              ),
              Tab(
                child: Text(
                  'Completed',
                ),
              )
            ]),
      ),
      body: Container(
        child: TabBarView(controller: _tabController, children: <Widget>[
          FutureBuilder<Myjoinedmatches>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Datum> items = snapshot.data!.data;
                  return ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      primary: true,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (items[index].status == '0') {
                          return GestureDetector(
                            onTap: () {
                              Constants.matchid = items[index].id;
                              Constants.matchstatus = items[index].status;
                              Constants.apitoken = items[index].liveauthToken;
                              Constants.matchkey = items[index].matchKey;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          new JoinedMatchDetails()));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(items[index].leagueName),
                                        Text(items[index].contestType)
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(items[index].teamOne),
                                        Text(items[index].teamTwo)
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.network(
                                          Constants.images + items[index].image,
                                          height: 40,
                                          width: 40,
                                        ),
                                        Text(items[index].shortnameOne),
                                        Text('V/S'),
                                        Text(items[index].shortnameTwo),
                                        Image.network(
                                          Constants.images +
                                              items[index].imageTwo,
                                          height: 40,
                                          width: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(items[index].leagueType),
                                        Text(items[index].totalWinningPrice),
                                        Text(items[index].createDate.toString())
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      });
                } else if (snapshot.hasError) {
                  Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Image.asset(
                        'assets/notj.png',
                        height: 150,
                        width: 150,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('You Have Not Joined Any Upcoming Matches'),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Text(
                          'Join Contests',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        onPressed: () {},
                      )
                    ],
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      MatchCardShimmer(),
                      MatchCardShimmer(),
                      MatchCardShimmer(),
                      MatchCardShimmer(),
                      MatchCardShimmer(),
                    ],
                  ),
                );
              }),
          FutureBuilder<Myjoinedmatches>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Datum> items = snapshot.data!.data;
                  return ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      primary: true,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (items[index].status == '1') {
                          return GestureDetector(
                            onTap: () {
                              Constants.matchid = items[index].id;
                              Constants.matchstatus = items[index].status;
                              Constants.apitoken = items[index].liveauthToken;
                              Constants.matchkey = items[index].matchKey;
                              print(Constants.matchid);
                              print(Constants.apitoken);
                              print(Constants.matchkey);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          new JoinedMatchDetails()));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(items[index].leagueName),
                                        Text(items[index].contestType)
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(items[index].teamOne),
                                        Text(items[index].teamTwo)
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.network(
                                          Constants.images + items[index].image,
                                          height: 40,
                                          width: 40,
                                        ),
                                        Text(items[index].shortnameOne),
                                        Text('V/S'),
                                        Text(items[index].shortnameTwo),
                                        Image.network(
                                          Constants.images +
                                              items[index].imageTwo,
                                          height: 40,
                                          width: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(items[index].leagueType),
                                        Text(items[index].totalWinningPrice),
                                        Text(items[index].createDate.toString())
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      });
                } else if (snapshot.hasError) {
                  Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Image.asset(
                        'assets/notj.png',
                        height: 150,
                        width: 150,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('You Have Not Joined Any Live Matches'),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Text(
                          'Join Contests',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        onPressed: () {},
                      )
                    ],
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      MatchCardShimmer(),
                      MatchCardShimmer(),
                      MatchCardShimmer(),
                      MatchCardShimmer(),
                      MatchCardShimmer(),
                    ],
                  ),
                );
              }),
          FutureBuilder<Myjoinedmatches>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Datum> items = snapshot.data!.data;
                  return ListView.builder(
                      itemCount: snapshot.data!.data.length,
                      primary: true,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (items[index].status == '2') {
                          return GestureDetector(
                            onTap: () {
                              Constants.matchid = items[index].id;
                              Constants.matchstatus = items[index].status;
                              Constants.apitoken = items[index].liveauthToken;
                              Constants.matchkey = items[index].matchKey;
                              print(Constants.matchid);
                              print(Constants.apitoken);
                              print(Constants.matchkey);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          new JoinedMatchDetails()));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(items[index].leagueName),
                                        Text(items[index].contestType)
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(items[index].teamOne),
                                        Text(items[index].teamTwo)
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.network(
                                          Constants.images + items[index].image,
                                          height: 40,
                                          width: 40,
                                        ),
                                        Text(items[index].shortnameOne),
                                        Text('V/S'),
                                        Text(items[index].shortnameTwo),
                                        Image.network(
                                          Constants.images +
                                              items[index].imageTwo,
                                          height: 40,
                                          width: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(items[index].leagueType),
                                        Text(items[index].totalWinningPrice),
                                        Text(items[index].createDate.toString())
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      });
                } else if (snapshot.hasError) {
                  Column(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Image.asset(
                        'assets/notj.png',
                        height: 150,
                        width: 150,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('You Have Not Joined Any Completed Matches'),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Text(
                          'Join Contests',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        onPressed: () {},
                      )
                    ],
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      MatchCardShimmer(),
                      MatchCardShimmer(),
                      MatchCardShimmer(),
                      MatchCardShimmer(),
                      MatchCardShimmer(),
                    ],
                  ),
                );
              }),
        ]),
      ),
    );
    throw UnimplementedError();
  }
}
