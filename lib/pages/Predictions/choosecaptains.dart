import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:oyee11/Widgets/bottom_navbar.dart';
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/models/massagemodel.dart';

class ChooseCaptains extends StatefulWidget {
  const ChooseCaptains({Key? key}) : super(key: key);

  @override
  State<ChooseCaptains> createState() => _ChooseCaptainsState();
}

class _ChooseCaptainsState extends State<ChooseCaptains> {
  Map? mapResponse;
  List? listOffResponse;

  int? selectedIndex;
  String? captainsid;
  int? selectedIndex2;
  String? vicecaptainsid;

  bool inning1 = false;
  bool inning2 = false;

  Future fetchData() async {
    var response = await http.get(Uri.parse(
        '${Constants.predictionlistapi + Constants.contestid}&tokenLimit=${Constants.tokenLimit}'));
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);

        listOffResponse = mapResponse!['data'];
      });
    } else {
      print('Failed To Get Data');
    }
    throw CircularProgressIndicator();
  }

  Future<Msgmodel> apiCallPostdata() async {
    var url = Uri.parse(Constants.cpvcpapiurl);
    var response = await http.post(url, body: {
      "captainpreId": captainsid,
      "vicecaptainpreId": vicecaptainsid,
      "contestId": Constants.contestid,
      "matchId": Constants.matchid,
      "transaction_number": Constants.tokenLimit,
      "amount": Constants.ammount,
    });
    print(Constants.contestid);
    print(Constants.matchid);
    print(Constants.tokenLimit);
    print(Constants.ammount);
    print('Response status: ${response.statusCode}');
    print('response body: ${response.body}');
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return Msgmodel.fromJson(json.decode(response.body));
    } else {
      print('Failed');
    }
    throw Exception("its null");
    //return TLoginApiResponse(error: data["error"],message: data["message"]);
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
        title: Text('CAPS1 V/S CAPS2'),
        actions: [
          IconButton(
              onPressed: () {
                print(Constants.contestid);
                print(Constants.matchid);
                print(Constants.tokenLimit);
                print(Constants.ammount);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[200],
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Choose your Captain and Vice Captain',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'captain gets 2x points, VC gets 1.5x points',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 150.0, top: 8.0, bottom: 8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                inning1 = true;
                                inning2 = false;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        color: inning1 == true
                                            ? Colors.green
                                            : Colors.black,
                                        width: 1.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'INNING 1',
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                inning2 = true;
                                inning1 = false;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(
                                        color: inning2 == true
                                            ? Colors.green
                                            : Colors.black,
                                        width: 1.0)),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    'INNING 2',
                                    style: TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
                itemCount:
                    listOffResponse == null ? 0 : listOffResponse!.length,
                primary: true,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  if (inning1 == true) {
                    return Column(
                      children: [
                        listOffResponse![index]['team'] == '1'
                            ? Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/vk.jpg',
                                                ),
                                                fit: BoxFit.fill)),
                                      ),
                                      Column(
                                        children: [
                                          Text(listOffResponse![index]
                                              ['player']),
                                          if (listOffResponse![index]
                                                  ['player'] ==
                                              'Extra1') ...{
                                            Text(
                                                'on Extras in innings ${listOffResponse![index]['team']}')
                                          } else if (listOffResponse![index]
                                                  ['player'] ==
                                              'Extra2') ...{
                                            Text(
                                                'on Wides in innings ${listOffResponse![index]['team']}')
                                          } else if (listOffResponse![index]
                                                  ['player'] ==
                                              'Extra3') ...{
                                            Text(
                                                'on No balls in innings ${listOffResponse![index]['team']}')
                                          } else if (listOffResponse![index]
                                                  ['player'] ==
                                              'Extra4') ...{
                                            Text(
                                                'on Leg byes in innings ${listOffResponse![index]['team']}')
                                          } else if (listOffResponse![index]
                                                  ['player'] ==
                                              'Extra5') ...{
                                            Text(
                                                'on Final score in innings ${listOffResponse![index]['team']}')
                                          } else if (listOffResponse![index]
                                                  ['player'] ==
                                              'Extra6') ...{
                                            Text(
                                                'on FOW in innings ${listOffResponse![index]['team']}')
                                          } else ...{
                                            Text(
                                                'on ${listOffResponse![index]['type']} in innings ${listOffResponse![index]['team']}')
                                          }
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (selectedIndex2 ==
                                                        index) {
                                                      selectedIndex2 = null;
                                                      selectedIndex = index;
                                                      captainsid =
                                                          listOffResponse![
                                                              index]['id'];
                                                      print(captainsid);
                                                    } else {
                                                      selectedIndex = index;
                                                      captainsid =
                                                          listOffResponse![
                                                              index]['id'];
                                                      print(captainsid);
                                                    }
                                                  });
                                                },
                                                child: selectedIndex != index
                                                    ? Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              'c',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              'c',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  '2.0x',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (selectedIndex ==
                                                          index) {
                                                        selectedIndex = null;
                                                        selectedIndex2 = index;
                                                        vicecaptainsid =
                                                            listOffResponse![
                                                                index]['id'];
                                                        print(vicecaptainsid);
                                                      } else {
                                                        selectedIndex2 = index;
                                                        vicecaptainsid =
                                                            listOffResponse![
                                                                index]['id'];
                                                        print(vicecaptainsid);
                                                      }
                                                    });
                                                  },
                                                  child: selectedIndex2 != index
                                                      ? Container(
                                                          height: 35,
                                                          width: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Text('vc'),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 35,
                                                          width: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Text(
                                                                'vc',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  '1.5x',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    );
                  }
                  if (inning2 == true) {
                    return Column(
                      children: [
                        listOffResponse![index]['team'] == '2'
                            ? Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/vk.jpg',
                                                ),
                                                fit: BoxFit.fill)),
                                      ),
                                      Column(
                                        children: [
                                          Text(listOffResponse![index]
                                              ['player']),
                                          if (listOffResponse![index]
                                                  ['player'] ==
                                              'Extra1') ...{
                                            Text(
                                                'on Extras in innings ${listOffResponse![index]['team']}')
                                          } else if (listOffResponse![index]
                                                  ['player'] ==
                                              'Extra2') ...{
                                            Text(
                                                'on Wides in innings ${listOffResponse![index]['team']}')
                                          } else if (listOffResponse![index]
                                                  ['player'] ==
                                              'Extra3') ...{
                                            Text(
                                                'on No balls in innings ${listOffResponse![index]['team']}')
                                          } else if (listOffResponse![index]
                                                  ['player'] ==
                                              'Extra4') ...{
                                            Text(
                                                'on Leg byes in innings ${listOffResponse![index]['team']}')
                                          } else if (listOffResponse![index]
                                                  ['player'] ==
                                              'Extra5') ...{
                                            Text(
                                                'on Final score in innings ${listOffResponse![index]['team']}')
                                          } else if (listOffResponse![index]
                                                  ['player'] ==
                                              'Extra6') ...{
                                            Text(
                                                'on FOW in innings ${listOffResponse![index]['team']}')
                                          } else ...{
                                            Text(
                                                'on ${listOffResponse![index]['type']} in innings ${listOffResponse![index]['team']}')
                                          }
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (selectedIndex2 ==
                                                        index) {
                                                      selectedIndex2 = null;
                                                      selectedIndex = index;
                                                      captainsid =
                                                          listOffResponse![
                                                              index]['id'];
                                                      print(captainsid);
                                                    } else {
                                                      selectedIndex = index;
                                                      captainsid =
                                                          listOffResponse![
                                                              index]['id'];
                                                      print(captainsid);
                                                    }
                                                  });
                                                },
                                                child: selectedIndex != index
                                                    ? Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              'c',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.black,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.black),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              'c',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  '2.0x',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      if (selectedIndex ==
                                                          index) {
                                                        selectedIndex = null;
                                                        selectedIndex2 = index;
                                                        vicecaptainsid =
                                                            listOffResponse![
                                                                index]['id'];
                                                        print(vicecaptainsid);
                                                      } else {
                                                        selectedIndex2 = index;
                                                        vicecaptainsid =
                                                            listOffResponse![
                                                                index]['id'];
                                                        print(vicecaptainsid);
                                                      }
                                                    });
                                                  },
                                                  child: selectedIndex2 != index
                                                      ? Container(
                                                          height: 35,
                                                          width: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Text('vc'),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 35,
                                                          width: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.black,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(4.0),
                                                              child: Text(
                                                                'vc',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  '1.5x',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                          image: AssetImage(
                                            'assets/vk.jpg',
                                          ),
                                          fit: BoxFit.fill)),
                                ),
                                Column(
                                  children: [
                                    Text(listOffResponse![index]['player']),
                                    if (listOffResponse![index]['player'] ==
                                        'Extra1') ...{
                                      Text(
                                          'on Extras in innings ${listOffResponse![index]['team']}')
                                    } else if (listOffResponse![index]
                                            ['player'] ==
                                        'Extra2') ...{
                                      Text(
                                          'on Wides in innings ${listOffResponse![index]['team']}')
                                    } else if (listOffResponse![index]
                                            ['player'] ==
                                        'Extra3') ...{
                                      Text(
                                          'on No balls in innings ${listOffResponse![index]['team']}')
                                    } else if (listOffResponse![index]
                                            ['player'] ==
                                        'Extra4') ...{
                                      Text(
                                          'on Leg byes in innings ${listOffResponse![index]['team']}')
                                    } else if (listOffResponse![index]
                                            ['player'] ==
                                        'Extra5') ...{
                                      Text(
                                          'on Final score in innings ${listOffResponse![index]['team']}')
                                    } else if (listOffResponse![index]
                                            ['player'] ==
                                        'Extra6') ...{
                                      Text(
                                          'on FOW in innings ${listOffResponse![index]['team']}')
                                    } else ...{
                                      Text(
                                          'on ${listOffResponse![index]['type']} in innings ${listOffResponse![index]['team']}')
                                    }
                                  ],
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (selectedIndex2 == index) {
                                                selectedIndex2 = null;
                                                selectedIndex = index;
                                                captainsid =
                                                    listOffResponse![index]
                                                        ['id'];
                                                print(captainsid);
                                              } else {
                                                selectedIndex = index;
                                                captainsid =
                                                    listOffResponse![index]
                                                        ['id'];
                                                print(captainsid);
                                              }
                                            });
                                          },
                                          child: selectedIndex != index
                                              ? Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        'c',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 35,
                                                  width: 35,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Text(
                                                        'c',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            '2.0x',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (selectedIndex == index) {
                                                  selectedIndex = null;
                                                  selectedIndex2 = index;
                                                  vicecaptainsid =
                                                      listOffResponse![index]
                                                          ['id'];
                                                  print(vicecaptainsid);
                                                } else {
                                                  selectedIndex2 = index;
                                                  vicecaptainsid =
                                                      listOffResponse![index]
                                                          ['id'];
                                                  print(vicecaptainsid);
                                                }
                                              });
                                            },
                                            child: selectedIndex2 != index
                                                ? Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text('vc'),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      border: Border.all(
                                                          color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Text(
                                                          'vc',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  )),
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            '1.5x',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  return Container();
                }),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            apiCallPostdata().then((value) {
              if (value.error != true) {
                Fluttertoast.showToast(msg: value.message);
                print(value.message);
              } else {
                Fluttertoast.showToast(msg: value.message);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new NavBar()));
              }
            });
          },
          child: Text(
            'Save Team',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
