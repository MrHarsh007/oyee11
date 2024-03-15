import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class T20Points extends StatefulWidget{
  @override
  State<T20Points> createState() => _T20PointsState();
}

class _T20PointsState extends State<T20Points> {

  String? stringResponse;
  List? listResponse;
  late Map mapResponse;
  late List? listOffResponse;
  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://starpaneldevelopers.com/api/t_twenty_points.php?id=1'));
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
                            tileColor: Colors.white,
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Thirty Run Bonus',
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
                                              mapResponse['thirty_run_bonus'],
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
                                              mapResponse['wicket'],
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
                                  'Lbw Bonus',
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
                                              mapResponse['lbw_bowled_bonus'],
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
                                  'Three Wicket Bonus',
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
                                              mapResponse['three_wicket_bonus'],
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
                                  'Four Wicket Bonus',
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
                                              mapResponse['four_wicket_bonus'],
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
                                  'Five Wicket Bonus',
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
                                              mapResponse['five_wicket_bonus'],
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
                                  'Maiden Over Bonus',
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
                                              mapResponse['maiden_over'],
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
                                              mapResponse['catch'],
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
                                  'Three Catch Bonus',
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
                                              mapResponse['three_catch_bonus'],
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
                                  'Stumping',
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
                                              mapResponse['stumping'],
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
                                  'Runout Direct Hit',
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
                                              mapResponse['runout_direct_hit'],
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
                                  'Runout Not a Direct Hit',
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
                                              mapResponse['runout_not_a_direct_hit'],
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
                                              mapResponse['captain'],
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
                                  'Vice Captain',
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
                                              mapResponse['vice_caption'],
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
                                  'Lineups',
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
                                              mapResponse['lineups'],
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
                              title: Text('Economy Points',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),),
                              autofocus: true,
                            ),
                          ),
                          Image.asset(
                            'assets/economy_points.png',
                            fit: BoxFit.contain,
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Below Five Runs',
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
                                              mapResponse['below_five_run'],
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
                                  'Between Five Six Runs',
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
                                              mapResponse['between_five_six_run'],
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
                                  'Between Seven Six Runs',
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
                                              mapResponse['between_six_seven_run'],
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
                                  'Between ten to eleven \nruns',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.orangeAccent,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            Text('-',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            Text(
                                              mapResponse['between_ten_eleven_run'],
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
                                  'Between eleven to \ntwelve runs',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.orangeAccent,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            Text('-',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            Text(
                                              mapResponse['between_eleven_twelve_run'],
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
                                  'Above twelve runs',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.orangeAccent,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            Text('-',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            Text(
                                              mapResponse['above_twelve_run'],
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
                            padding: const EdgeInsets.only(left: 70.0),
                            child: ListTile(
                              title: Text('Strike Rate Points',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),),
                              autofocus: true,
                            ),
                          ),
                          Image.asset(
                            'assets/strike_rate.png',
                            fit: BoxFit.contain,
                          ),
                          ListTile(
                            tileColor: Colors.grey[200],
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Above 170 runs per \n100 balls',
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
                                              mapResponse['above_ohseventy'],
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
                                  'Between 150 - 170 runs \nper 100 balls',
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
                                              mapResponse['between_ohfifty_ohseventy'],
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
                                  'Between 130 - 150 runs \nper 100 balls',
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
                                              mapResponse['between_ohthirty_ohfifty'],
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
                                  'Between 60 - 70 runs per \n100 balls',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.orangeAccent,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            Text('-',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            Text(
                                              mapResponse['between_sixty_seventy'],
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
                                  'Between 50 - 59 runs per \n100 balls',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.orangeAccent,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            Text('-',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            Text(
                                              mapResponse['between_fifty_fiftynine'],
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
                                  'Below 50 runs per 100 \nballs',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.orangeAccent,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Row(
                                          children: [
                                            Text('-',style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),),
                                            Text(
                                              mapResponse['below_fifty'],
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

class MinusPointsColurContainer extends StatelessWidget {
  const MinusPointsColurContainer({
    Key? key,
    required this.mapResponse,
  }) : super(key: key);

  final Map mapResponse;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        height: 50,
        width: 50,
        color: Colors.orangeAccent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Text('-',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20),),
                Text(
                  mapResponse['duck'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PointsColourContainer extends StatelessWidget {
  final String parameter;
  const PointsColourContainer({
    Key? key,
    required this.mapResponse, 
    required this.parameter,
  }) : super(key: key);

  final Map mapResponse;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  mapResponse[parameter],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}