import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/pages/User/mywithdraws.dart';
import 'package:oyee11/services/withdrawservice.dart';

class Withdraw extends StatefulWidget {
  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  void callWithdrawAPI() async {
    final service = WithdrawApiServices();

    service.apiCallWithdraw(
      {
        "amount": amountcontroller.text,
      },
    ).then((value) {
      if (value.error != true) {
        setState(() {
          //Constants.islogedin = false;
        });
        Fluttertoast.showToast(
            msg: '${value.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print("get data >>>>>>" + value.message!);
      } else {
        setState(() {
          Constants.islogedin = true;
          //message = value.message;
        });
        Fluttertoast.showToast(
            msg: '${value.message}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => new MyWithdraws()));
        //Constants.apimessage = value.message!;
        //print(Constants.apimessage);
        //print(Constants.islogedin);
      }
      //message == value.message;
    });
  }

  TextEditingController amountcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdraw'),
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Available Balance',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              trailing: Text(Constants.availablebalance.toString()),
            ),
            SizedBox(
              height: 50,
            ),
            Card(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: amountcontroller,
                      style: Theme.of(context).textTheme.displayLarge,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Enter Amount',
                        labelStyle: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                  ),
                  Container(
                    width: 350,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        callWithdrawAPI();
                      },
                      child: Text(
                        'WITHDRAW NOW',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Note:- Minimum Withdraw is 50/-',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
