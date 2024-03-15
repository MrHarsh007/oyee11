import 'package:flutter/cupertino.dart';

class PredTest extends StatefulWidget {

  @override
  State<PredTest> createState() => _PredTestState();
}

class _PredTestState extends State<PredTest> {
  String? predictiondata;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Transform.scale(scale: 0.5,
            child: CupertinoSwitch(
              onChanged: (value){
                if(value != true){
                  setState(() {
                    predictiondata = 'even';
                  });
                }
                else{
                  setState(() {
                    predictiondata = 'odd';
                  });
                }
              },value: false,
            ),),
          Transform.scale(scale: 0.5,
            child: CupertinoSwitch(
              onChanged: (value){},value: false,
            ),),
        ],
      ),
    );
  }
}
