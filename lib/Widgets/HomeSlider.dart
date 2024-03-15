import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';

class HomeSlider extends StatefulWidget{
  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {

  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  List? listOffResponse;

  Future fetchData() async {
    http.Response response;
    response = await http.get(Uri.parse(
        Constants.homeslider));
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
      appBar: AppBar(
        title: Text('Check'),
      ),
      body: listOffResponse == null ? Center(child: CircularProgressIndicator()) : HomeSliderWidget(listOffResponse: listOffResponse)
    );
    throw UnimplementedError();
  }
}

class HomeSliderWidget extends StatelessWidget {
  const HomeSliderWidget({
    Key? key,
    required this.listOffResponse,
  }) : super(key: key);

  final List? listOffResponse;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: listOffResponse == null ? 0 : listOffResponse!.length, itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
        Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(Constants.sliderImages+listOffResponse![itemIndex]['sliderimage']),
            fit: BoxFit.cover
          )
        ),
        ), options: CarouselOptions(
      height: 100,
      aspectRatio: 16/9,
      autoPlayCurve: Curves.fastOutSlowIn,
      autoPlay: true,
    ));
  }
}