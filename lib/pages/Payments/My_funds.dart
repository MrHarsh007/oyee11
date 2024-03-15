import 'package:flutter/material.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/pages/Payments/Add_funds.dart';
import 'package:oyee11/pages/Payments/my%20transactions.dart';
import 'package:oyee11/pages/Payments/withdraw.dart';
import 'package:oyee11/pages/User/kycpage.dart';
import 'package:oyee11/pages/User/mywithdraws.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyFunds extends StatefulWidget {
  @override
  State<MyFunds> createState() => _MyFundsState();
}

class _MyFundsState extends State<MyFunds> {
  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  Map? mapResponse2;
  List? listOffResponse;

  String? token;

  Future fetchData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    http.Response response;
    response = await http.get(Uri.parse(Constants.walleturl));
    var response2 = await http.get(Uri.parse(Constants.userprofile));
    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
        print(response2.body);
        mapResponse = json.decode(response.body);
        mapResponse2 = json.decode(response2.body);

        listOffResponse = mapResponse![''];
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  bool isVerified = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'My Funds',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: mapResponse == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Card(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Available Funds',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              Center(
                                  child: Padding(
                                padding: const EdgeInsets.only(top: .0),
                                child: mapResponse!['data'] != null
                                    ? Text(
                                        mapResponse!['data']['total_amount'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 50),
                                      )
                                    : Text(
                                        '0',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 50),
                                      ),
                              )),
                              ElevatedButton(
                                onPressed: () {
                                  Constants.availablebalance =
                                      mapResponse!['data']['total_amount'];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              new AddFunds()));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                child: Text(
                                  'Add Funds',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        mapResponse2!['data']['is_verified'] == '0'
                            ? ListTile(
                                tileColor: Colors.white,
                                leading: Icon(
                                  Icons.wallet_travel_rounded,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  'Winnings Amount',
                                  style: Theme.of(context).textTheme.displayLarge,
                                ),
                                subtitle: Text(
                                  '46.00',
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    Constants.availablebalance =
                                        mapResponse!['data']['total_amount'];
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                new Withdraw()));
                                  },
                                  child: Text(
                                    'Withdraw',
                                    style:
                                        Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.green,
                                  ),
                                ),
                              )
                            : ListTile(
                                tileColor: Colors.white,
                                leading: Icon(
                                  Icons.wallet_travel_rounded,
                                  color: Colors.black,
                                ),
                                title: Text(
                                  'Winnings Amount',
                                  style: Theme.of(context).textTheme.displayLarge,
                                ),
                                subtitle: Text(
                                  'Verify kyc to eligible \nfor withdraw',
                                  style: Theme.of(context).textTheme.displayMedium,
                                ),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => new KYC()));
                                  },
                                  child: Text(
                                    'Verify',
                                    style:
                                        Theme.of(context).textTheme.headlineSmall,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: Colors.green,
                                  ),
                                ),
                              ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        new MyTransactions()));
                          },
                          tileColor: Colors.white,
                          leading: Icon(
                            Icons.compare_arrows_outlined,
                            color: Colors.black,
                          ),
                          title: Text(
                            'My Transactions',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          subtitle: Text(
                            'Details of funds use',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new MyWithdraws()));
                          },
                          tileColor: Colors.white,
                          leading: Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Colors.black,
                          ),
                          title: Text(
                            'My Withdraws',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          subtitle: Text(
                            'Details of your withdraws',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        ListTile(
                          tileColor: Colors.white,
                          leading: Icon(
                            Icons.payment,
                            color: Colors.black,
                          ),
                          title: Text(
                            'Edit Payments Details',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          subtitle: Text(
                            'UPI/Credit Cards/Debit Cards/Net banking',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
