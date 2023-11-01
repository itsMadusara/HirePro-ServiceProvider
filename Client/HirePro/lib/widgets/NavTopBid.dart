import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/NavButton.dart';
import '../constants.dart';

class NavTopBid extends StatelessWidget {
  NavTopBid(this.button1, this.button2, this.nav1, this.nav2);
  final Color button1;
  final Color button2;
  final VoidCallback nav1;
  final VoidCallback nav2;

  late Color text;
  Color textColor(Color buttonColor) {
    if (buttonColor == kMainYellow) {
      return Colors.white;
    }

    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NavButton("Bid", nav1, button1, textColor(button1)),
        NavButton("Waiting", nav2, button2, textColor(button2)),
      ],
    );
  }
}