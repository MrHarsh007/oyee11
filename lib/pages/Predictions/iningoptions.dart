import 'package:flutter/material.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/pages/Predictions/makepredictions.dart';

class IningsOptions extends StatelessWidget {
  const IningsOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Inning'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40,),
          GestureDetector(
            onTap: (){
              Constants.isSubmitted = false;
              Constants.iningid = '1';
              Navigator.push(context, MaterialPageRoute(builder: (context)=> new MakePred()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                        image: DecorationImage(
                          image: AssetImage('assets/ground.png'),
                          fit: BoxFit.fill,
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Inning 1',style: Theme.of(context).textTheme.displayLarge,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Predict For Inning One',style: Theme.of(context).textTheme.bodySmall,),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Constants.iningid = '2';
              Constants.isSubmitted = false;
              Navigator.push(context, MaterialPageRoute(builder: (context)=> new MakePred()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 500,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                          image: DecorationImage(
                            image: AssetImage('assets/ground.png'),
                            fit: BoxFit.fill,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Inning 2',style: Theme.of(context).textTheme.displayLarge,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Predict For Inning Two',style: Theme.of(context).textTheme.bodySmall,),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
