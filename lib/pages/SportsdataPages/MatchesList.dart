import 'package:flutter/material.dart';

class MatchList extends StatefulWidget{
  @override
  State<MatchList> createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> with SingleTickerProviderStateMixin{

  TabController? _tabController;


  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Matches',style: TextStyle(color: Colors.black,fontFamily: 'ProductSans-Thin',fontWeight: FontWeight.bold),),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Container(
              child: TabBar(
                automaticIndicatorColorAdjustment: true,
                unselectedLabelColor: Colors.redAccent,
                labelStyle: TextStyle(fontFamily: 'ProductSans-Thin',fontWeight: FontWeight.bold,fontSize: 16),
                indicatorWeight: 3,
                indicatorColor: Colors.redAccent,
                labelColor: Colors.black,
                controller: _tabController,
                tabs: [
                  Tab(
                    child: Text('Live',style: TextStyle(color: Colors.green),),
                  ),
                  Tab(
                    child: Text('Upcoming',style: TextStyle(color: Colors.blue),),
                  ),
                  Tab(
                    child: Text('Completed',style: TextStyle(color: Colors.redAccent),),
                  )
                ],
              ),
            ),
            TabBarView(children: [
              Text('1',style: TextStyle(color: Colors.black,fontSize: 30),
              ),
              Text('2'),
              Text('3')
            ])
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}