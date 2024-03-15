import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';
class MyTransactions extends StatefulWidget{
  @override
  State<MyTransactions> createState() => _MyTransactionsState();
}

class _MyTransactionsState extends State<MyTransactions> {

  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  List? listOffResponse;

  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.parse(Constants.mytransactions));
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
        title: Text('My Transactions'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              ListTile(
                tileColor: Colors.brown[200],
                title: Text('Description',style: Theme.of(context).textTheme.displayLarge,),
                trailing: Text('Amount'),
              ),

              ListView.builder(
                physics: ScrollPhysics(),
                primary: true,
                shrinkWrap: true,
                itemBuilder: (context,index){
                return ListTile(
                  title: Text('${listOffResponse![index]['create_date']}',style: Theme.of(context).textTheme.displayLarge,),
                  trailing: Container(
                    padding: EdgeInsets.only(left: 4.0),
                    width: 60,
                    child: Row(
                      children: [
                        Text('${listOffResponse![index]['type']}',style: TextStyle(color: listOffResponse![index]['type'] == '-' ? Colors.red : Colors.green),),
                        Text('${listOffResponse![index]['amount']}/-',style: TextStyle(color: listOffResponse![index]['type'] == '-' ? Colors.red : Colors.green),),
                      ],
                    ),
                  ),
                  subtitle: Text('Transaction id:- ${listOffResponse![index]['transaction_id']}'),
                );
              },
              itemCount: listOffResponse == null ? 0 : listOffResponse!.length,
              )
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}