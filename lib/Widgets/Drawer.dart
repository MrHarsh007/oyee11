import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oyee11/pages/MorePage.dart';
import 'package:oyee11/pages/MorePages/howtoplay.dart';
import 'package:oyee11/pages/Payments/Invitefriends.dart';
import 'package:oyee11/pages/Payments/Rewards.dart';
import 'package:oyee11/pages/SportsdataPages/Point_system.dart';
import 'package:oyee11/pages/Payments/My_funds.dart';
import 'package:oyee11/pages/Starting/changepassword.dart';
import 'package:oyee11/pages/User/User_Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Drawer(
     child: SingleChildScrollView(
       child: Column(
         children: [
           Container(
             height: 300,
             child: Padding(
               padding: const EdgeInsets.only(top: 100.0),
               child: Column(
                 children: [
                   Container(
                     height: 120,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       image: DecorationImage(
                         image: AssetImage('assets/vk.jpg'),
                         fit: BoxFit.contain
                       )
                     ),
                   ),
                   SizedBox(height: 15,),
                   Text('Virat Kohli',style: Theme.of(context).textTheme.displayLarge,),
                   Text('Level 5',style: Theme.of(context).textTheme.displayMedium,),
                   SizedBox(height: 2,),
                   Text('viratkohli@gmail.com',style: Theme.of(context).textTheme.displayMedium,)
                 ],
               ),
             ),
           ),
           GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> new MyFunds()));
             },
             child: ListTile(
               title: Text('My Funds',style: Theme.of(context).textTheme.displayLarge,),
               leading: FaIcon(FontAwesomeIcons.wallet,color: Colors.black,),
               subtitle: Text('Tap for balance',style: Theme.of(context).textTheme.displayMedium,)
             ),
           ),
           GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> new Invite()));
             },
             child: ListTile(
               title: Text('Invite And Collect',style: Theme.of(context).textTheme.displayLarge,),
               leading: Icon(Icons.monetization_on,color: Colors.black,),
             ),
           ),
           GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> new Rewards()));
             },
             child: ListTile(
               title: Text('My Coupons And Offers',style: Theme.of(context).textTheme.displayLarge,),
               leading: Icon(Icons.card_giftcard,color: Colors.black,),
             ),
           ),
           Divider(thickness: 2,),
           GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> new HTPlay()));
             },
             child: ListTile(
               title: Text('How to play',style: Theme.of(context).textTheme.displayLarge,),
               leading: FaIcon(FontAwesomeIcons.gamepad,color: Colors.black,),
             ),
           ),
           GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> new Profile()));
             },
             child: ListTile(
               title: Text('My Profile',style: Theme.of(context).textTheme.displayLarge,),
               leading: FaIcon(Icons.person,color: Colors.black,),
             ),
           ),
           GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> new MorePage()));
             },
             child: ListTile(
               title: Text('More Information',style: Theme.of(context).textTheme.displayLarge,),
               leading: FaIcon(Icons.more_vert,color: Colors.black,),
             ),
           ),
           Divider(thickness: 2,),
           GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> new Pointsystem()));
             },
             child: ListTile(
               title: Text('Point System',style: Theme.of(context).textTheme.displayLarge,),
               leading: FaIcon(Icons.control_point_duplicate,color: Colors.black,),
             ),
           ),
           GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> new ChangePassword()));
             },
             child: ListTile(
               title: Text('Change Password',style: Theme.of(context).textTheme.displayLarge,),
               leading: FaIcon(Icons.lock,color: Colors.black,),
             ),
           ),
           GestureDetector(
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=> new MorePage()));
             },
             child: ListTile(
               onTap: () async{
                 final sharedPreferences = await SharedPreferences.getInstance();
                 sharedPreferences.remove('token');
                 sharedPreferences.remove('userid');
                 Fluttertoast.showToast(msg: 'Logout Successfully');
                 SystemNavigator.pop();
               },
               title: Text('Logout',style: Theme.of(context).textTheme.displayLarge,),
               leading: FaIcon(Icons.logout,color: Colors.black,),
             ),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Version',style: Theme.of(context).textTheme.displayMedium,),
                 Text('1.0',style: Theme.of(context).textTheme.displayMedium,)
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