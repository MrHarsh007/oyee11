import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:oyee11/Widgets/homeshimmer.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/models/joincontestmodel.dart';
import 'package:oyee11/models/mycontests.dart';
import 'dart:convert';
import 'package:oyee11/pages/Contests/contestdetails.dart';
import 'package:oyee11/pages/Payments/Add_funds.dart';
import 'package:oyee11/pages/Predictions/iningoptions.dart';

class ContestJoin extends StatefulWidget {
  @override
  State<ContestJoin> createState() => _ContestJoinState();
}

class _ContestJoinState extends State<ContestJoin>
    with SingleTickerProviderStateMixin {
  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  List? listOffResponse;

  static String match = Constants.matchid;

  bool p1 = true;

  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.parse('${Constants.contestlist + Constants.matchid}'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        print(response.body);
        listOffResponse = mapResponse!['data'];
      });
    } else {
      return CircularProgressIndicator();
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

  TabController? _tabController;
  @override
  void initState() {
    fetchData();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
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
        title: Text('Joining Page'),
        bottom: TabBar(
          labelStyle: Theme.of(context).textTheme.titleLarge,
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Contests',
            ),
            Tab(
              text: 'My Contests',
            ),
          ],
        ),
      ),
      body: mapResponse == null
          ? SingleChildScrollView(
              child: Column(
                children: [
                  MatchCardShimmer(),
                  MatchCardShimmer(),
                  MatchCardShimmer(),
                  MatchCardShimmer(),
                  MatchCardShimmer(),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () {
                return fetchData();
              },
              child: Container(
                  child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: GestureDetector(
                            onTap: () {
                              Constants.contestid =
                                  listOffResponse![index]['id'];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => new ConDetails()));
                              print(Constants.contestid);
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.verified),
                                        Text(
                                            listOffResponse![index]['decision'])
                                      ],
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Winnings',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        ),
                                        Text(
                                          'Entry Fees',
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Tooltip(
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .displayMedium,
                                            height: 20,
                                            verticalOffset: 20,
                                            preferBelow: true,
                                            message: 'Hello testing',
                                            child: Text(
                                              listOffResponse![index]
                                                      ['prize_pool']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 35),
                                            )),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor: Colors.redAccent,
                                          ),
                                          child: Text(
                                            '${listOffResponse![index]['discount_entry_fees']}/-'
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                          onPressed: () {
                                            Constants.contestid =
                                                listOffResponse![index]['id'];
                                            Constants.ammount =
                                                listOffResponse![index]
                                                    ['discount_entry_fees'];
                                            Constants.diaplaycounter = 0;
                                            joinContest().then((value) {
                                              if (value.message ==
                                                  "Maximum Contest Join Limit Reached") {
                                                Fluttertoast.showToast(
                                                    msg: value.message!);
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    ),
                                    Text(
                                      'Total Spots',
                                      style:
                                          Theme.of(context).textTheme.displayLarge,
                                    ),
                                    Text(
                                        listOffResponse![index]['total_spots']),
                                    //Text('Date:- ${listOffResponse![index]['date']}'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      thickness: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Tooltip(
                                                message: 'First Prize Winnings',
                                                child: Icon(FontAwesomeIcons
                                                    .arrowCircleUp)),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(listOffResponse![index]
                                                ['first_prize']),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Tooltip(
                                                message:
                                                    '${listOffResponse![index]['total_user_win']} Users Can Win',
                                                child: Icon(
                                                  FontAwesomeIcons.trophy,
                                                )),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(
                                              '${listOffResponse![index]['winning_percentage']}%',
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.group),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(listOffResponse![index]
                                                ['max_entry']),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount:
                        listOffResponse == null ? 0 : listOffResponse!.length,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: FutureBuilder<Mycontests>(
                      future: fetchContests(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  MatchCardShimmer(),
                                  MatchCardShimmer(),
                                  MatchCardShimmer(),
                                  MatchCardShimmer(),
                                  MatchCardShimmer(),
                                ],
                              ),
                            ),
                          );
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
                                  onTap: () {
                                    Constants.contestid =
                                        snapshot.data!.data[index].id;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                new ConDetails()));
                                  },
                                  child: Card(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                        color: Colors.black),
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
                                          padding: const EdgeInsets.all(8.0),
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
                                                        color: Colors.black),
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
                                                        color: Colors.black),
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
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
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
                      },
                    ),
                  ),
                ],
              )),
            ),
      /*floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomLeft: Radius.circular(25))),
                onPressed: (){
                 // Navigator.push(context, MaterialPageRoute(builder: (context) => new CreateContest()));
                },
                child: Row(
                  children: [
                    Text('CREATE CONTEST  ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                    Icon(Icons.add_circle_outline,size: 16,)
                  ],
                ),
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25))),
                onPressed: (){},
                child: Row(
                  children: [
                    Text('JOIN CONTEST   ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                    Icon(Icons.group_add_outlined,size: 16,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),*/
    );
  }
}
