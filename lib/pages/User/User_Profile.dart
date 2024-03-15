import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/pages/Payments/My_funds.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Profile extends StatefulWidget{
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String? stringResponse;
  List? listResponse;
  Map ?  mapResponse;
  List? listOffResponse;

  String? token;

  TabController? _tabController;

  Future fetchData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    http.Response response;
    response = await http.get(Uri.parse(
        Constants.userprofile));
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
        mapResponse = json.decode(response.body);

        listOffResponse = mapResponse![''];
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
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => new MyFunds()));
            },
            icon: Icon(Icons.account_balance_wallet),
          )
        ],
      ),
      body: mapResponse == null ? Center(child: CircularProgressIndicator(),) : Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              mapResponse!['data']['image'] == null ?Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 2
                      )
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image:  AssetImage('assets/vk.jpg'),
                        fit: BoxFit.contain
                    )
                ),
              ) : Container(
                height: 120,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2
                      )
                    ],
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image:  NetworkImage('http://oyee11.com/api/verify_user/${mapResponse!['data']['image']}'),
                        fit: BoxFit.contain
                    )
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => new EditProfile()));
                        },
                        child: Container(
                          width: 150,
                          color: Colors.redAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Edit Profile',style: Theme.of(context).textTheme.headlineSmall,),
                                Text('Coming soon',style: Theme.of(context).textTheme.titleLarge,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> new MyFunds()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 150,
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text('Available Funds',style: Theme.of(context).textTheme.headlineSmall,),
                                Text('Tap to get',style: Theme.of(context).textTheme.titleLarge,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  child: ListTile(
                    title: Text('Username',style: Theme.of(context).textTheme.displayMedium,),
                    subtitle: Text(mapResponse!['data']['user_name'],style: Theme.of(context).textTheme.displayLarge,),
                    trailing: Icon(Icons.person,color: Colors.black,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  child: ListTile(
                    title: Text('Email',style: Theme.of(context).textTheme.displayMedium,),
                    subtitle: Text(mapResponse!['data']['email'],style: Theme.of(context).textTheme.displayLarge,),
                    trailing: Icon(Icons.mail_outline,color: Colors.black,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  child: ListTile(
                    title: Text('Mobile Number',style: Theme.of(context).textTheme.displayMedium,),
                    subtitle: Text('+91 ${mapResponse!['data']['mobile_number']}',style: Theme.of(context).textTheme.displayLarge,),
                    trailing: Icon(Icons.mobile_friendly,color: Colors.black,),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  child: ListTile(
                    title: Text('Level',style: Theme.of(context).textTheme.displayMedium,),
                    subtitle: Text('Level 5',style: Theme.of(context).textTheme.displayLarge,),
                    trailing: Icon(Icons.leaderboard_outlined,color: Colors.black,),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}