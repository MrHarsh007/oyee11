import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/pages/matchdetailslive.dart';
class LiveMatches extends StatefulWidget {
  const LiveMatches({Key? key}) : super(key: key);

  @override
  State<LiveMatches> createState() => _LiveMatchesState();
}

class _LiveMatchesState extends State<LiveMatches> {

  Map? mapResponse;
  List? listOffResponse;


  bool p1 = true;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        Constants.livematches),headers: {'rs-token': Constants.apitoken});
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        print(response.body);
        listOffResponse = mapResponse!['data']['matches'];
      });
    }
    else{
      return CircularProgressIndicator();
    }
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
        title: Text('Live Matches'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: listOffResponse == null ? 0 : listOffResponse!.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            primary: true,
            itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              Constants.matchkey = listOffResponse![index]['key'];
              print(Constants.matchkey);
              Navigator.push(context, MaterialPageRoute(builder: (context) => new MatchDatalive()));
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(listOffResponse![index]['title'],style: Theme.of(context).textTheme.displayMedium,),
                    Divider(thickness: 1,),
                    Text(listOffResponse![index]['name']),
                    //Text(listOffResponse![index]['play']['result']['msg']),

                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
