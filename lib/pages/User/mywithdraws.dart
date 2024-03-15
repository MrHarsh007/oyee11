import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:oyee11/constants/constants.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
class MyWithdraws extends StatefulWidget{
  @override
  State<MyWithdraws> createState() => _MyWithdrawsState();
}

class _MyWithdrawsState extends State<MyWithdraws> {

  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  List? listOffResponse;

  Future fetchData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');
    http.Response response;
    response = await http
        .get(Uri.parse(Constants.mywithdraws));
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
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
        title: Text('My Withdraws'),
      ),
      body: mapResponse == null ? Center(child: CircularProgressIndicator()) : Container(
        child: ListView.builder(itemBuilder: (context,index){
          return Column(
            children: [
              listOffResponse![index]['amount'] == null ?
                  Center(child: Text('No Withdraws Found'),) :
              ListTile(
                title: Text('Withdraw Request Off ${listOffResponse![index]['amount']}/-',style: Theme.of(context).textTheme.displayLarge,),
                leading: Icon(Icons.account_balance_wallet_outlined),
                subtitle: Text(listOffResponse![index]['create_date'],style: Theme.of(context).textTheme.displayMedium,),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(listOffResponse![index]['status'] == '0')...[
                      Container(color: Colors.blue[100],child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Pending'),
                      ),)
                    ]else if(listOffResponse![index]['status'] == '1')...[
                      Container(color: Colors.green[100],child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Approved'),
                      ),)
                    ]else if(listOffResponse![index]['status'] == '2')...[
                      Container(color: Colors.red[100],child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Rejected'),
                      ),)
                    ]
                  ],
                )
              ),
              Divider(thickness: 1,)
            ],
          );
        },
          itemCount: listOffResponse == null ? 0 : listOffResponse!.length,
        )
      ),
    );
    throw UnimplementedError();
  }
}