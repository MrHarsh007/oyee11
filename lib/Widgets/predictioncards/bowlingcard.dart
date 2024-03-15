import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Bowlingcard extends StatefulWidget {


  @override
  State<Bowlingcard> createState() => _BowlingcardState();
}

class _BowlingcardState extends State<Bowlingcard> {

  int count = 0;
  Color oddcolor = Colors.redAccent;
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bowler 1'),
                  Text('O'),
                  Text('W'),
                  Text('M'),
                  Text('R'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Points     '),
                  Text('4'),
                  Text('10'),
                  Text('15'),
                  Text('5'),
                ],
              ),
            ),
            Divider(thickness: 1,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('ODD'),
                          SizedBox(width: 30,),
                          Transform.scale(scale: 0.5,
                            child: CupertinoSwitch(
                              onChanged: (v){
                                setState(() {
                                  count++;
                                  if(count == 1){
                                    value = true;
                                    Fluttertoast.showToast(msg: 'Pridictedd For Odd');
                                  }
                                  else if(count == 2){
                                    value = false;
                                    count = 0;
                                    Fluttertoast.showToast(msg: 'Pridictedd For Even');
                                  }
                                });
                              },
                              value: value,
                            ),
                          ),
                          SizedBox(width: 20,),
                          Transform.scale(scale: 0.5,
                            child: CupertinoSwitch(
                              onChanged: (value){},
                              value: true,
                            ),
                          ),
                          SizedBox(width: 20,),
                          Transform.scale(scale: 0.5,
                            child: CupertinoSwitch(
                              onChanged: (value){},
                              value: true,
                            ),
                          ),
                          SizedBox(width: 20,),
                          Transform.scale(scale: 0.5,
                            child: CupertinoSwitch(
                              onChanged: (value){},
                              value: true,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('EVEN'),
                          Transform.scale(scale: 0.5,
                            child: CupertinoSwitch(
                              onChanged: (value){},
                              value: true,
                            ),
                          ),
                          Transform.scale(scale: 0.5,
                            child: CupertinoSwitch(
                              onChanged: (value){},
                              value: true,
                            ),
                          ),
                          Transform.scale(scale: 0.5,
                            child: CupertinoSwitch(
                              onChanged: (value){},
                              value: true,
                            ),
                          ),
                          Transform.scale(scale: 0.5,
                            child: CupertinoSwitch(
                              onChanged: (value){},
                              value: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
