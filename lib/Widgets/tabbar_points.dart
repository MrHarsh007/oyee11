import 'package:flutter/material.dart';

class TabBarPoints extends StatefulWidget{
  @override
  State<TabBarPoints> createState() => _TabBarState();
}

class _TabBarState extends State<TabBarPoints> with SingleTickerProviderStateMixin{

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
        title: Text(
          'Fantasy Point System',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        bottom: TabBar(
          tabs: [
            Tab(
              text: 'T20',
            ),
            Tab(
              text: 'ODI',
            ),
            Tab(
              text: 'Test',
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}