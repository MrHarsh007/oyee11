import 'package:flutter/material.dart';
import 'package:oyee11/Widgets/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontFamily: 'ProductSans-Thin',
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            hintText: hintText,
            focusedBorder: InputBorder.none,
            icon: Icon(
              icon,
              color: Colors.redAccent,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
