import 'package:flutter/material.dart';

import 'package:oyee11/constants/constants.dart';
class TopPred extends StatefulWidget {
  TopPred({
    Key? key,
    required this.mapResponse,
    this.counter
  }) : super(key: key);

  final Map? mapResponse;
  int? counter;

  @override
  State<TopPred> createState() => _TopPredState();
}

class _TopPredState extends State<TopPred> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ColorFiltered(
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8),
                BlendMode.dstATop),
            child: Image.asset(
              'assets/black.png',
            )),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(child: Text(widget.mapResponse!['data']['league_name'],style: TextStyle(fontSize: 14.0,color: Colors.white,fontWeight: FontWeight.bold),)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Center(child: Text('Maximum 15 predictions per inning',style: TextStyle(fontSize: 10.0,color: Colors.white,fontWeight: FontWeight.bold),)),
        ),
        Padding(
          padding: EdgeInsets.only(top: 80,left: 15,right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total \nPredictions',style: TextStyle(fontSize: 8.0,color: Colors.grey,fontWeight: FontWeight.normal),),
                      Text('20',style: TextStyle(fontSize: 30.0,color: Colors.grey,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      Image.network(Constants.images+widget.mapResponse!['data']['image'],height: 40,width: 40,),
                      SizedBox(height: 6,),
                      Text(widget.mapResponse!['data']['shortname_one'],style: TextStyle(fontSize: 14.0,color: Colors.white,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
              Text('V/S',style: TextStyle(color: Colors.white,fontSize: 14.0),),
              Row(
                children: [
                  Column(
                    children: [
                      Image.network(Constants.images+widget.mapResponse!['data']['image_two'],height: 40,width: 40,),
                      SizedBox(height: 6,),
                      Text(widget.mapResponse!['data']['shortname_two'],style: TextStyle(fontSize: 14.0,color: Colors.white,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total \nPredicted',style: TextStyle(fontSize: 8.0,color: Colors.grey,fontWeight: FontWeight.normal),),
                      Text(widget.counter.toString(),style: TextStyle(fontSize: 30.0,color: Colors.grey,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}