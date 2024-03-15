import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/pages/Payments/paymentoptions.dart';

class AddFunds extends StatefulWidget {
  @override
  State<AddFunds> createState() => _AddFundsState();
}

class _AddFundsState extends State<AddFunds> {
  TextEditingController amountController = TextEditingController();
  String fixvalue1 = '100';
  String fixvalue2 = '250';
  String fixvalue3 = '500';
  String fixvalue4 = '1000';
  String payvalue = 'Cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Funds',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 180,
                  color: Colors.redAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Available Funds',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          Constants.availablebalance.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        maxLength: 5,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: Theme.of(context).textTheme.displayLarge,
                        controller: amountController,
                        enableSuggestions: true,
                        onChanged: (value) {
                          setState(() {
                            payvalue = amountController.text;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Enter Amount',
                          labelStyle: Theme.of(context).textTheme.displayLarge,
                          focusColor: Colors.redAccent,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.redAccent)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          child: Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                child: Text(
                                  '$fixvalue1',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                onPressed: () {
                                  setState(() {
                                    amountController.text = fixvalue1;
                                    payvalue = amountController.text;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                child: Text('$fixvalue2',
                                    style:
                                        Theme.of(context).textTheme.headlineSmall),
                                onPressed: () {
                                  setState(() {
                                    amountController.text = fixvalue2;
                                    payvalue = amountController.text;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                child: Text('$fixvalue3',
                                    style:
                                        Theme.of(context).textTheme.headlineSmall),
                                onPressed: () {
                                  setState(() {
                                    amountController.text = fixvalue3;
                                    payvalue = amountController.text;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                child: Text('$fixvalue4',
                                    style:
                                        Theme.of(context).textTheme.headlineSmall),
                                onPressed: () {
                                  setState(() {
                                    amountController.text = fixvalue4;
                                    payvalue = amountController.text;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: 370,
                  child: ElevatedButton(
                    child: Text(
                      'Add $payvalue',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new PaymentOpt()));
                      Constants.addamount = amountController.text;
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Trusted By |',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    'assets/rpay.png',
                    width: 100,
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
