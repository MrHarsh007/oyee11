import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';

class DiaplayPreds extends StatefulWidget {
  const DiaplayPreds({Key? key}) : super(key: key);

  @override
  State<DiaplayPreds> createState() => _DiaplayPredsState();
}

class _DiaplayPredsState extends State<DiaplayPreds> {
  Map? mapResponse;
  List? listOffResponse;

  bool inning1 = false;
  // bool inning1 = false;
  bool inning2 = false;

  Future fetchData() async {
    var response = await http.get(Uri.parse(
        '${Constants.predictionlistapi + Constants.contestid}&tokenLimit=${Constants.tokenLimit}'));
    print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        print(response.body);

        listOffResponse = mapResponse!['data'];
      });
    } else {
      print('Failed To Get Data');
    }
    throw CircularProgressIndicator();
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
        title: Text('Predictions'),
      ),
      body: listOffResponse == null
          ? Container(
              child: Center(
                child: Text('Your Predictions Will Appear Here'),
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 120.0, top: 8.0, bottom: 8.0, right: 8.0),
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
                                    fontSize: 12.0,
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
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 600,
                  child: ListView.builder(
                      itemCount:
                          listOffResponse == null ? 0 : listOffResponse!.length,
                      itemBuilder: (context, index) {
                        if (inning1 == true) {
                          return Column(
                            children: [
                              listOffResponse![index]['team'] == '1'
                                  ? Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Prediction Card'),
                                                  Text('#${index + 1}'),
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
                                                          listOffResponse![
                                                                      index]
                                                                  ['player']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                          ))
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                          listOffResponse![
                                                                  index]['type']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
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
                                                          'Inning ${listOffResponse![index]['team']}'
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                          ))
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                          listOffResponse![
                                                                      index]
                                                                  ['value']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
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
                                                        'Points',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.0,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 4.0,
                                                      ),
                                                      Text(
                                                          '${listOffResponse![index]['point']}'
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 12.0,
                                                          ))
                                                    ],
                                                  ),
                                                  listOffResponse![index]
                                                              ['point'] !=
                                                          '0'
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 18.0),
                                                          child: Icon(
                                                            Icons
                                                                .verified_outlined,
                                                            color: Colors.green,
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 18.0),
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .circle_outlined,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ],
                                                          ))
                                                ],
                                              ),
                                            ),
                                            listOffResponse![index]
                                                        ['captain'] ==
                                                    'true'
                                                ? Center(
                                                    child: Container(
                                                      height: 15,
                                                      width: 15,
                                                      decoration: BoxDecoration(
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
                                                                  .all(1.0),
                                                          child: Text(
                                                            'c',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            listOffResponse![index]
                                                        ['vice_captain'] ==
                                                    'true'
                                                ? Center(
                                                    child: Container(
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
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
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          );
                        } else if (inning2 == true) {
                          return Column(
                            children: [
                              listOffResponse![index]['team'] == '2'
                                  ? Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('Prediction Card'),
                                                  Text('#${index + 1}'),
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
                                                          listOffResponse![
                                                                      index]
                                                                  ['player']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                          ))
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                          listOffResponse![
                                                                  index]['type']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
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
                                                          'Inning ${listOffResponse![index]['team']}'
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                          ))
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                          listOffResponse![
                                                                      index]
                                                                  ['value']
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
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
                                                        'Points',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10.0,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 4.0,
                                                      ),
                                                      Text(
                                                          '${listOffResponse![index]['point']}'
                                                              .toUpperCase(),
                                                          style: TextStyle(
                                                            color: Colors.green,
                                                            fontSize: 12.0,
                                                          ))
                                                    ],
                                                  ),
                                                  listOffResponse![index]
                                                              ['point'] !=
                                                          '0'
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 18.0),
                                                          child: Icon(
                                                            Icons
                                                                .verified_outlined,
                                                            color: Colors.green,
                                                          ),
                                                        )
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 18.0),
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .circle_outlined,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ],
                                                          ))
                                                ],
                                              ),
                                            ),
                                            listOffResponse![index]
                                                        ['captain'] ==
                                                    'true'
                                                ? Center(
                                                    child: Container(
                                                      height: 15,
                                                      width: 15,
                                                      decoration: BoxDecoration(
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
                                                                  .all(1.0),
                                                          child: Text(
                                                            'c',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                            listOffResponse![index]
                                                        ['vice_captain'] ==
                                                    'true'
                                                ? Center(
                                                    child: Container(
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
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
                                                    ),
                                                  )
                                                : Container(),
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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Prediction Card'),
                                            Text('#${index + 1}'),
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
                                                    listOffResponse![index]
                                                            ['player']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.0,
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
                                                    listOffResponse![index]
                                                            ['type']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.0,
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
                                              MainAxisAlignment.spaceBetween,
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
                                                    'Inning ${listOffResponse![index]['team']}'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.0,
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
                                                    listOffResponse![index]
                                                            ['value']
                                                        .toString()
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12.0,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Points',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10.0,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                Text(
                                                    '${listOffResponse![index]['point']}'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 12.0,
                                                    ))
                                              ],
                                            ),
                                            listOffResponse![index]['point'] !=
                                                    '0'
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 18.0),
                                                    child: Icon(
                                                      Icons.verified_outlined,
                                                      color: Colors.green,
                                                    ),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 18.0),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.circle_outlined,
                                                          color: Colors.red,
                                                        ),
                                                        Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                        ),
                                                      ],
                                                    ))
                                          ],
                                        ),
                                      ),
                                      listOffResponse![index]['captain'] ==
                                              'true'
                                          ? Center(
                                              child: Container(
                                                height: 15,
                                                width: 15,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Text(
                                                      'c',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      listOffResponse![index]['vice_captain'] ==
                                              'true'
                                          ? Center(
                                              child: Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                      'vc',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return Container();
                      }),
                ),
              ],
            ),
    );
  }
}
