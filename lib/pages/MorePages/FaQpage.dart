import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';

class FaQ extends StatefulWidget{
  @override
  State<FaQ> createState() => _faqState();
}

class _faqState extends State<FaQ> {

  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  List? listOffResponse;
  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        '${Constants.faqpage}'));
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
        mapResponse = json.decode(response.body);
        listOffResponse = mapResponse!['user'];
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
        title: Text('Frequently Asked Questions',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontFamily: 'ProductSans-Thin',fontSize: 25),),
      ),
      body: Container(

        child: ListView.builder(itemBuilder: (BuildContext, index){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                child: ExpansionTile(
                  leading: Icon(Icons.add_circle_outline),
                  subtitle: Text('Tap For Answer'),
                    initiallyExpanded: false,
                    title: Html(data: listOffResponse![index]['faq_que'],
                    ),
                  trailing: Text(listOffResponse![index]['created']),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0,left: 60),
                      child: Html(data: listOffResponse![index]['faq_ans']),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              )
            ],
          );
        },
        itemCount: listOffResponse == null ? 0 : listOffResponse!.length,
        ),
      ),
    );
    throw UnimplementedError();
  }
}
