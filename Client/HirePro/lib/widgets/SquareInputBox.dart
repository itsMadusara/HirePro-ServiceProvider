

import 'package:flutter/material.dart';
import 'package:emailjs/emailjs.dart';


class SquareInputBox extends StatefulWidget {
  @override
  _SquareInputBoxState createState() => _SquareInputBoxState();
}

class _SquareInputBoxState extends State<SquareInputBox> {
  
  @override
  Widget build(BuildContext context) {
   
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
