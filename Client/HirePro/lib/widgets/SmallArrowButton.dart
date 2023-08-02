import 'package:flutter/material.dart';

class SmallArrowButton extends StatelessWidget {
  SmallArrowButton(this.color, this.icon, this.navigation);
  final VoidCallback navigation;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 41,
      width: 51,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        highlightElevation: 0,
        highlightColor: Color.fromARGB(255, 253, 171, 77),
        onPressed: navigation,
        fillColor:color,
        child: Center(child: Icon(icon)),
      ),
    );
  }
}
