import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:oyee11/Widgets/displaypredictions.dart';
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/models/contestrankmodel.dart';
import 'package:oyee11/models/joincontestmodel.dart';
import 'package:oyee11/models/leaderboardmodel.dart';
import 'package:oyee11/pages/Payments/Add_funds.dart';
import 'package:oyee11/pages/Predictions/iningoptions.dart';

class ConDetails extends StatefulWidget {
  @override
  State<ConDetails> createState() => _ConDetailsState();
}

class _ConDetailsState extends State<ConDetails>
    with SingleTickerProviderStateMixin {
  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  Map? mapResponse2;
  List? listOffResponse;
  List? listOffResponse2;

  TabController? _tabController;

  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.parse(Constants.contestdetails + Constants.contestid));
    var response2 = await http.get(
        Uri.parse(Constants.contestwisepredictionsurl + Constants.contestid));
    //var response3 = await http.get(Uri.parse(Constants.lb+Constants.contestid));
    //print('response3 from here lb.php');
    //print(response3.body);
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        mapResponse2 = json.decode(response2.body);

        listOffResponse = mapResponse![''];
        listOffResponse2 = mapResponse2!['data'];
      });
    }
  }

  Future<Joincontestmodel> joinContest() async {
    var url = Uri.parse(Constants.joincontesturl);
    var response = await http.post(url, body: {
      //"amount": Constants.ammount,
      "match_id": Constants.matchid,
      "contest_id": Constants.contestid,
    });
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Joincontestmodel.fromJson(json.decode(response.body));
    } else {
      print('Failed');
    }
    throw Exception("its null");
  }

  Future updateLeaderboard() async {
    var response3 =
        await http.get(Uri.parse(Constants.lb + Constants.contestid));
    print('response3 from here lb.php');
    print(response3.body);
  }

  Future<Rankmodel> fetchContestranks() async {
    var response3 =
        await http.get(Uri.parse(Constants.rankapi + Constants.contestid));
    print(response3.body);
    print(response3.statusCode);
    if (response3.statusCode == 200) {
      return Rankmodel.fromJson(json.decode(response3.body));
    } else {
      print('Exception Hai Bhai');
    }
    throw Exception();
  }

  Future<Leadermodel> fetchleaderboard() async {
    var response = await http
        .get(Uri.parse(Constants.leaderboardapi + Constants.contestid));
    print(Constants.contestid);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Leadermodel.fromJson(json.decode(response.body));
    } else {
      print('Exception');
    }
    throw Exception();
  }

  Future<Leadermodel> fetchfinalleaderboard() async {
    var response = await http
        .get(Uri.parse(Constants.finalleaderboardapi + Constants.contestid));
    print(Constants.contestid);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return Leadermodel.fromJson(json.decode(response.body));
    } else {
      print('Exception');
    }
    throw Exception();
  }

  Widget buildSheet() => Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/if.png',
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'You Have To Add Funds To Join',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 350,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new AddFunds()));
                },
                child: Text(
                  'Add Funds',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      );

  @override
  void initState() {
    fetchData();
    Constants.matchstatus == '2' ? print('something') : updateLeaderboard();
    fetchleaderboard();
    fetchContestranks();
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
            onPressed: () {
              fetchData();
            },
            icon: Icon(Icons.refresh),
          )
        ],
        title: Text('Details'),
      ),
      body: mapResponse == null
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () {
                return fetchData();
              },
              child: Container(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Prize Pool',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          'Entry Fees',
                          style: Theme.of(context).textTheme.displayMedium,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mapResponse!['data']['prize_pool'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              mapResponse!['data']['entry_fees'],
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            SizedBox(
                              width: 14,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: Colors.redAccent,
                              ),
                              child: Text(
                                '${mapResponse!['data']['discount_entry_fees']}/-'
                                    .toString(),
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              onPressed: () {
                                Constants.ammount =
                                    mapResponse!['data']['discount_entry_fees'];
                                Constants.diaplaycounter = 0;
                                joinContest().then((value) {
                                  if (value.message ==
                                      "Maximum Contest Join Limit Reached") {
                                    Fluttertoast.showToast(msg: value.message!);
                                  } else {
                                    if (value.error != true) {
                                      Fluttertoast.showToast(
                                          msg: value.message!);
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return buildSheet();
                                          });
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: value.message!);
                                      Constants.tokenLimit =
                                          value.transactionNumber!;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  new IningsOptions()));
                                    }
                                  }
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    LinearProgressIndicator(
                      value: 0.02,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          mapResponse!['data']['total_spots'],
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        //Text(mapResponse['data'][''])
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Tooltip(
                                  message: 'First Prize Winnings',
                                  child: Icon(FontAwesomeIcons.arrowCircleUp)),
                              SizedBox(
                                width: 7,
                              ),
                              Text(mapResponse!['data']['first_prize']),
                            ],
                          ),
                          Row(
                            children: [
                              Tooltip(
                                  message:
                                      '${mapResponse!['data']['total_user_win']} Users Can Win',
                                  child: Icon(FontAwesomeIcons.trophy)),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                '${mapResponse!['data']['winning_percentage']}%',
                              ),
                            ],
                          ),
                          Tooltip(
                            message:
                                'Maximum ${mapResponse!['data']['max_entry']} Time You Can Join',
                            child: Row(
                              children: [
                                Icon(Icons.group),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(mapResponse!['data']['max_entry']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    TabBar(
                      labelColor: Colors.black,
                      labelStyle: Theme.of(context).textTheme.displayMedium,
                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: 'Winnings',
                        ),
                        Tab(
                          text: 'Leaderboard',
                        ),
                        Tab(
                          text: 'Predictions',
                        )
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        physics: ScrollPhysics(),
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(
                            child: FutureBuilder<Rankmodel>(
                              future: fetchContestranks(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Join The Contest And Predict Your Future',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Rank',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              'Winnings',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          primary: true,
                                          physics: ScrollPhysics(),
                                          itemCount: snapshot.data!.data.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '# ',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                          Text(
                                                            snapshot
                                                                .data!
                                                                .data[index]
                                                                .levelSize,
                                                            style: TextStyle(
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        snapshot
                                                            .data!
                                                            .data[index]
                                                            .levelAmount,
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  thickness: 1,
                                                )
                                              ],
                                            );
                                          }),
                                    ],
                                  );
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                          //Text(mapResponse!['data']['level_size']),
                          SingleChildScrollView(
                            child: Container(
                                child: Constants.matchstatus != '2'
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Rank'),
                                                Text('Name'),
                                                Text('Points'),
                                              ],
                                            ),
                                          ),
                                          FutureBuilder<Leadermodel>(
                                            future: fetchleaderboard(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return ListView.builder(
                                                    itemCount: snapshot.data!
                                                        .loginUserData.length,
                                                    shrinkWrap: true,
                                                    physics: ScrollPhysics(),
                                                    primary: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        children: [
                                                          ListTile(
                                                            onTap: () {
                                                              Constants
                                                                      .tokenLimit =
                                                                  snapshot
                                                                      .data!
                                                                      .loginUserData[
                                                                          index]
                                                                      .tokenLimit;
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              new DiaplayPreds()));
                                                            },
                                                            title: Row(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                      image: DecorationImage(
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          image:
                                                                              NetworkImage('${Constants.imageurl + snapshot.data!.loginUserData[index].image.toString()}'))),
                                                                  height: 40,
                                                                  width: 40,
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Text(
                                                                  '${snapshot.data!.loginUserData[index].userName.toString().substring(0)}'
                                                                      .toUpperCase(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                              ],
                                                            ),
                                                            trailing: Text(
                                                              '${snapshot.data!.loginUserData[index].point}'
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            leading: Text(
                                                              '#${snapshot.data!.loginUserData[index].rank}'
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                          )
                                                        ],
                                                      );
                                                    });
                                              } else if (snapshot.hasError) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (snapshot.data!
                                                  .loginUserData.isEmpty) {
                                                Center(
                                                  child: Text(
                                                      'Leaderboard Will Appear Here'),
                                                );
                                              }
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                          ),
                                          FutureBuilder<Leadermodel>(
                                            future: fetchleaderboard(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return ListView.builder(
                                                    itemCount: snapshot.data!
                                                        .otherUserData.length,
                                                    shrinkWrap: true,
                                                    physics: ScrollPhysics(),
                                                    primary: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Column(
                                                        children: [
                                                          ListTile(
                                                            onTap: () {
                                                              Constants
                                                                      .tokenLimit =
                                                                  snapshot
                                                                      .data!
                                                                      .otherUserData[
                                                                          index]
                                                                      .tokenLimit;
                                                              Constants.matchstatus ==
                                                                      '0'
                                                                  ? Fluttertoast
                                                                      .showToast(
                                                                          msg:
                                                                              'You can not view predictions before match starts')
                                                                  : Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              new DiaplayPreds()));
                                                            },
                                                            title: Row(
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                      image: DecorationImage(
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          image:
                                                                              NetworkImage('${Constants.imageurl + snapshot.data!.otherUserData[index].image.toString()}'))),
                                                                  height: 40,
                                                                  width: 40,
                                                                ),
                                                                SizedBox(
                                                                  width: 20,
                                                                ),
                                                                Text(
                                                                  '${snapshot.data!.otherUserData[index].userName.toString().substring(0)}'
                                                                      .toUpperCase(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                              ],
                                                            ),
                                                            trailing: Text(
                                                              '${snapshot.data!.otherUserData[index].point}'
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            leading: Text(
                                                              '#${snapshot.data!.otherUserData[index].rank}'
                                                                  .toUpperCase(),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                          )
                                                        ],
                                                      );
                                                    });
                                              } else if (snapshot.hasError) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (snapshot.data!
                                                  .otherUserData.isEmpty) {
                                                Center(
                                                  child: Text(
                                                      'Leaderboard Will Appear Here'),
                                                );
                                              }
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            },
                                          ),
                                        ],
                                      )
                                    : SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            FutureBuilder<Leadermodel>(
                                              future: fetchfinalleaderboard(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return ListView.builder(
                                                      itemCount: snapshot.data!
                                                          .loginUserData.length,
                                                      shrinkWrap: true,
                                                      physics: ScrollPhysics(),
                                                      primary: true,
                                                      reverse: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            ListTile(
                                                              onTap: () {
                                                                Constants.tokenLimit = snapshot
                                                                    .data!
                                                                    .loginUserData[
                                                                        index]
                                                                    .tokenLimit;
                                                                print(Constants
                                                                    .tokenLimit);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                new DiaplayPreds()));
                                                              },
                                                              title: Row(
                                                                children: [
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                30),
                                                                        image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            image: NetworkImage('${Constants.imageurl + snapshot.data!.loginUserData[index].image.toString()}'))),
                                                                    height: 40,
                                                                    width: 40,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Text(
                                                                    '${snapshot.data!.loginUserData[index].userName.toString().substring(0)}'
                                                                        .toUpperCase(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    'T${snapshot.data!.loginUserData[index].team}'
                                                                        .toUpperCase(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                ],
                                                              ),
                                                              trailing: Text(
                                                                  '${snapshot.data!.loginUserData[index].point}'),
                                                              subtitle: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            60.0),
                                                                child: Text(
                                                                  'Won ${snapshot.data!.loginUserData[index].amount}/-',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                              leading: Text(
                                                                  '#${snapshot.data!.loginUserData[index].rank}'),
                                                            ),
                                                            Divider(
                                                              thickness: 1,
                                                            )
                                                          ],
                                                        );
                                                      });
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else if (snapshot.data!
                                                    .loginUserData.isEmpty) {
                                                  Center(
                                                    child: Text(
                                                        'Leaderboard Will Appear Here'),
                                                  );
                                                }
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                            ),
                                            FutureBuilder<Leadermodel>(
                                              future: fetchfinalleaderboard(),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return ListView.builder(
                                                      itemCount: snapshot.data!
                                                          .otherUserData.length,
                                                      shrinkWrap: true,
                                                      physics: ScrollPhysics(),
                                                      primary: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            ListTile(
                                                              onTap: () {
                                                                Constants.tokenLimit = snapshot
                                                                    .data!
                                                                    .otherUserData[
                                                                        index]
                                                                    .tokenLimit;
                                                                print(Constants
                                                                    .tokenLimit);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                new DiaplayPreds()));
                                                              },
                                                              title: Row(
                                                                children: [
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                30),
                                                                        image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.fill,
                                                                            image: NetworkImage('${Constants.imageurl + snapshot.data!.otherUserData[index].image.toString()}'))),
                                                                    height: 40,
                                                                    width: 40,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                  Text(
                                                                    '${snapshot.data!.otherUserData[index].userName.toString().substring(0)}'
                                                                        .toUpperCase(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    'T${snapshot.data!.otherUserData[index].team}'
                                                                        .toUpperCase(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                ],
                                                              ),
                                                              trailing: Text(
                                                                  '${snapshot.data!.otherUserData[index].point}'),
                                                              subtitle: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            60.0),
                                                                child: Text(
                                                                  'Won ${snapshot.data!.otherUserData[index].amount}/-',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              ),
                                                              leading: Text(
                                                                  '#${snapshot.data!.otherUserData[index].rank}'),
                                                            ),
                                                            Divider(
                                                              thickness: 1,
                                                            )
                                                          ],
                                                        );
                                                      });
                                                } else if (snapshot.hasError) {
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else if (snapshot.data!
                                                    .otherUserData.isEmpty) {
                                                  Center(
                                                    child: Text(
                                                        'Leaderboard Will Appear Here'),
                                                  );
                                                }
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                            ),
                                          ],
                                        ),
                                      )),
                          ),
                          listOffResponse2 == null
                              ? Container(
                                  child: Center(
                                    child: Text(
                                        'Your Predictions Will Reflect Here'),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  primary: true,
                                  physics: ScrollPhysics(),
                                  itemCount: listOffResponse2 == null
                                      ? 0
                                      : listOffResponse2!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        Constants.tokenLimit =
                                            listOffResponse2![index]
                                                ['tokenLimit'];
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    new DiaplayPreds()));
                                      },
                                      title: Text('Prediction Cards',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayLarge),
                                      subtitle: Text(
                                        'Tap to get all cards in this team',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      leading: Text('#${index + 1}'),
                                    );
                                  })
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
    );
  }
}
