import 'package:flutter/material.dart';
import 'package:oyee11/Widgets/text_field_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundedPasswordField extends StatefulWidget {

  final String hintText;
  final TextEditingController controller;
  const RoundedPasswordField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isSeen = true;

  IconData Seen = FontAwesomeIcons.eyeSlash;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: isSeen,
        style: TextStyle(
            fontFamily: 'ProductSans-Thin', fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            Icons.lock,
            color: Colors.redAccent,
          ),
          suffixIcon: GestureDetector(
            onTap: (){
              setState(() {
                if(isSeen == true){
                  isSeen = false;
                  Seen = FontAwesomeIcons.eye;
                }
                else{
                  isSeen = true;
                  Seen = FontAwesomeIcons.eyeSlash;
                }
              });
            },
            child: Icon(
              Seen,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
