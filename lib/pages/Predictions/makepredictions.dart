
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/Widgets/TopPrediction.dart';
import 'package:oyee11/Widgets/displaypredictions.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/models/massagemodel.dart';
import 'package:oyee11/models/predictionmodel.dart';
import 'package:oyee11/pages/Predictions/choosecaptains.dart';

import 'iningoptions.dart';

class MakePred extends StatefulWidget {
  @override
  State<MakePred> createState() => _MakePredState();
}

class _MakePredState extends State<MakePred>
    with SingleTickerProviderStateMixin {
  int value1 = 0;
  String? player;
  String? type;
  String? pvalue;
  String? side;
  bool Switchvalue = false;
  bool? Switchvalue1;
  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  Map? mapResponse2;
  List? listOffResponse;
  List? listOffResponse2;
  List<bool> switchodd = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> switch2odd = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> switch3odd = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> switch4odd = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> switcheven = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> switch2even = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> switch3even = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> switch4even = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> bowlodd = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> bowl2odd = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> bowl3odd = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> bowl4odd = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> bowleven = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> bowl2even = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> bowl3even = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> bowl4even = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<bool> extrasodd = [false, false, false, false, false, false];
  List<bool> extraseven = [false, false, false, false, false, false];
  List extras = [
    'Extras',
    'Wides',
    'No Balls',
    'Leg Byes',
    'Final Score',
    'FOW'
  ];
  List<String> predictionid = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    ''
  ];
  int currentIndex = 0;
  // int Constants.diaplaycounter = 0;
  String preid = '';

  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.parse('${Constants.matchdetail + Constants.matchid}'));
    var response2 = await http.get(Uri.parse(
        '${Constants.predictionlistapi + Constants.contestid}&tokenLimit=${Constants.tokenLimit}'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        mapResponse2 = json.decode(response2.body);
        print(response.body);
        listOffResponse = mapResponse![''];
        listOffResponse2 = mapResponse2!['data'];
      });
    }
  }

  Future<Predictionmodel> Sendprediction() async {
    var url = Uri.parse(Constants.makepredictionapi);
    var response = await http.post(url, body: {
      "contestid": Constants.contestid,
      "userid": Constants.user_id,
      "matchid": Constants.matchid,
      "team": Constants.iningid,
      "player": player,
      "type": type,
      "value": pvalue,
      "side": side,
      "tokenLimit": Constants.tokenLimit,
    });
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    //inal data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Predictionmodel.fromJson(jsonDecode(response.body));
    } else {
      print('Failed');
    }
    throw Exception("its null");
    //return TLoginApiResponse(error: data["error"],message: data["message"]);
  }

  Future<Msgmodel> unpredictApi() async {
    var url = Uri.parse(Constants.unpredictapi + preid);
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Msgmodel.fromJson(json.decode(response.body));
    } else {
      print('Failed');
    }
    throw Exception(0);
  }

  Future<Msgmodel> repredictApi() async {
    var url = Uri.parse(
        'https://starpaneldevelopers.com/api/re_predict.php?predictId=$preid');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Msgmodel.fromJson(json.decode(response.body));
    } else {
      print('Failed');
    }
    throw Exception(0);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('Point System'),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Batsman'),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('Runs'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('5-15')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Balls'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('5-15')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('4s'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('5-15')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('6s'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('5-15')
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Bowler'),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('Over'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('4')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Runs'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('5')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Maidens'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('15')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Wickets'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('10')
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Extras'),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text('Extras'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('10')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Wides'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('10')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('No balls'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('10')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Leg byes'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('10')
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Extras'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('10')
                                  ],
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  children: [
                                    Text('Wides'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('10')
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
        bottom: TabBar(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          labelStyle: Theme.of(context).textTheme.displayMedium,
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Batting',
            ),
            Tab(
              text: 'Bowling',
            ),
            Tab(
              text: 'Extras',
            ),
          ],
        ),
        title: Text('Prediction Page'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 150.0, right: 150.0, bottom: 20.0),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 20.0),
              child: Text(
                '${Constants.diaplaycounter}',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
      ),
      body: mapResponse == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Stack(
              children: [
                Constants.isSubmitted == false
                    ? TabBarView(
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                TopPred(
                                  mapResponse: mapResponse,
                                  counter: Constants.diaplaycounter,
                                ),
                                ListView.builder(
                                    itemCount: 11,
                                    shrinkWrap: true,
                                    primary: true,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (
                                      context,
                                      index,
                                    ) {
                                      return Stack(
                                        children: [
                                          Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 30.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'Player ${index + 1}'),
                                                        Text('R'),
                                                        Text('B'),
                                                        Text('4s'),
                                                        Text('6s'),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('ODD            '),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value:
                                                              switchodd[index],
                                                          onChanged: (value) {
                                                            if (switcheven[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    switcheven[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Batsman$currentIndex';
                                                                    type =
                                                                        'runs';
                                                                    pvalue =
                                                                        'odd';
                                                                    side =
                                                                        'batting';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switchodd[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switchodd[index] == false) {
                                                                                      switchodd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switchodd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (switchodd[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Batsman$currentIndex';
                                                                type = 'runs';
                                                                pvalue = 'odd';
                                                                side =
                                                                    'batting';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switchodd[index] = false,
                                                                                  Fluttertoast.showToast(msg: 'You have Predict 15 times in this Inning. Predict In Next Inning')
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switchodd[index] == false) {
                                                                                      switchodd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switchodd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (switchodd[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      switchodd[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value:
                                                              switch2odd[index],
                                                          onChanged: (value) {
                                                            if (switch2even[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    switch2even[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Batsman$currentIndex';
                                                                    type =
                                                                        'balls';
                                                                    pvalue =
                                                                        'odd';
                                                                    side =
                                                                        'batting';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switch2odd[index] = false,
                                                                                  Fluttertoast.showToast(msg: 'You have Predict 15 times in this Inning. Predict In Next Inning')
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switch2odd[index] == false) {
                                                                                      switch2odd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switch2odd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (switch2odd[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Batsman$currentIndex';
                                                                type = 'balls';
                                                                pvalue = 'odd';
                                                                side =
                                                                    'batting';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switch2odd[index] = false,
                                                                                  Fluttertoast.showToast(msg: 'You have Predict 15 times in this Inning. Predict In Next Inning')
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switch2odd[index] == false) {
                                                                                      switch2odd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switch2odd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (switch2odd[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      switch2odd[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value:
                                                              switch3odd[index],
                                                          onChanged: (value) {
                                                            if (switch3even[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    switch3even[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Batsman$currentIndex';
                                                                    type = '4s';
                                                                    pvalue =
                                                                        'odd';
                                                                    side =
                                                                        'batting';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switch3odd[index] = false,
                                                                                  Fluttertoast.showToast(msg: 'You have Predict 15 times in this Inning. Predict In Next Inning')
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switch3odd[index] == false) {
                                                                                      switch3odd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switch3odd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (switch3odd[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Batsman$currentIndex';
                                                                type = '4s';
                                                                pvalue = 'odd';
                                                                side =
                                                                    'batting';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switch3odd[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switch3odd[index] == false) {
                                                                                      switch3odd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switch3odd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (switch3odd[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      switch3odd[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value:
                                                              switch4odd[index],
                                                          onChanged: (value) {
                                                            if (switch4even[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    switch4even[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Batsman$currentIndex';
                                                                    type = '6s';
                                                                    pvalue =
                                                                        'odd';
                                                                    side =
                                                                        'batting';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switch4odd[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switch4odd[index] == false) {
                                                                                      switch4odd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switch4odd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (switch4odd[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Batsman$currentIndex';
                                                                type = '6s';
                                                                pvalue = 'odd';
                                                                side =
                                                                    'batting';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switch4odd[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switch4odd[index] == false) {
                                                                                      switch4odd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switch4odd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (switch4odd[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      switch4odd[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('EVEN           '),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value:
                                                              switcheven[index],
                                                          onChanged: (value) {
                                                            if (switchodd[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    switchodd[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Batsman$currentIndex';
                                                                    type =
                                                                        'runs';
                                                                    pvalue =
                                                                        'even';
                                                                    side =
                                                                        'batting';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switcheven[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switcheven[index] == false) {
                                                                                      switcheven[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switcheven[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (switcheven[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Batsman$currentIndex';
                                                                type = 'runs';
                                                                pvalue = 'even';
                                                                side =
                                                                    'batting';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switcheven[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switcheven[index] == false) {
                                                                                      switcheven[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switcheven[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (switcheven[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      switcheven[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value: switch2even[
                                                              index],
                                                          onChanged: (value) {
                                                            if (switch2odd[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    switch2odd[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Batsman$currentIndex';
                                                                    type =
                                                                        'balls';
                                                                    pvalue =
                                                                        'even';
                                                                    side =
                                                                        'batting';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switch2even[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switch2even[index] == false) {
                                                                                      switch2even[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switch2even[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (switch2even[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Batsman$currentIndex';
                                                                type = 'balls';
                                                                pvalue = 'even';
                                                                side =
                                                                    'batting';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switch2even[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switch2even[index] == false) {
                                                                                      switch2even[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switch2even[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (switch2even[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      switch2even[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value: switch3even[
                                                              index],
                                                          onChanged: (value) {
                                                            if (switch3odd[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    switch3odd[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Batsman$currentIndex';
                                                                    type = '4s';
                                                                    pvalue =
                                                                        'even';
                                                                    side =
                                                                        'batting';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switch3even[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switch3even[index] == false) {
                                                                                      switch3even[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switch3even[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (switch3even[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Batsman$currentIndex';
                                                                type = '4s';
                                                                pvalue = 'even';
                                                                side =
                                                                    'batting';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switch3even[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switch3even[index] == false) {
                                                                                      switch3even[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switch3even[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (switch3even[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      switch3even[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value: switch4even[
                                                              index],
                                                          onChanged: (value) {
                                                            if (switch4odd[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    switch4odd[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Batsman$currentIndex';
                                                                    type = '6s';
                                                                    pvalue =
                                                                        'even';
                                                                    side =
                                                                        'batting';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switch4even[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switch4even[index] == false) {
                                                                                      switch4even[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switch4even[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (switch4even[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Batsman$currentIndex';
                                                                type = '6s';
                                                                pvalue = 'even';
                                                                side =
                                                                    'batting';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  switch4even[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (switch4even[index] == false) {
                                                                                      switch4even[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      switch4even[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (switch4even[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      switch4even[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 370),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15)),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text('${index + 5}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.0,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                )),
                                          ),
                                        ],
                                      );
                                    }),
                                SizedBox(
                                  height: 60,
                                )
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                TopPred(
                                  mapResponse: mapResponse,
                                  counter: Constants.diaplaycounter,
                                ),
                                ListView.builder(
                                    itemCount: 8,
                                    shrinkWrap: true,
                                    primary: true,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (
                                      context,
                                      index,
                                    ) {
                                      return Stack(
                                        children: [
                                          Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 30.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                            'Bowler ${index + 1}'),
                                                        Text('O'),
                                                        Text('W'),
                                                        Text('R'),
                                                        Text('M'),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('ODD            '),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value: bowlodd[index],
                                                          onChanged: (value) {
                                                            if (bowleven[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    bowleven[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Bowler$currentIndex';
                                                                    type =
                                                                        'overs';
                                                                    pvalue =
                                                                        'odd';
                                                                    side =
                                                                        'bowling';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowlodd[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowlodd[index] == false) {
                                                                                      bowlodd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowlodd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (bowlodd[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Bowler$currentIndex';
                                                                type = 'overs';
                                                                pvalue = 'odd';
                                                                side =
                                                                    'bowling';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowlodd[index] = false,
                                                                                  Fluttertoast.showToast(msg: 'You have Predict 15 times in this Inning. Predict In Next Inning')
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowlodd[index] == false) {
                                                                                      bowlodd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowlodd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (bowlodd[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      bowlodd[index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value:
                                                              bowl2odd[index],
                                                          onChanged: (value) {
                                                            if (bowl2even[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    bowl2even[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Bowler$currentIndex';
                                                                    type =
                                                                        'wickets';
                                                                    pvalue =
                                                                        'odd';
                                                                    side =
                                                                        'bowling';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowl2odd[index] = false,
                                                                                  Fluttertoast.showToast(msg: 'You have Predict 15 times in this Inning. Predict In Next Inning')
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowl2odd[index] == false) {
                                                                                      bowl2odd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowl2odd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (bowl2odd[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Bowler$currentIndex';
                                                                type =
                                                                    'wickets';
                                                                pvalue = 'odd';
                                                                side =
                                                                    'bowling';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowl2odd[index] = false,
                                                                                  Fluttertoast.showToast(msg: 'You have Predict 15 times in this Inning. Predict In Next Inning')
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowl2odd[index] == false) {
                                                                                      bowl2odd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowl2odd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (bowl2odd[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      bowl2odd[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value:
                                                              bowl3odd[index],
                                                          onChanged: (value) {
                                                            if (bowl3even[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    bowl3even[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Bowler$currentIndex';
                                                                    type =
                                                                        'runs';
                                                                    pvalue =
                                                                        'odd';
                                                                    side =
                                                                        'bowling';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowl3odd[index] = false,
                                                                                  Fluttertoast.showToast(msg: 'You have Predict 15 times in this Inning. Predict In Next Inning')
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowl3odd[index] == false) {
                                                                                      bowl3odd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowl3odd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (bowl3odd[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Bowler$currentIndex';
                                                                type = 'runs';
                                                                pvalue = 'odd';
                                                                side =
                                                                    'bowling';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowl3odd[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowl3odd[index] == false) {
                                                                                      bowl3odd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowl3odd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (bowl3odd[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      bowl3odd[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value:
                                                              bowl4odd[index],
                                                          onChanged: (value) {
                                                            if (bowl4even[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    bowl4even[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Bowler$currentIndex';
                                                                    type =
                                                                        'maidens';
                                                                    pvalue =
                                                                        'odd';
                                                                    side =
                                                                        'bowling';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowl4odd[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowl4odd[index] == false) {
                                                                                      bowl4odd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowl4odd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (bowl4odd[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Bowler$currentIndex';
                                                                type =
                                                                    'maidens';
                                                                pvalue = 'odd';
                                                                side =
                                                                    'bowling';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowl4odd[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowl4odd[index] == false) {
                                                                                      bowl4odd[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowl4odd[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (bowl4odd[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      bowl4odd[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    thickness: 1,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text('EVEN           '),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value:
                                                              bowleven[index],
                                                          onChanged: (value) {
                                                            if (bowlodd[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    bowlodd[index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Bowler$currentIndex';
                                                                    type =
                                                                        'overs';
                                                                    pvalue =
                                                                        'even';
                                                                    side =
                                                                        'bowling';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowleven[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowleven[index] == false) {
                                                                                      bowleven[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowleven[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (bowleven[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Bowler$currentIndex';
                                                                type = 'overs';
                                                                pvalue = 'even';
                                                                side =
                                                                    'bowling';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowleven[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowleven[index] == false) {
                                                                                      bowleven[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowleven[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (bowleven[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      bowleven[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value:
                                                              bowl2even[index],
                                                          onChanged: (value) {
                                                            if (bowl2odd[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    bowl2odd[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Bowler$currentIndex';
                                                                    type =
                                                                        'wickets';
                                                                    pvalue =
                                                                        'even';
                                                                    side =
                                                                        'bowling';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowleven[index] = false,
                                                                                  Fluttertoast.showToast(msg: 'You have Predict 10 times in this innings.')
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowl2even[index] == false) {
                                                                                      bowl2even[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowl2even[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (bowl2even[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Bowler$currentIndex';
                                                                type =
                                                                    'wickets';
                                                                pvalue = 'even';
                                                                side =
                                                                    'bowling';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowl2even[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowl2even[index] == false) {
                                                                                      bowl2even[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowl2even[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (bowl2even[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      bowl2even[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value:
                                                              bowl3even[index],
                                                          onChanged: (value) {
                                                            if (bowl3odd[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    bowl3odd[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Bowler$currentIndex';
                                                                    type =
                                                                        'runs';
                                                                    pvalue =
                                                                        'even';
                                                                    side =
                                                                        'bowling';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowl3even[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowl3even[index] == false) {
                                                                                      bowl3even[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowl3even[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (bowl3even[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Bowler$currentIndex';
                                                                type = 'runs';
                                                                pvalue = 'even';
                                                                side =
                                                                    'bowling';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowl3even[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowl3even[index] == false) {
                                                                                      bowl3even[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowl3even[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (bowl3even[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      bowl3even[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                      Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                          value:
                                                              bowl4even[index],
                                                          onChanged: (value) {
                                                            if (bowl4odd[
                                                                    index] !=
                                                                false) {
                                                              preid =
                                                                  predictionid[
                                                                      index];
                                                              unpredictApi()
                                                                  .then(
                                                                      (value) {
                                                                if (value
                                                                        .error !=
                                                                    true) {
                                                                  setState(() {
                                                                    Constants
                                                                        .diaplaycounter--;
                                                                    bowl4odd[
                                                                            index] =
                                                                        false;
                                                                    currentIndex =
                                                                        index +
                                                                            1;
                                                                    player =
                                                                        'Bowler$currentIndex';
                                                                    type =
                                                                        'maidens';
                                                                    pvalue =
                                                                        'even';
                                                                    side =
                                                                        'bowling';
                                                                    //print(player);
                                                                    //print(type);
                                                                    //print(pvalue);
                                                                    Sendprediction().then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowl4even[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowl4even[index] == false) {
                                                                                      bowl4even[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowl4even[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                                  });
                                                                }
                                                              });
                                                            } else if (bowl4even[
                                                                    index] !=
                                                                true) {
                                                              setState(() {
                                                                currentIndex =
                                                                    index + 1;
                                                                player =
                                                                    'Bowler$currentIndex';
                                                                type =
                                                                    'maidens';
                                                                pvalue = 'even';
                                                                side =
                                                                    'bowling';
                                                                //print(player);
                                                                //print(type);
                                                                //print(pvalue);
                                                                Sendprediction()
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              if (value.message == 'You have Predict 10 times in this innings.')
                                                                                {
                                                                                  bowl4even[index] = false,
                                                                                }
                                                                              else if (value.error != false)
                                                                                {
                                                                                  setState(() {
                                                                                    Constants.diaplaycounter++;
                                                                                    print(value.message);
                                                                                    //print(value.data[index].id);
                                                                                    predictionid[index] = value.data![0].id;
                                                                                    if (bowl4even[index] == false) {
                                                                                      bowl4even[index] = true;
                                                                                      Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                    } else {
                                                                                      bowl4even[index] = false;
                                                                                    }
                                                                                  })
                                                                                }
                                                                              else
                                                                                {
                                                                                  print(value.message),
                                                                                }
                                                                            });
                                                              });
                                                            } else if (bowl4even[
                                                                    index] ==
                                                                true) {
                                                              setState(() {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      bowl4even[
                                                                              index] =
                                                                          false;
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    });
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value.message);
                                                                  }
                                                                });
                                                              });
                                                            }
                                                          },
                                                          activeColor: Colors
                                                              .greenAccent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                SizedBox(
                                  height: 60,
                                )
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                TopPred(
                                  mapResponse: mapResponse,
                                  counter: Constants.diaplaycounter,
                                ),
                                ListView.builder(
                                    itemCount: 6,
                                    shrinkWrap: true,
                                    primary: true,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (
                                      context,
                                      index,
                                    ) {
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(extras[index]),
                                                    Text('ODD'),
                                                    Text('EVEN'),
                                                  ],
                                                ),
                                              ),
                                              Divider(
                                                thickness: 1,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 16.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    index <= 3
                                                        ? Text('10 Points')
                                                        : Text('20 Points'),
                                                    SizedBox(
                                                      width: 0.0,
                                                    ),
                                                    Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                            value: extrasodd[
                                                                index],
                                                            onChanged: (value) {
                                                              if (extraseven[
                                                                      index] !=
                                                                  false) {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      extraseven[
                                                                              index] =
                                                                          false;
                                                                      currentIndex =
                                                                          index +
                                                                              1;
                                                                      player =
                                                                          'Extra$currentIndex';
                                                                      type =
                                                                          'Extra';
                                                                      pvalue =
                                                                          'odd';
                                                                      side =
                                                                          'extras';
                                                                      //print(player);
                                                                      //print(type);
                                                                      //print(pvalue);
                                                                      Sendprediction().then(
                                                                          (value) =>
                                                                              {
                                                                                if (value.message == 'You have Predict 10 times in this innings.')
                                                                                  {
                                                                                    extrasodd[index] = false,
                                                                                  }
                                                                                else if (value.error != false)
                                                                                  {
                                                                                    setState(() {
                                                                                      Constants.diaplaycounter++;
                                                                                      print(value.message);
                                                                                      predictionid[index] = value.data![0].id;
                                                                                      if (extrasodd[index] == false) {
                                                                                        extrasodd[index] = true;
                                                                                        Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                      } else {
                                                                                        extrasodd[index] = false;
                                                                                      }
                                                                                    })
                                                                                  }
                                                                                else
                                                                                  {
                                                                                    print(value.message),
                                                                                  }
                                                                              });
                                                                    });
                                                                  }
                                                                });
                                                              } else if (extrasodd[
                                                                      index] !=
                                                                  true) {
                                                                setState(() {
                                                                  currentIndex =
                                                                      index + 1;
                                                                  player =
                                                                      'Extra$currentIndex';
                                                                  type =
                                                                      'Extra';
                                                                  pvalue =
                                                                      'even';
                                                                  side =
                                                                      'extras';
                                                                  //print(player);
                                                                  //print(type);
                                                                  //print(pvalue);
                                                                  Sendprediction()
                                                                      .then(
                                                                          (value) =>
                                                                              {
                                                                                if (value.message == 'You have Predict 10 times in this innings.')
                                                                                  {
                                                                                    extrasodd[index] = false,
                                                                                  }
                                                                                else if (value.error != false)
                                                                                  {
                                                                                    setState(() {
                                                                                      Constants.diaplaycounter++;
                                                                                      print(value.message);
                                                                                      //print(value.data[index].id);
                                                                                      predictionid[index] = value.data![0].id;
                                                                                      if (extrasodd[index] == false) {
                                                                                        extrasodd[index] = true;
                                                                                        Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                      } else {
                                                                                        extrasodd[index] = false;
                                                                                      }
                                                                                    })
                                                                                  }
                                                                                else
                                                                                  {
                                                                                    print(value.message),
                                                                                  }
                                                                              });
                                                                });
                                                              } else if (extrasodd[
                                                                      index] ==
                                                                  true) {
                                                                setState(() {
                                                                  preid =
                                                                      predictionid[
                                                                          index];
                                                                  unpredictApi()
                                                                      .then(
                                                                          (value) {
                                                                    if (value
                                                                            .error !=
                                                                        true) {
                                                                      setState(
                                                                          () {
                                                                        Constants
                                                                            .diaplaycounter--;
                                                                        extrasodd[index] =
                                                                            false;
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                value.message);
                                                                      });
                                                                    } else {
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    }
                                                                  });
                                                                });
                                                              }
                                                            })),
                                                    SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    Transform.scale(
                                                        scale: 0.5,
                                                        child: CupertinoSwitch(
                                                            value: extraseven[
                                                                index],
                                                            onChanged: (value) {
                                                              if (extrasodd[
                                                                      index] !=
                                                                  false) {
                                                                preid =
                                                                    predictionid[
                                                                        index];
                                                                unpredictApi()
                                                                    .then(
                                                                        (value) {
                                                                  if (value
                                                                          .error !=
                                                                      true) {
                                                                    setState(
                                                                        () {
                                                                      Constants
                                                                          .diaplaycounter--;
                                                                      extrasodd[
                                                                              index] =
                                                                          false;
                                                                      currentIndex =
                                                                          index +
                                                                              1;
                                                                      player =
                                                                          'Extra$currentIndex';
                                                                      type =
                                                                          'Extra';
                                                                      pvalue =
                                                                          'even';
                                                                      side =
                                                                          'extras';
                                                                      //print(player);
                                                                      //print(type);
                                                                      //print(pvalue);
                                                                      Sendprediction().then(
                                                                          (value) =>
                                                                              {
                                                                                if (value.message == 'You have Predict 10 times in this innings.')
                                                                                  {
                                                                                    extraseven[index] = false,
                                                                                  }
                                                                                else if (value.error != false)
                                                                                  {
                                                                                    setState(() {
                                                                                      Constants.diaplaycounter++;
                                                                                      print(value.message);
                                                                                      predictionid[index] = value.data![0].id;
                                                                                      if (extraseven[index] == false) {
                                                                                        extraseven[index] = true;
                                                                                        Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                      } else {
                                                                                        extraseven[index] = false;
                                                                                      }
                                                                                    })
                                                                                  }
                                                                                else
                                                                                  {
                                                                                    print(value.message),
                                                                                  }
                                                                              });
                                                                    });
                                                                  }
                                                                });
                                                              } else if (extraseven[
                                                                      index] !=
                                                                  true) {
                                                                setState(() {
                                                                  currentIndex =
                                                                      index + 1;
                                                                  player =
                                                                      'Extra$currentIndex';
                                                                  type =
                                                                      'Extra';
                                                                  pvalue =
                                                                      'even';
                                                                  side =
                                                                      'extras';
                                                                  //print(player);
                                                                  //print(type);
                                                                  //print(pvalue);
                                                                  Sendprediction()
                                                                      .then(
                                                                          (value) =>
                                                                              {
                                                                                if (value.message == 'You have Predict 10 times in this innings.')
                                                                                  {
                                                                                    extraseven[index] = false,
                                                                                  }
                                                                                else if (value.error != false)
                                                                                  {
                                                                                    setState(() {
                                                                                      Constants.diaplaycounter++;
                                                                                      print(value.message);
                                                                                      //print(value.data[index].id);
                                                                                      predictionid[index] = value.data![0].id;
                                                                                      if (extraseven[index] == false) {
                                                                                        extraseven[index] = true;
                                                                                        Fluttertoast.showToast(msg: 'Predicted Successfully');
                                                                                      } else {
                                                                                        extraseven[index] = false;
                                                                                      }
                                                                                    })
                                                                                  }
                                                                                else
                                                                                  {
                                                                                    print(value.message),
                                                                                  }
                                                                              });
                                                                });
                                                              } else if (extraseven[
                                                                      index] ==
                                                                  true) {
                                                                setState(() {
                                                                  preid =
                                                                      predictionid[
                                                                          index];
                                                                  unpredictApi()
                                                                      .then(
                                                                          (value) {
                                                                    if (value
                                                                            .error !=
                                                                        true) {
                                                                      setState(
                                                                          () {
                                                                        Constants
                                                                            .diaplaycounter--;
                                                                        extraseven[index] =
                                                                            false;
                                                                        Fluttertoast.showToast(
                                                                            msg:
                                                                                value.message);
                                                                      });
                                                                    } else {
                                                                      Fluttertoast.showToast(
                                                                          msg: value
                                                                              .message);
                                                                    }
                                                                  });
                                                                });
                                                              }
                                                            }))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: 60,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    : listOffResponse2 == null
                        ? Container(
                            child: Center(
                              child: Text('Your Predictions Will Appear Here'),
                            ),
                          )
                        : Container(
                            child: ListView.builder(
                                itemCount: listOffResponse2 == null
                                    ? 0
                                    : listOffResponse2!.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Prediction Card'),
                                                Text('#${index + 1}')
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Player',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10.0,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4.0,
                                                    ),
                                                    Text(
                                                        listOffResponse2![index]
                                                                ['player']
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                        ))
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Predicted On',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10.0,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4.0,
                                                    ),
                                                    Text(
                                                        listOffResponse2![index]
                                                                ['type']
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Inning',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10.0,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4.0,
                                                    ),
                                                    Text(
                                                        'Inning ${listOffResponse2![index]['team']}'
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                        ))
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Predicted       ',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 10.0,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4.0,
                                                    ),
                                                    Text(
                                                        listOffResponse2![index]
                                                                ['value']
                                                            .toString()
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16.0,
                                                        ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
              ],
            )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 70.0),
        child: Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 4.0,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new DiaplayPreds()));
              },
              child: Text(
                'PREVIEW TEAM',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 4.0,
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onPressed: () {
                setState(() {
                  Constants.diaplaycounter == 10
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new IningsOptions()))
                      : Constants.diaplaycounter == 20
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => new ChooseCaptains()))
                          : Container();
                });
              },
              child: Text(
                'CONTINUE',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
