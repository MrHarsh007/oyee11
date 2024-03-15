import 'package:flutter/material.dart';
import 'package:oyee11/Widgets/HomeSlider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class testing extends StatefulWidget{
  @override
  State<testing> createState() => _testingState();
}

class _testingState extends State<testing> {

  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  List? listOffResponse;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        'http://starpaneldevelopers.com/api/home_slider.php'));
    if (response.statusCode == 200) {
      setState(() {
        listOffResponse = json.decode(response.body);

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
      appBar: AppBar(title: Text('Test'),),
      body: Container(
        child: Column(
          children: <Widget>[
            HomeSliderWidget(listOffResponse: listOffResponse),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}

