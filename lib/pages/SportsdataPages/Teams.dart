import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Teams extends StatefulWidget{
  @override
  _SeasonsState createState() => _SeasonsState();
}

class _SeasonsState extends State<Teams> {

  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  late List? listOffResponse;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://cricket.sportmonks.com/api/v2.0/teams?api_token=fjLhOLVh38ZeTbBg6W6ymhM1mUbiVVdWATcbMegOso7rXDkSl3ExENN5tqvG'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);

        listOffResponse = mapResponse!['data'];
      });
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
        title: Text('Teams Page'),
        backgroundColor: Colors.redAccent,
      ),
      body: mapResponse == null ? Center(child: CircularProgressIndicator()) : ListView.builder(itemBuilder: (BuildContext, index){
        return Container(
          child: Card(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 25,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(listOffResponse![index]['image_path']),
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Text(listOffResponse![index]['name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                  ],
                ),
                Text(listOffResponse![index]['code']),
              ],
            ),
          ),
        );
      },
        itemCount: listOffResponse == null ? 0 : listOffResponse!.length,
      ),
    );
    throw UnimplementedError();
  }
}