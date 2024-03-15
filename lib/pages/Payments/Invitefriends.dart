import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:oyee11/constants/constants.dart';
import 'package:share/share.dart';

class Invite extends StatefulWidget {
  @override
  State<Invite> createState() => _InviteState();
}

class _InviteState extends State<Invite> {
  Map? mapResponse;

  Future getData() async {
    var url = Constants.userprofile;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
      });
    } else {}
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite Friends'),
      ),
      body: mapResponse == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'INVITE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                        Text(
                          'AND',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        Text(
                          'EARN',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('You Will Earn When They Refer You'),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(
                                  mapResponse!['data']['own_refer_code'],
                                  style: Theme.of(context).textTheme.displayLarge,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: BorderSide(color: Colors.black)),
                                trailing: IconButton(
                                  icon: Icon(Icons.copy_outlined),
                                  onPressed: () {
                                    setState(() {
                                      Clipboard.setData(ClipboardData(
                                          text: mapResponse!['data']
                                              ['own_refer_code']));
                                      Fluttertoast.showToast(msg: 'Copied');
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.whatsapp,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'SHARE ON WHATSAPP',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      )
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  Share.share(
                                      'Download The App And Use My Refer code to get bonus points. My refer code is ${mapResponse!['data']['own_refer_code']}');
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
    throw UnimplementedError();
  }
}
