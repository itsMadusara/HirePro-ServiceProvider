import 'package:flutter/material.dart';
import 'package:hire_pro/widgets/NavButton.dart';
import '../constants.dart';

class NavTop extends StatelessWidget {
  NavTop(this.button1, this.button2, this.button3, this.nav1, this.nav2,
      this.nav3);
  final Color button1;
  final Color button2;
  final Color button3;
  final VoidCallback nav1;
  final VoidCallback nav2;
  final VoidCallback nav3;

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
        NavButton("Hire", nav1, button1, textColor(button1)),
        NavButton("Ongoing", nav2, button2, textColor(button2)),
        NavButton("Categories", nav3, button3, textColor(button3)),
      ],
    );
  }
}
