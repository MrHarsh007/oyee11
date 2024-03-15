import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:oyee11/models/contestdetails.dart';

class ContestSolutuion extends StatefulWidget{
  @override
  State<ContestSolutuion> createState() => _ContestSolutuionState();
}

class _ContestSolutuionState extends State<ContestSolutuion> {


  Future<List<Contestmodel>> getContest() async{
    var response = await http.get(Uri.parse('https://starpaneldevelopers.com/api/contestList.php?matchid=32'));
    if(response.statusCode == 200){
      print(response.body);
      var jsonString = response.body;
      contestmodelFromJson(jsonString);
    }else{
    }
    throw{
    };
  }

  var contestList = <Contestmodel>[];
  @override
  void initState() {
    getContest();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lets Test'),
      ),
      body: Container(
        child: ListView.builder(itemBuilder: (context,index){
          return Text(contestList[index].data.toString());
        },
        itemCount: contestList.length,
        ),
      ),
    );
    throw UnimplementedError();
  }
}