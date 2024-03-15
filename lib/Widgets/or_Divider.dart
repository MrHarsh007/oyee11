import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'OR',
              style: TextStyle(
                  fontFamily: 'ProductSans-Thin',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          buildDivider()
        ],
      ),
    );
    throw UnimplementedError();
  }

  Expanded buildDivider() {
    return Expanded(
        child: Divider(
      color: Colors.white,
      height: 1.5,
    ));
  }
}
