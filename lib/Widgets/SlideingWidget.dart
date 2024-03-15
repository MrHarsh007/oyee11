

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SlideingWidget extends StatefulWidget{
  @override
  State<SlideingWidget> createState() => _SlideingWidgetState();
}

class _SlideingWidgetState extends State<SlideingWidget> {

  bool? vari;
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Slide'),
      ),
      body: Horizontalprediction(length: 11,value: false,),

    );
    throw UnimplementedError();
  }
}

class Horizontalprediction extends StatelessWidget {
  const Horizontalprediction({
    Key? key, required this.length, required this.value
  }) : super(key: key);

  final length;
  final bool value;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        primary: true,
        itemBuilder: (context, index){
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Bowler ${index+1}'),
                        Text('O  '),
                        Text('W  '),
                        Text('R  '),
                        Text('M  '),
                      ],
                    ),
                  ),
                  Divider(thickness: 1,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('${index+5} Points'),
                          SizedBox(height: 8,),
                          Text('Odd'),
                          SizedBox(height: 20,),
                          Text('Even')
                        ],
                      ),
                      Column(
                        children: [
                          Transform.scale(scale: 0.5,
                          child: CupertinoSwitch(
                            activeColor: Colors.greenAccent,
                            onChanged: (value){},value: true,
                          ),),
                          Transform.scale(scale: 0.5,
                            child: CupertinoSwitch(
                              activeColor: Colors.greenAccent,
                              onChanged: (value){},value: true,
                            ),),
                        ],
                      ),
                      Transform.scale(scale: 0.5,
                        child: CupertinoSwitch(
                          onChanged: (value){},value: false,
                        ),),
                      Transform.scale(scale: 0.5,
                        child: CupertinoSwitch(
                          onChanged: (value){},value: false,
                        ),),
                      Transform.scale(scale: 0.5,
                        child: CupertinoSwitch(
                          onChanged: (value){},value: false,
                        ),),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: length,
      ),
    );
  }
}