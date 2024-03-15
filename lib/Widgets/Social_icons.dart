import 'package:flutter/material.dart';

class SocialIcons extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocialIcons({
    Key? key,
    required this.iconSrc,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2, color: Colors.white),
              shape: BoxShape.circle),
          child: Image.asset(
            iconSrc,
            height: 20,
            width: 20,
          )),
    );
  }
}
