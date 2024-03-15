import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oyee11/Widgets/Drawer.dart';
import 'package:oyee11/Widgets/HomeSlider.dart';
import 'package:http/http.dart' as http;
import 'package:oyee11/Widgets/homeshimmer.dart';
import 'package:oyee11/constants/constants.dart';
import 'dart:convert';

import 'package:oyee11/pages/Contests/Contestjoining.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future exitDialog(){

    return showDialog(context: context, builder: (context) => new AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Text('Are You Sure?',style: Theme.of(context).textTheme.displayLarge,),
      content: Text('Are you sure? you want to exit the app',style: Theme.of(context).textTheme.titleMedium),
      actions: [
        TextButton(
          onPressed: (){
            SystemNavigator.pop();
          },
          child: Text('YES',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
        ),
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text('CANCEL',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
        ),
      ],
    ),
    );
  }
  String? postfix;
  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  Map? mapResponse2;
  List? listOffResponse;
  List? listOffResponse2;

  Future fetchData() async {
    http.Response response;
    response = await http
        .get(Uri.parse(Constants.matchlist));
    var response2 = await http.get(Uri.parse(Constants.homeslider));
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
        mapResponse = json.decode(response.body);
        listOffResponse2 = json.decode(response2.body);

        listOffResponse = mapResponse!['data'];
        //listOffResponse2 = mapResponse2![''];
      });
    }
  }

  Future refreshData() async{
    fetchData();
  }
  Future navigateScreen() async{
    Navigator.push(context, MaterialPageRoute(builder: (context) => new ContestJoin()));
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
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Home',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'CrimsonText-Regular',
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async{
              Fluttertoast.showToast(msg: 'Refreshing...');
              refreshData();
            },
          )
        ],
      ),
      body: mapResponse == null
          ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            SizedBox(height: 20,),
            SliderShimmerWidget(),
            TextHadingShimmer(),
            MatchCardShimmer(),
            MatchCardShimmer(),
            MatchCardShimmer(),
            MatchCardShimmer(),
            MatchCardShimmer(),
        ],
      ),
          )
          : RefreshIndicator(
        onRefresh: refreshData,
            child: SingleChildScrollView(
        child: Column(
              children: [
                if(mapResponse!['message'] == 'You are Unauthorised.')...{
                   Center(child: Text('You Are Unauthorised'),)
                }
                else...{
                  WillPopScope(
                    onWillPop: (){
                      exitDialog();
                      return Future.value(false);
                    },
                    child: RefreshIndicator(
                      onRefresh: (){
                        return fetchData();
                      },
                      child: SingleChildScrollView(
                          child: Container(
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: HomeSliderWidget(listOffResponse: listOffResponse2,)
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0, top: 180,bottom: 10.0),
                                  child: Text(
                                    'Upcoming Matches',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 50,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0, top: 200,right: 12.0),
                                  child: Container(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          SingleChildScrollView(
                                            child: ListView.builder(
                                              primary: false,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemBuilder: (BuildContext, index) {
                                                if(listOffResponse![index]['status'] == '0'){
                                                  return GestureDetector(
                                                    onTap: () {
                                                      Constants.matchid = listOffResponse![index]['id'];
                                                      Constants.matchstatus = listOffResponse![index]['status'];
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                              new ContestJoin()));
                                                      print(Constants.matchid);
                                                    },
                                                    child: Card(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(15)),
                                                      child: Container(
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    listOffResponse![index]
                                                                    ['league_name'],
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .displayMedium,
                                                                  ),
                                                                  Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                              15),
                                                                          border: Border.all(
                                                                              color: Colors
                                                                                  .green)),
                                                                      child: Padding(
                                                                        padding:
                                                                        const EdgeInsets
                                                                            .all(8.0),
                                                                        child: Text(
                                                                          listOffResponse![
                                                                          index][
                                                                          'contest_type'],
                                                                          style: Theme.of(
                                                                              context)
                                                                              .textTheme
                                                                              .displayMedium,
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                              Divider(
                                                                thickness: 2,
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    listOffResponse![index]
                                                                    ['team_one'],
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .displayMedium,
                                                                  ),
                                                                  Text(
                                                                    listOffResponse![index]
                                                                    ['team_two'],
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .displayMedium,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Image.network(
                                                                    Constants.images+listOffResponse![index]
                                                                    ['image'],
                                                                    height: 40,
                                                                    width: 40,
                                                                  ),
                                                                  Text(
                                                                    listOffResponse![index]
                                                                    ['shortname_one'],
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .displayLarge,
                                                                  ),
                                                                  Text(
                                                                    'V/S',
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .displayLarge,
                                                                  ),
                                                                  Text(
                                                                    listOffResponse![index]
                                                                    ['shortname_two'],
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .displayLarge,
                                                                  ),
                                                                  Image.network(
                                                                    Constants.images+listOffResponse![index]
                                                                    ['image_two'],
                                                                    height: 40,
                                                                    width: 40,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Divider(
                                                                thickness: 2,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    listOffResponse![index]
                                                                    ['league_type'],
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .displayMedium,
                                                                  ),
                                                                  Text(
                                                                    listOffResponse![index][
                                                                    'total_winning_price'],
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .displayMedium,
                                                                  ),
                                                                  Text(
                                                                    listOffResponse![index]
                                                                    ['create_date'],
                                                                    style: Theme.of(context)
                                                                        .textTheme
                                                                        .displayMedium,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return Container();
                                              },
                                              itemCount: listOffResponse == null
                                                  ? 0
                                                  : listOffResponse!.length,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ),
                  ),
                }
              ],
        ),
      ),
          ),

      drawer: MainDrawer(),
    );
    throw UnimplementedError();
  }
}
