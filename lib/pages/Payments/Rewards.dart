import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/models/massagemodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Rewards extends StatefulWidget {
  @override
  State<Rewards> createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  TextEditingController codecontroller = TextEditingController();
  Future<Msgmodel> getRewared() async {
    var url = Uri.parse(Constants.rewaredurl);
    var response = await http.post(url, body: {
      "own_refer_code": codecontroller.text,
    });
    print(response.body);
    if (response.statusCode == 200) {
      return Msgmodel.fromJson(jsonDecode(response.body));
    } else {
      print('galti hai bhai');
    }
    throw Exception('');
  }

  Map? mapResponse;

  Future getData() async {
    var url = Constants.userprofile;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
      });
    } else {}
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 20.0),
                child: Text(
                  'Reward',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 145.0, top: 35.0),
                child: Text(
                  'WALLET',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 65.0),
                child: Text(
                  'Add, apply and enjoy!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0, top: 30.0),
                child: Image.asset(
                  'assets/reward.png',
                  height: 300,
                  width: 300,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 270.0, left: 8.0, right: 8.0),
                child: mapResponse == null
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : Card(
                        elevation: 7.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              mapResponse!['data']['refer_code'] == null
                                  ? TextFormField(
                                      controller: codecontroller,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          labelText: 'Enter code'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  : TextFormField(
                                      controller: codecontroller,
                                      enabled: false,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          labelText: 'You already used'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                              SizedBox(
                                height: 20,
                              ),
                              mapResponse!['data']['refer_code'] == null
                                  ? Container(
                                      width: 150,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          getRewared().then((value) {
                                            if (value.error == false) {
                                              Fluttertoast.showToast(
                                                  msg: value.message);
                                            } else {
                                              Fluttertoast.showToast(
                                                  msg: value.message);
                                            }
                                          });
                                        },
                                        child: Text(
                                          'APPLY',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2.0),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.redAccent,
                                          elevation: 7.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 150,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          Fluttertoast.showToast(
                                              msg: 'Already used');
                                        },
                                        child: Text(
                                          'APPLY',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 2.0),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.redAccent[100],
                                          elevation: 7.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
              )
            ],
          ),
        ));

    throw UnimplementedError();
  }
}
