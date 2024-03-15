import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';

class AboutUs extends StatefulWidget{
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  late List? listOffResponse;
  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        '${Constants.aboutus}'));
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
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('About Us',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'ProductSans-Thin',fontSize: 25),),
      ),
      body: mapResponse == null ? Center(child: CircularProgressIndicator(color: Colors.redAccent,strokeWidth: 1,)) : SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Html(data: mapResponse!['user']['information']),
          ),
        ),
      ),
    );
    throw UnimplementedError(
    );
  }
}