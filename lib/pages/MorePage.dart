import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyee11/pages/MorePages/Aboutuspage.dart';
import 'package:oyee11/pages/MorePages/Communityguidelines.dart';
import 'package:oyee11/pages/MorePages/TermsandConditions.dart';
import 'package:oyee11/pages/MorePages/contactus.dart';
import 'package:oyee11/pages/MorePages/howtoplay.dart';
import 'package:oyee11/pages/SportsdataPages/Extraactivites.dart';

import 'MorePages/FaQpage.dart';
import 'MorePages/Legality.dart';
import 'MorePages/Privacypolicy.dart';

class MorePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('More',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'ProductSans-Thin',color: Colors.white),),
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
    Navigator.of(context).pop();
          }
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 10,),
              ListTile(
                leading: IconButton(
                  icon: Icon(Icons.info_outline,color: Colors.black,size: 25,),
                  onPressed: (){
                  },
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new AboutUs()));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('About Us',style: TextStyle(fontFamily: 'ProductSans-Thin',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                    Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ],
                ),
              ),
              Divider(thickness: 1,color: Colors.grey[300],),
              ListTile(
                leading: IconButton(
                  icon: FaIcon(FontAwesomeIcons.teamspeak,color: Colors.black,size: 25,),
                  onPressed: (){
                  },
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new Contact()));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Contact Us',style: TextStyle(fontFamily: 'ProductSans-Thin',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                    Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ],
                ),
              ),
              Divider(thickness: 1,color: Colors.grey[300],),
              ListTile(
                leading: IconButton(
                  icon: Icon(Icons.rule_sharp,color: Colors.black,size: 25,),
                  onPressed: (){
                  },
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new TnC()));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Terms And Conditions',style: TextStyle(fontFamily: 'ProductSans-Thin',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                    Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ],
                ),
              ),
              Divider(thickness: 1,color: Colors.grey[300],),
              ListTile(
                leading: IconButton(
                  icon: Icon(Icons.question_answer,color: Colors.black,size: 25,),
                  onPressed: (){
                  },
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new FaQ()));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Frequently Asked Questions',style: TextStyle(fontFamily: 'ProductSans-Thin',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                    Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ],
                ),
              ),
              Divider(thickness: 1,color: Colors.grey[300],),
              ListTile(
                leading: IconButton(
                  icon: Icon(Icons.privacy_tip_outlined,color: Colors.black,size: 25,),
                  onPressed: (){
                  },
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new Privacy()));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Privacy Policy',style: TextStyle(fontFamily: 'ProductSans-Thin',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                    Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ],
                ),
              ),
              Divider(thickness: 1,color: Colors.grey[300],),
              ListTile(
                leading: IconButton(
                  icon: FaIcon(FontAwesomeIcons.gamepad,color: Colors.black,size: 25,),
                  onPressed: (){
                  },
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new HTPlay()));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('How To Play',style: TextStyle(fontFamily: 'ProductSans-Thin',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                    Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ],
                ),
              ),
              Divider(thickness: 1,color: Colors.grey[300],),
              ListTile(
                leading: IconButton(
                  icon: FaIcon(FontAwesomeIcons.hammer,color: Colors.black,size: 25,),
                  onPressed: (){
                  },
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new Legality()));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Legality',style: TextStyle(fontFamily: 'ProductSans-Thin',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                    Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ],
                ),
              ),
              Divider(thickness: 1,color: Colors.grey[300],),
              ListTile(
                leading: IconButton(
                  icon: FaIcon(FontAwesomeIcons.newspaper,color: Colors.black,size: 25,),
                  onPressed: (){
                  },
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new CG()));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Community Guidelines',style: TextStyle(fontFamily: 'ProductSans-Thin',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                    Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ],
                ),
              ),
              Divider(thickness: 1,color: Colors.grey[300],),
              ListTile(
                leading: IconButton(
                  icon: FaIcon(FontAwesomeIcons.globe,color: Colors.black,size: 25,),
                  onPressed: (){
                  },
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new ExtraAct()));
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Explore Cricket',style: TextStyle(fontFamily: 'ProductSans-Thin',fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
                    Icon(Icons.arrow_forward_ios,color: Colors.black,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }


}