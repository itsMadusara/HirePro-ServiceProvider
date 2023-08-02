import 'package:flutter/material.dart';
import 'package:hire_pro/constants.dart';

class CheckIconLarge extends StatelessWidget {
  const CheckIconLarge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Center(
        child: Icon(
          Icons.check_circle,
          size: 70,
          color: Colors.black,
        ),
      ),

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[200], // Background color of the circle
        border: Border.all(color: kMainYellow, width: 2), // Add a border
      ),

    );
  }
}

