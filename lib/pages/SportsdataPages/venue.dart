import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Venues extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Venues> {
  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  late List? listOffResponse;
  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://cricket.sportmonks.com/api/v2.0/venues?api_token=fjLhOLVh38ZeTbBg6W6ymhM1mUbiVVdWATcbMegOso7rXDkSl3ExENN5tqvG'));
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
          title: Text(
            'Venues',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.redAccent,
        ),
        body: mapResponse == null ? Center(child: CircularProgressIndicator()): ListView.builder(
          itemBuilder: (BuildContext, index) {
            return Container(
              child: Column(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        height: 150,
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Text(listOffResponse![index]['name']),
                              Text(listOffResponse![index]['city']),
                              Text(listOffResponse![index]['updated_at']),
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            );
          },
          itemCount: listOffResponse == null ? 0 : listOffResponse!.length,
        ));
  }
}
