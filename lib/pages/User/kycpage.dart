import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:oyee11/constants/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class KYC extends StatefulWidget {
  @override
  State<KYC> createState() => _KYCState();
}

class _KYCState extends State<KYC> {
  bool isSubmitted = false;

  String? stringResponse;
  List? listResponse;
  Map? mapResponse;
  List? listOffResponse;

  String? token;

  TabController? _tabController;

  Future fetchData() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    http.Response response;
    response = await http.get(Uri.parse(Constants.userprofile));
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

  TextEditingController panname = TextEditingController();
  TextEditingController pannum = TextEditingController();
  TextEditingController bankname = TextEditingController();
  TextEditingController bankacnum = TextEditingController();
  TextEditingController bankifsc = TextEditingController();
  /*void callKYCapi(){
    final service = KYCApiServices();

    service.apiCallKYC({
      "pan_name": panname.text,
      "pan_number": pannum.text,
      "bank_name": bankname.text,
      "bank_account_number": bankacnum.text,
      "bank_ifsc": bankifsc.text,
      "sendimage": image!.path,
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
  }*/
  File? image;
  final picker = ImagePicker();

  Future selectImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage!.path);
    });
  }

  Future uploadKyc() async {
    final uri = Uri.parse(
        'http://starpaneldevelopers.com/api/add_verify.php?u_v_id=44');
    var request = http.MultipartRequest("POST", uri);
    request.fields['pan_name'] = panname.text;
    request.fields['pan_number'] = pannum.text;
    request.fields['bank_name'] = bankname.text;
    request.fields['bank_account_number'] = bankacnum.text;
    request.fields['bank_ifsc'] = bankifsc.text;
    var pic = await http.MultipartFile.fromPath("sendimage", image!.path);

    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Success');
    } else {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kyc'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: mapResponse!['data']['status'] != '1'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Image.asset('assets/kycpending.jpg'),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Your KYC Is Under Review',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fill your pan card details here'),
                            Divider(
                              thickness: 1,
                            ),
                            TextFormField(
                              style: TextStyle(),
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              controller: panname,
                              decoration: InputDecoration(
                                  labelText: 'Name As PAN',
                                  labelStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  helperText: 'Enter Full Name as PAN',
                                  helperStyle:
                                      Theme.of(context).textTheme.displaySmall),
                            ),
                            TextFormField(
                              controller: pannum,
                              maxLength: 10,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              decoration: InputDecoration(
                                  labelText: 'PAN Number',
                                  labelStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  helperText: 'Enter 10 digit PAN Number',
                                  helperStyle:
                                      Theme.of(context).textTheme.displaySmall),
                            ),
                            //DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now()),
                            /*TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Date Of Birth',
                            labelStyle: Theme.of(context).textTheme.headline2,
                            helperText: 'Enter DOB as PAN',
                            helperStyle: Theme.of(context).textTheme.headline3
                        ),
                      ),*/
                            GestureDetector(
                              onTap: () {
                                selectImage();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 25,
                                      ),
                                      Text(
                                        'UPLOAD YOUR PAN IMAGE',
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            image != null
                                ? Image.file(
                                    File(image!.path).absolute,
                                    width: 150,
                                    height: 150,
                                  )
                                : Container()
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fill your bank AC details here'),
                            Divider(
                              thickness: 1,
                            ),
                            TextFormField(
                              controller: bankname,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              decoration: InputDecoration(
                                  labelText: 'Bank Name',
                                  labelStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  helperText: 'Enter Your Bank Name',
                                  helperStyle:
                                      Theme.of(context).textTheme.displaySmall),
                            ),
                            TextFormField(
                              controller: bankacnum,
                              decoration: InputDecoration(
                                  labelText: 'Account Number',
                                  labelStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  helperText:
                                      'Enter Your Account Number Carefully',
                                  helperStyle:
                                      Theme.of(context).textTheme.displaySmall),
                            ),
                            TextFormField(
                              controller: bankifsc,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.characters,
                              decoration: InputDecoration(
                                  labelText: 'IFSC Code',
                                  labelStyle:
                                      Theme.of(context).textTheme.displayMedium,
                                  helperText: 'Enter IFSC Code Carefully',
                                  helperStyle:
                                      Theme.of(context).textTheme.displaySmall),
                            ),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.black)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 25,
                                    ),
                                    Text(
                                      'UPLOAD BANK PROOF',
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 350,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          uploadKyc();
                        },
                        child: Text(
                          'SUBMIT KYC',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        //color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
        ),
      ),
    );
    throw UnimplementedError();
  }
}
