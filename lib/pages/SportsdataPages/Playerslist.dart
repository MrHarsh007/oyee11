import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Players extends StatefulWidget{
  @override
  _PlayersState createState() => _PlayersState();
}

class _PlayersState extends State<Players> {

  late String search;
  TextEditingController searchController = TextEditingController();
  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  late List? listOffResponse;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://cricket.sportmonks.com/api/v2.0/players?api_token=fjLhOLVh38ZeTbBg6W6ymhM1mUbiVVdWATcbMegOso7rXDkSl3ExENN5tqvG'));
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
      appBar: AppBar(title: TextField(
        controller: searchController,
        decoration: InputDecoration(
          labelText: 'Enter Player Name',
          labelStyle: Theme.of(context).textTheme.displayMedium
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: (){
            setState(() {
              searchController.text = search;
            });
          },
        )
      ],
      backgroundColor: Colors.redAccent,
      ),
      body:mapResponse == null ? Center(child: CircularProgressIndicator()) : ListView.builder(itemBuilder: (BuildContext, index){
        return Container(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                    Text(listOffResponse![index]['fullname'],style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),),
                  ],
                ),

                Text(listOffResponse![index]['dateofbirth'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),)
              ],
            ),

          ),
        );
      },
      itemCount: listOffResponse ==  null ? 0 : listOffResponse!.length,
      ),
    );
    throw UnimplementedError();
  }
}