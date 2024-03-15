import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'T20_pointsystem.dart';


class TestPointSystem extends StatefulWidget{
  @override
  State<TestPointSystem> createState() => _TestPointSystemState();
}

class _TestPointSystemState extends State<TestPointSystem> {

  String? stringResponse;
  List? listResponse;
  late Map mapResponse;
  late List? listOffResponse;
  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'http://starpaneldevelopers.com/api/test_points.php?id=1'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 500,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 70.0),
                            child: ListTile(
                              title: Text(
                                'Batting Points',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              autofocus: true,
                            ),
                          ),
                          Image.asset(
                            'assets/bat.png',
                            fit: BoxFit.contain,
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Run',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                PointsColourContainer(mapResponse: mapResponse, parameter: 'run',),
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.white,
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Boundary Bonus',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.greenAccent,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            Text('+',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            Text(
                                              mapResponse['boundary_bonus'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Six Bonus',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.greenAccent,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            Text('+',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            Text(
                                              mapResponse['six_bonus'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Half Century Bonus',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.greenAccent,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            Text('+',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            Text(
                                              mapResponse['half_century_bonus'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.white,
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Century Bonus',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.greenAccent,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            Text('+',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            Text(
                                              mapResponse['century_bonus'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Dismissal for a Duck',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                MinusPointsColurContainer(mapResponse: mapResponse),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  width: 500,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 70.0),
                            child: ListTile(
                              title: Text(
                                'Bowling Points',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              autofocus: true,
                            ),
                          ),
                          Image.asset(
                            'assets/bowling_points.png',
                            fit: BoxFit.contain,
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Wicket',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                PointsColourContainer(mapResponse: mapResponse, parameter: 'wicket')
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.white,
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Lbw Bonus',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                PointsColourContainer(mapResponse: mapResponse, parameter: 'lbw_bowled_bonus')
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Four Wicket Bonus',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                PointsColourContainer(mapResponse: mapResponse, parameter: 'four_wicket_bonus')
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.white,
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Five Wicket Bonus',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                PointsColourContainer(mapResponse: mapResponse, parameter: 'five_wicket_bonus')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: 500,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 100.0),
                            child: ListTile(
                              title: Text('Fielding Points',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),),
                              autofocus: true,
                            ),
                          ),
                          Image.asset(
                            'assets/field.gif',
                            fit: BoxFit.contain,
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Catch',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                PointsColourContainer(mapResponse: mapResponse, parameter: 'catch')
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Stumping',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                PointsColourContainer(mapResponse: mapResponse, parameter: 'stumping')
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.white,
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Runout Direct Hit',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                PointsColourContainer(mapResponse: mapResponse, parameter: 'runout_direct_hit')
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Runout Not a Direct Hit',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                PointsColourContainer(mapResponse: mapResponse, parameter: 'runout_not_a_direct_hit')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: 500,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 100.0),
                            child: ListTile(
                              title: Text('Other Points',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),),
                              autofocus: true,
                            ),
                          ),
                          Image.asset(
                            'assets/other_points.png',
                            fit: BoxFit.contain,
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Captain',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                PointsColourContainer(mapResponse: mapResponse, parameter: 'captain')
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.white,
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Vice Captain',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                PointsColourContainer(mapResponse: mapResponse, parameter: 'vice_caption')
                              ],
                            ),
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Lineups',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                               PointsColourContainer(mapResponse: mapResponse, parameter: 'lineups')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}