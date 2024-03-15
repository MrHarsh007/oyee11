import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BrowseTeams extends StatefulWidget {
  @override
  _BrowseTeamsState createState() => _BrowseTeamsState();
}

class _BrowseTeamsState extends State<BrowseTeams> {
  String? stringResponse;
  List? listResponse;
  late Map mapResponse;
  late List? listOffResponse;

  TextEditingController teamid = new TextEditingController();
  static String T_id = '48';

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'https://cricket.sportmonks.com/api/v2.0/teams/$T_id?api_token=dvGo15p7zcM6qN7pqvKkOF6Em9Twt21xtFqM39aEN6TIi24vZqvJc0rvFKf8'));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
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
          title: Text('Browse Teams'),
        ),
        body: mapResponse == null
            ? CircularProgressIndicator()
            : Container(
                child: Center(
                  child: Column(
                    children: [
                      TextField(
                        controller: teamid,
                        decoration: InputDecoration(hintText: 'Enter Team Id'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          T_id = teamid.text;
                          fetchData();
                        },
                        child: Text('Browse'),
                      ),
                      Text(mapResponse['data']['name']),
                      Text(mapResponse['data']['updated_at']),
                      Image.network(mapResponse['data']['image_path'])
                    ],
                  ),
                ),
              ));
    throw UnimplementedError();
  }
}
