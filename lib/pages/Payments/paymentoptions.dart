
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:oyee11/services/addfundsservice.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentOpt extends StatefulWidget{
  @override
  State<PaymentOpt> createState() => _PaymentOptState();
}

class _PaymentOptState extends State<PaymentOpt> {


  Razorpay razorpay = Razorpay();
  @override
  void initState(){
    super.initState();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailed);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }
  @override
  void disopose(){
    razorpay.clear();
  }

  void openCheckout(){
    var options = {
      "key" : "rzp_test_248yw7qJjZLfJa",
      "amount" : num.parse(amount!)*100,
      "name" : "Oyee 11",
      "description" : "Deposite Money",
      "prefill" : {
        "contact" : Constants.mobilenumber,
        "email" : Constants.email,
      },
    };

    try{
      razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }

  _getorderid(){
    
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) async{
    final service = AddfundsApiServices();

    service.apiCallAddfund({
      "amount": Constants.addamount,
      //"transaction_id": response.paymentId,
    },).then((value){
      if(value.error != false){
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
            fontSize: 16.0
        );
        print("get data >>>>>>" + value.message!);
      }else{
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
            fontSize: 16.0
        );
        //Navigator.push(context, MaterialPageRoute(builder: (context) => new NavBar()));
        //Constants.apimessage = value.message!;
        //print(Constants.apimessage);
        //print(Constants.islogedin);
      }
      //message == value.message;
    });
  }

  void handlePaymentFailed() {
    print(Constants.mainbalance);
  }

  void handleExternalWallet(){
    print("Used External Wallet");
  }

  String? amount = Constants.addamount;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Options'),
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              tileColor: Colors.grey[200],
              title: Text('Amount To Be Added',style: Theme.of(context).textTheme.displayLarge,),
              trailing: Text('$amount'),
            ),
            SizedBox(height: 20,),
            ListTile(
              tileColor: Colors.grey[200],
              title: Text('Payment Options',style: Theme.of(context).textTheme.displayLarge,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  onTap: (){
                    openCheckout();
                  },
                  leading: Image.asset('assets/gpay.jpg',height: 40,width: 40,),
                  title: Text('Google Pay',style: Theme.of(context).textTheme.headlineMedium,),
                  subtitle: Text('Pay Using Google Pay',style: Theme.of(context).textTheme.bodySmall,),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(thickness: 2,),
                ListTile(
                  onTap: (){
                    openCheckout();
                  },
                  leading: Icon(Icons.payment,size: 35,color: Colors.black,),
                  title: Text('Cards',style: Theme.of(context).textTheme.headlineMedium,),
                  subtitle: Text('Pay Using Credit & Debit Cards',style: Theme.of(context).textTheme.bodySmall,),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(thickness: 2,),
                ListTile(
                  onTap: (){
                    openCheckout();
                  },
                  leading: Image.asset('assets/upi.png',height: 40,width: 40,),
                  title: Text('UPI',style: Theme.of(context).textTheme.headlineMedium,),
                  subtitle: Text('Pay Using UPI Wallets',style: Theme.of(context).textTheme.bodySmall,),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(thickness: 2,),
                ListTile(
                  onTap: (){
                    openCheckout();
                  },
                  leading: Icon(FontAwesomeIcons.wallet,size: 30,color: Colors.black,),
                  title: Text('Wallets',style: Theme.of(context).textTheme.headlineMedium,),
                  subtitle: Text('Pay Using Payment Wallets',style: Theme.of(context).textTheme.bodySmall,),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Divider(thickness: 2,),
                ListTile(
                  onTap: (){
                    openCheckout();
                  },
                  leading: Image.asset('assets/netbanking.png',width: 40,height: 40,),
                  title: Text('Net Banking',style: Theme.of(context).textTheme.headlineMedium,),
                  subtitle: Text('Pay Using Net Banking',style: Theme.of(context).textTheme.bodySmall,),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 80.0),
                  child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Trusted By |',style: Theme.of(context).textTheme.displayLarge,),
                        ),
                        SizedBox(width: 15,),
                        Image.asset('assets/rpay.png',width: 100,),
                      ]
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}